#define oneHzSample 1000000/maxSamplesNum  // sample for the 1Hz signal expressed in microseconds

// Include the required Wire library for I2C
#include <Wire.h>
#include <Tone.h>



#define  SAMPLES   32
#define  NSAMPLES   8192
#define  CEILING   4096
uint16_t wav0[SAMPLES];
uint16_t wav1[SAMPLES];
uint16_t wavn0[NSAMPLES];
uint16_t wavn1[NSAMPLES];
uint16_t temp = 0;
float   tfl = 0;  
String volume = "VOLUME";
String str = "12";

uint8_t noise_flag = 0;
uint8_t signal_off = 0;
uint8_t fpointer = 0;

int8_t up_down_freq = 0;
int8_t left_right = 0;

int8_t column = 0;


uint16_t timer = 0;
uint32_t timer_start = 0;
uint8_t signal_or_delay = 0; 

// frequency pars
#define  NCHAR  16
#define  NITEMS  10
char* freqstr[][NCHAR]={" Noise           "," 2 kHz          ", " 4 kHz          " " 6 kHz          ", " 8 kHz          ",
"12 kHz          ", "16 kHz          ","24 kHz          ","32 kHz          ","Random          "};
float freq[9] = {1000,2000,4000,6000,8000,12000,16000,24000,32000};

// volume pars
#define  N_VOL_ITEMS  44
int8_t up_down_vol = 0;
uint8_t rbyte = 0;





//Tone tone1;
int x = 0;
int y = 0;
byte skip = 1;

uint8_t flag = 1;

volatile int wave0 = 0, wave1 = 1;
volatile int wave2 = 2, wave3 = 3;
int wavel = 0, waver = 0;

const byte tout = 31;  
const byte tonepin = 3;  

int i = 0;
int sample;


void setup() {


  analogWriteResolution(12);  // set the analog output resolution to 12 bit (4096 levels)
  pinMode(tout, OUTPUT);
  digitalWrite(tout, LOW);  
  pinMode(3, OUTPUT);
  //digitalWrite(3, LOW);  


  CreateSineWaveTable0();
  CreateSineWaveTable1();
  CreateNoise();
  
  setupDAC();
  float freq_hz = 32000; // Target: 200kHz
  setupTC(freq_hz);
  NVIC_EnableIRQ(DACC_IRQn);


  Serial.begin(115200);

  // Start the I2C Bus as Slave on address 9
  Wire.begin(9); 
  // Attach a function to trigger when something is received.
  Wire.onReceive(receiveEvent);
  
}
void loop() {}
 
      
void receiveEvent(int bytes) 
{
    //digitalWrite(tout, HIGH);  

  x = Wire.read();    // read one character from the I2C
  y = Wire.read();    // read one character from the I2C
  skip = Wire.read();    // read one character from the I2C
  Serial.print(x);
  Serial.print(y);
  Serial.print(skip);
  Serial.println("-----");


dacc_set_channel_selection(DACC, 0);
dacc_disable_channel(DACC, 0);
dacc_set_channel_selection(DACC, 1);
dacc_disable_channel(DACC, 1);


if (y==2)    //TURN NOISE ON
  {

      if (x == 1)
      {
       dacc_set_channel_selection(DACC, 0);
       dacc_enable_channel(DACC, 0);
      }
      else
      {
       dacc_set_channel_selection(DACC, 1);
       dacc_enable_channel(DACC, 1);
      }
      fpointer = 0;
      update_frequency();            
      return;
  }
  else
  {    

switch (skip)
      {
         case 1:  //2k

          fpointer = 1;
          update_frequency();            
         
           break;
         case 2:   //4k
          fpointer = 2;
          update_frequency();
          break;
          
         case 3:   //6k
          fpointer = 3;
          update_frequency();
          break;
          
         case 4:   //8k
          fpointer = 4;
          update_frequency();
          break;
          
         case 6:   //12k
          fpointer = 5;
          update_frequency();
          break;
          
         case 8:   //16k
          fpointer = 6;
          update_frequency();
          break;
          
         case 12:   //24k
          fpointer = 7;
          update_frequency();
          break;
         case 16:   //32k
          fpointer = 8;
          update_frequency();
          break;

       }


if (x == 1)
{
      if (bitRead(y,0) == 1)
      {
       dacc_set_channel_selection(DACC, 0);
       dacc_enable_channel(DACC, 0);
      }
}

if (x == 2)
{
      if (bitRead(y,0) == 1)
      {
        dacc_set_channel_selection(DACC, 1);
        dacc_enable_channel(DACC, 1);
      }
}
}
}



// Incantations for DAC set-up for analogue wave using DMA and timer interrupt.
// http://asf.atmel.com/docs/latest/sam3a/html/group__sam__drivers__dacc__group.html
void setupDAC() {
  pmc_enable_periph_clk (DACC_INTERFACE_ID) ;   // Start clocking DAC.
  dacc_reset(DACC);
  dacc_set_transfer_mode(DACC, 0);
  dacc_set_power_save(DACC, 0, 1);              // sleep = 0, fast wakeup = 1
  dacc_set_analog_control(DACC, DACC_ACR_IBCTLCH0(0x02) | DACC_ACR_IBCTLCH1(0x02) | DACC_ACR_IBCTLDACCORE(0x01));
  dacc_set_trigger(DACC, 1);
//  dacc_set_channel_selection(DACC, 1);
//  dacc_enable_channel(DACC, 1);
  dacc_set_channel_selection(DACC, 0);
  //dacc_enable_channel(DACC, 0);
  NVIC_DisableIRQ(DACC_IRQn);
  NVIC_ClearPendingIRQ(DACC_IRQn);
  NVIC_EnableIRQ(DACC_IRQn);
  dacc_enable_interrupt(DACC, DACC_IER_ENDTX);
  DACC->DACC_PTCR = 0x00000100;
}

void DACC_Handler(void) {
  if (noise_flag == 1)
  {
    DACC->DACC_TNPR = (uint32_t) wavn0;
    DACC->DACC_TNCR = NSAMPLES;                // Number of counts until Handler re-triggered
  }
  else
  {
    DACC->DACC_TNPR = (uint32_t) wav0;
    DACC->DACC_TNCR = SAMPLES;                // Number of counts until Handler re-triggered
  }
}

// System timer clock set-up for DAC wave.
void setupTC (float freq_hz) {  
  int steps = (420000000UL / freq_hz) / (10*SAMPLES);
  pmc_enable_periph_clk(TC_INTERFACE_ID);
  TcChannel * t = &(TC0->TC_CHANNEL)[0];
  t->TC_CCR = TC_CCR_CLKDIS;                // Disable TC clock.
  t->TC_IDR = 0xFFFFFFFF;
  t->TC_SR;                                 // Clear status register.
  t->TC_CMR =                               // Capture mode.
              TC_CMR_TCCLKS_TIMER_CLOCK1 |  // Set the timer clock to TCLK1 (MCK/2 = 84MHz/2 = 48MHz).
              TC_CMR_WAVE |                 // Waveform mode.
              TC_CMR_WAVSEL_UP_RC;          // Count up with automatic trigger on RC compare.
  t->TC_RC = steps;                         // Frequency.
  t->TC_RA = steps /2;                      // Duty cycle (btwn 1 and RC).
  t->TC_CMR = (t->TC_CMR & 0xFFF0FFFF) | 
              TC_CMR_ACPA_CLEAR |           // Clear TIOA on counter match with RA0.
              TC_CMR_ACPC_SET;              // Set TIOA on counter match with RC0.
  t->TC_CCR = TC_CCR_CLKEN | TC_CCR_SWTRG;  // Enables the clock if CLKDIS is not 1.
}


//--------------------------------------------------------------------------------------------



void CreateSineWaveTable0() {
 for(int i = 0; i < SAMPLES; i++) 
  {
       tfl =  CEILING/2 + (CEILING/2)*sin(float(2*3.1416)*float(i+1)/SAMPLES);
       //Serial.println(tfl);
       temp = round(tfl);
//       Serial.println(temp);
       if (temp>(CEILING-1))
          temp = CEILING-1;

      wav0[i] = temp;
  }
}


void CreateSineWaveTable1() {
 for(int i = 0; i < SAMPLES; i++) 
  {
       tfl =  CEILING/2 + (CEILING/2)*sin(float(2*3.1416)*float(i+1)/SAMPLES);
       //Serial.println(tfl);
       temp = round(tfl);
//       Serial.println(temp);
       if (temp>(CEILING-1))
          temp = CEILING-1;

      wav1[i] = temp;
  }
}




void CreateNoise() {
 for(int i = 0; i < NSAMPLES; i++) 
  {
//       tfl =  CEILING/2 + (CEILING/2)*sin(float(2*3.1416)*float(i+1)/SAMPLES);
//       tfl =  CEILING/2 + (CEILING/2)*sin(float(2*3.1416)*float(i+1)/SAMPLES);
        tfl = random(0, 4095);
       //Serial.println(tfl);
       temp = round(tfl);
//       Serial.println(temp);
       if (temp>(CEILING-1))
          temp = CEILING-1;

      wavn0[i] = temp;
      wavn1[i] = temp;
  }
}

void CreateTriangleWaveTable1() {
  for(int i = 0; i < SAMPLES; i++) { int16_t v = (((1.0 / (SAMPLES - 1)) * (SAMPLES - 1 - i)) * CEILING); if (i > round(SAMPLES/2)) v*=-1;
    wav1[i] = v;
  }
}

// ------------------------------------------------------

void       update_frequency()            
{

      if (fpointer > 0)
      {

        if (fpointer == NITEMS-1)
        {
         // noise_flag = 0;
         // setupTC(10);
        }
        else
        {
          noise_flag = 0;
          setupTC(freq[fpointer]);
        }
      }
      else
      {
        noise_flag = 1;
        float freq_hz = 100;
        setupTC(freq_hz);
      }
      NVIC_EnableIRQ(DACC_IRQn);
      dacc_enable_interrupt(DACC, DACC_IER_ENDTX);
}
