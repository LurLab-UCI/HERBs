//#define DEBUG

// define this with full rig (all the DACs)
#define FULL_RIG
// SIMPLE_RIG is a rig with no singler dac
//#define SIMPLE_RIG
//define this if running matlab that handles fractional reward durations
//#define FRACTIONAL_REWARD_DURATION

/*
 IF USING SERVO_TIMERS_45 
CENTER servo connected to pin 8
LR servo connected to pin 46
DUE reset connected to pin 28
  OTHERWISE
CENTER servo connected to pin 6
LR servo connected to pin 7
DUE reset connected to pin 8
*/

#define SERVO_TIMERS_45

#ifdef SERVO_TIMERS_45
  #include <Servo_Hardware_PWM.h>
  Servo myServoC;
  Servo myServoLR;
 #else
  #include <Servo.h>
  Servo myservoC;
  Servo myservoLR;
 #endif 


// define this if audio amp not available
//#define NO_AUDIO_AMPLIFIER

//define light panels used
#define LEFT_LED_PANEL
#define CENTER_LED_PANEL
#define RIGHT_LED_PANEL
                                    
#include <MsTimer2.h>
#include "TimerThree.h"
#include <Wire.h>
#include <Adafruit_GFX.h>
#include <Adafruit_IS31FL3731.h>
#include <Adafruit_MCP4728.h>
#include <Adafruit_MCP4725.h>


//  light panels  ------------------------------------
// light panel i2c addresses
uint16_t Left_Panel =  0x76;
uint16_t Center_Panel =  0x74;
uint16_t Right_Panel =  0x75;

Adafruit_IS31FL3731 ledmatrixL = Adafruit_IS31FL3731();
Adafruit_IS31FL3731 ledmatrixC = Adafruit_IS31FL3731();
Adafruit_IS31FL3731 ledmatrixR = Adafruit_IS31FL3731();

//  dacs  ------------------------------------
Adafruit_MCP4728 dac;
Adafruit_MCP4725 dac_single;

//-------------------------------------------------------------------------------
// DAC signal level definitions for channels C and D

#define C_

#define tbyte1_Panel_C  2500
#define tbyte0_Panel_C  2000
#define tbyte4_Panel_C  1800   // full panel

#define tbyte1_Panel_R  3500
#define tbyte0_Panel_R  3000
#define tbyte5_Panel_R  4000
#define tbyte4_Panel_R  4000   // full panel

#define tbyte1_Panel_L  1500
#define tbyte0_Panel_L  1000
#define tbyte5_Panel_L  0500
#define tbyte4_Panel_L  0250    //full panel

#define left_right_vertical_L       0500
#define right_to_left_vertical_L    1000
#define bottom_to_top_horizontal_L  1500
#define top_to_bottom_horizontal_L  2000

#define left_right_vertical_R       2500
#define right_to_left_vertical_R    3000
#define bottom_to_top_horizontal_R  3500
#define top_to_bottom_horizontal_R  4000

// combo mode
#define stripes_horizontal_L        500  
#define stripes_vertical_L          1000  
#define stripes_angled_P45_L        1500  
#define stripes_angled_M45_L        2000  
#define stripes_horizontal_R        2500  
#define stripes_vertical_R          3000  
#define stripes_angled_P45_R        3500  
#define stripes_angled_M45_R        4000  
 
// reward indicator values
#define D_reward_L 1000   // 1000 mV
#define D_reward_C 2000
#define D_reward_R 3000

//  audio amp  ------------------------------------
#define MAX9744_I2CADDR 0x4B

// ---------------------------------------------------------------------------------
//    memory allocations

uint16_t x0 = 0;
uint16_t y0 = 15;
uint16_t lp = 0;
uint32_t  reward_pulse_C = 0; 
uint32_t  reward_pulse_R = 0; 
uint32_t  reward_pulse_L = 0; 
uint32_t  airpuff_pulse = 0; 
uint32_t  light_pattern_speed = 20;
uint8_t  light_pattern_brightness = 4;
uint32_t  tre = 0;

int8_t  vol = 0; 
int8_t  oldvol = 5; 
int8_t  int_flag1 = 0; 
int8_t  int_flag2 = 0; 
int8_t  int_flag3 = 0; 
int8_t int_active = 0;

uint16_t temp = 0;
uint16_t temp1 = 0;
uint16_t temp2 = 0;
uint16_t temp3 = 0;
uint16_t temp4 = 0;
uint32_t int_disable_start = 0;
uint32_t temp_time = 0;
uint8_t tempbyte = 0;
uint8_t dac_val = 0;
uint16_t dac_val_audio = 0;

uint16_t mbank;
uint16_t ontime;
uint16_t offtime;

uint16_t to_due;

int8_t  int1_lvl = 0; 
int8_t  int2_lvl = 0; 
int8_t  int3_lvl = 0; 
int8_t  int1_lvl_old = 0; 
int8_t  int2_lvl_old = 0; 
int8_t  int3_lvl_old = 0; 
uint8_t  temp_byte = 0; 
uint8_t  temp_byte1 = 0; 
uint8_t  left_right_flag = 0;
uint8_t  noise_tone_flag = 0;
uint8_t  panel_mode = 0;
uint8_t  panel_mode_L = 0;
uint8_t  panel_mode_R = 0;
uint8_t  panel_mode_C = 0;

uint8_t bright_dark_L = 7;
uint8_t bright_dark_R = 7;
uint8_t single_panel_L = 0;
uint8_t single_panel_R = 0;
uint8_t light_tone_flag = 0;

uint16_t visual_half_cycle = 0;
uint16_t auditory_half_cycle = 0;
uint8_t  number_of_visual_cycles = 0;
uint8_t  number_of_auditory_cycles = 0;
uint32_t visual_cycle_start = 0;
uint32_t auditory_cycle_start = 0;
uint8_t audio_on = 0;
uint8_t visual_on = 0;

uint8_t  left_right_flag_visual = 0;
uint8_t  left_right_flag_auditory = 0;
uint16_t visual_start_delay = 0;
uint16_t auditory_start_delay = 0;

uint32_t visual_delay_start_time = 0;
uint8_t  visual_start_pending = 0;  
uint32_t auditory_delay_start_time = 0;
uint8_t  auditory_start_pending = 0;  

uint8_t skip = 1;
uint8_t tb0 = 0;
uint8_t tb1 = 0;
uint8_t tb2 = 0;
uint8_t tb3 = 0;
uint8_t CHC_zeroflag = 0;
uint8_t CHD_zeroflag = 0;

// for Decision Making
uint16_t visual_low_cycle_L = 0;
uint16_t visual_high_cycle_L = 0;
uint16_t visual_low_cycle_R = 0;
uint16_t visual_high_cycle_R = 0;
uint16_t visual_low_cycle_C = 0;
uint16_t visual_high_cycle_C = 0;
uint8_t  number_of_visual_cycles_L = 0;
uint8_t  number_of_visual_cycles_R = 0;
uint8_t  number_of_visual_cycles_C = 0;
uint32_t visual_cycle_start_L = 0;
uint32_t visual_cycle_start_R = 0;
uint32_t visual_cycle_start_C = 0;
uint8_t cycle_type_L = 0;
uint8_t cycle_type_R = 0;
uint8_t cycle_type_C = 0;

uint16_t auditory_low_cycle_L = 0;
uint16_t auditory_high_cycle_L = 0;
uint16_t auditory_low_cycle_R = 0;
uint16_t auditory_high_cycle_R = 0;
uint8_t  number_of_auditory_cycles_L = 0;
uint8_t  number_of_auditory_cycles_R = 0;
uint32_t auditory_cycle_start_L = 0;
uint32_t auditory_cycle_start_R = 0;
uint8_t  mbank_L = 0;
uint8_t  mbank_R = 0;
uint8_t cycle_type_auditory_L = 0;
uint8_t cycle_type_auditory_R = 0;

uint8_t nstripes_L = 1;
uint8_t nstripes_R = 1;

volatile byte state = LOW;
uint8_t  xstart = 3;
uint8_t  ystart = 0;
uint8_t  xstop = 6;
uint8_t  ystop = 8;
uint8_t  noise_active = 0;
uint32_t pwidth = 100;
uint16_t debounce_count = 0;

uint8_t  light_panels_present = 0;

uint8_t tl;
uint8_t th;


//=========================================================
//pin assignments
const byte Tone0 = 47;  
const byte Tone1 = 49;  
const byte AirPuff = 48;
const byte RewardL = 50;  
const byte RewardR = 51;  
const byte RewardC = 52;  
const byte Test1   = 34;  
const byte light_panel_signal_L = 38;  
const byte light_panel_signal_R = 40;  


const byte reset_indicator = 44;  
const byte lick_indicator_C = 10;
const byte LickCenter = 18;
const byte LickRight = 19;
const byte lick_indicator_R = 11;
const byte LickLeft = 2;
const byte lick_indicator_L = 12;
const byte cclockpin = 22;     // default to pin 13

#ifdef SERVO_TIMERS_45
  const byte due_reset = 28;
#else
  const byte due_reset = 8;
#endif

const byte dac_write_indicator = 33;
const byte dac_write_indicator_audio = 35;
const byte response_window_indicator = 37;
const byte audio_mute = 44;


//end of pin assignments
//=========================================================
// serial receive character decode functions

//    'a'  set audio volume
//    'b'  DM Left panel mode
//    'c'  write to dac
//    'd'  send air puff
//    'e'  tone 0 on/off
//    'f'  tone 1 on/off
//    'g'  write to single dac
//    'i'  move actuator 1
//    'j'  move actuator 2
//    'k'  valve control
//    'l'  auditory sequence
//    'm'  DM left audio   
//    'n'  DM right audio     
//    'o'  response_window_indicator
//    'p'  enable interrupts
//    'q'  reward duration C
//    'r'  Light Panel  Control
//    's'
//    't'  audio off
//    'u'  air puff pulse duration
//    'v'  reward duration L
//    'w'  reward duration R
//    'x'  reward R
//    'y'  reward L
//    'z'  reward C
//    '?'  left/right flag
//    '{'  light_pattern_speed
//    '}'  light_pattern_brightness
//    '('  moving bars mode
//    '#'  Pulse durations
//    '^'  test print
//    '~'
//    '!'  enable interrupts
//    '@'  small panels to dark state
//    '$'
//    '%'
//    '&'  DM Center panel mode
//    ')'
//    '+'  DM Right panel mode
//    '-'  sensory Stimulus panel mode
//    '='  set tone frequency
//    '['
//    ']'
//    '\'
//    ';'  light panel initialization control
//    ':'  stop all timers and lights snd audio
//    '''
//    '"'  initialize light panels for gonogo
//    ','
//    '.'
//    '/'
//    '<'
//    '>'
//=========================================================

#define pg_dark 7
#define pg_small 3
#define pg_full 4


//============================================================================
// standard Arduino setup()

void setup()
{
  
    pinMode(due_reset, OUTPUT);
    pinMode(Tone0, OUTPUT);
    pinMode(Tone1, OUTPUT);
    pinMode(RewardL, OUTPUT);
    pinMode(RewardC, OUTPUT);
    pinMode(RewardR, OUTPUT);
    pinMode(AirPuff, OUTPUT);
    pinMode(cclockpin, OUTPUT);
    pinMode(reset_indicator, OUTPUT);
    pinMode(dac_write_indicator, OUTPUT);
    pinMode(dac_write_indicator_audio, OUTPUT);
    pinMode(response_window_indicator, OUTPUT);
    pinMode(Test1, OUTPUT);
    pinMode(light_panel_signal_L, OUTPUT);
    pinMode(light_panel_signal_R, OUTPUT);
    
    digitalWrite(due_reset, LOW);
    digitalWrite(Test1, LOW);
    digitalWrite(light_panel_signal_L, LOW);
    digitalWrite(light_panel_signal_R, LOW);
    digitalWrite(response_window_indicator, LOW);
    
    digitalWrite(Tone0, LOW);   // turn the LED on (HIGH is the voltage level)
    digitalWrite(Tone1, LOW);   // turn the LED on (HIGH is the voltage level)
    digitalWrite(RewardL, LOW);   // turn the LED on (HIGH is the voltage level)
    digitalWrite(RewardC, LOW);   // turn the LED on (HIGH is the voltage level)
    digitalWrite(RewardR, LOW);   // turn the LED on (HIGH is the voltage level)
    digitalWrite(AirPuff, LOW);   // turn the LED on (HIGH is the voltage level)
    digitalWrite(reset_indicator, LOW);   // turn the LED on (HIGH is the voltage level)
    digitalWrite(dac_write_indicator, LOW);   
    digitalWrite(dac_write_indicator_audio, LOW);   


    while (!Serial);
    delay(100);
    Wire.begin();    
    Serial.begin(115200);
    Serial3.begin(115200);

    

    pinMode(LickCenter, INPUT_PULLUP);
    pinMode(LickRight, INPUT_PULLUP);
    pinMode(LickLeft, INPUT_PULLUP);
    pinMode(lick_indicator_C, OUTPUT);
    pinMode(lick_indicator_R, OUTPUT);
    pinMode(lick_indicator_L, OUTPUT);
    digitalWrite(lick_indicator_C, LOW);
    digitalWrite(lick_indicator_R, LOW);
    digitalWrite(lick_indicator_L, LOW);

    attachInterrupt(digitalPinToInterrupt(LickCenter), lick1, RISING);
    attachInterrupt(digitalPinToInterrupt(LickRight), lick2, RISING);
    attachInterrupt(digitalPinToInterrupt(LickLeft), lick3, RISING);

    int1_lvl = digitalRead(LickCenter);
    int1_lvl_old = digitalRead(LickCenter);
    int2_lvl = digitalRead(LickRight);
    int2_lvl_old = digitalRead(LickRight);
    int3_lvl = digitalRead(LickLeft);
    int3_lvl_old = digitalRead(LickLeft);

   

//=======================================================
//attach the two servos
#ifdef SERVO_TIMERS_45
  myServoC.attach(8);  // attaches the servo on pin 8 to the servo object
  myServoLR.attach(46);  // attaches the servo on pin 46 to the servo object
//force servos to full retract
  temp = 180;
  myServoC.write(temp);              // 
  temp = 0;
  myServoLR.write(temp);              // 
#else
  myservoC.attach(6);  // attaches the servo on pin 8 to the servo object
  myservoLR.attach(7);  // attaches the servo on pin 46 to the servo object
//force servos to full retract
  temp = 180;
  myservoC.write(temp);              // 
  temp = 0;
  myservoLR.write(temp);              // 
#endif

   
//=======================================================
//  set volume to 0 on power-up
  vol = 0;
  setvolume(vol);
  

// connection to light panels

#ifndef DEBUG

    light_panels_present = 1;


    #ifdef LEFT_LED_PANEL

    if (! ledmatrixL.begin(Left_Panel)) {
      Serial.println("IS31 Left not found");
      light_panels_present = 0;
    //    while (1);
    }
    #endif  

    #ifdef RIGHT_LED_PANEL

    if (! ledmatrixR.begin(Right_Panel)) {
      Serial.println("IS31 Right not found");
      light_panels_present = 0;
    //  while (1);
    }
    #endif

    #ifdef CENTER_LED_PANEL

    if (! ledmatrixC.begin(Center_Panel)) {
      Serial.println("IS31 Center not found");
        light_panels_present = 0;
    //   while (1);

    }
    #endif
#endif


#ifdef  FULL_RIG
  // initialize the dac
  // Try to initialize!
  if (!dac.begin()) {
    Serial.println("Failed to find MCP4728 chip");
    while (1) {
      delay(10);
    }
  }
      
//    Serial.println("found MCP4728 chip");
    
    // set all dac voltages to 0
    dac.setChannelValue(MCP4728_CHANNEL_A, 0, MCP4728_VREF_INTERNAL,MCP4728_GAIN_2X);
    dac.setChannelValue(MCP4728_CHANNEL_B, 0, MCP4728_VREF_INTERNAL,MCP4728_GAIN_2X);
    dac.setChannelValue(MCP4728_CHANNEL_C, 0, MCP4728_VREF_INTERNAL,MCP4728_GAIN_2X);
    dac.setChannelValue(MCP4728_CHANNEL_D, 0, MCP4728_VREF_INTERNAL,MCP4728_GAIN_2X);
    

#ifndef SIMPLE_RIG
//    set dac 4725 to 0
  dac_single.begin(0x62);
  dac_single.setVoltage(00, false);          
#endif    
#endif


    if (light_panels_present == 1)
    {
      initialize_light_panels();
    }
    
    
    
    //initialize reward delivery timers
    // for some reason timer3 needs to be initializes this way for the pulse to work immediately
    // on the first try
    
    StartPulse(100,RewardL);
    delay(1);
    StartPulse(100,RewardL);
    delay(1);
    StartPulse(100,RewardL);
    delay(1);
    
    StartPulse(100,RewardC);
    delay(1);
    StartPulse(100,RewardC);
    delay(1);
    StartPulse(100,RewardC);
    delay(1);
    
    StartPulse(100,RewardR);
    delay(1);
    StartPulse(100,RewardR);
    delay(1);
    StartPulse(100,RewardR);
    delay(1);
    
    //Timer3.initialize(100);
    //Timer3.attachInterrupt(StopPulse);
    //Timer3.start();
    reward_pulse_L = 10000;
    reward_pulse_C = 10000;
    reward_pulse_R = 10000;
    airpuff_pulse = 10000;   
    
    
    digitalWrite(reset_indicator, HIGH);   // turn the LED on (HIGH is the voltage level)
    delay(12);
//    digitalWrite(reset_indicator, LOW);   // turn the LED on (HIGH is the voltage level)
    oldvol = vol;
    
    static boolean output = HIGH;
    pinMode(cclockpin, OUTPUT);
    digitalWrite(cclockpin, LOW);
    
    //  MsTimer2::set(16.67, flash); // 500ms period
    MsTimer2::set(20, flash); // 40ms period
    //MsTimer2::start();
    if (light_panels_present == 1)
      Serial.println("Rset1");
      else
      Serial.println("Rset0");
      
    digitalWrite(light_panel_signal_L, LOW);
    digitalWrite(light_panel_signal_R, LOW);
    
    int_disable_start = millis();
    int_active = 0;
    
    digitalWrite(due_reset, HIGH);
    tone_OFF(3);
    
  
}

// -----------------------------------------------
void loop() {

  
#ifdef FULL_RIG
    if (CHD_zeroflag == 1)
    {
      CHD_zeroflag = 0;
      dac.setChannelValue(MCP4728_CHANNEL_D, 0, MCP4728_VREF_INTERNAL,MCP4728_GAIN_2X);
    }
#endif
        
  
    if (vol != oldvol)
    {
      setvolume(vol);
      oldvol = vol;
    }
    
// check visual DM  Left =====================================================
    temp_time = millis();

    if (number_of_visual_cycles_L > 0)
    {
        temp1 = temp_time - visual_cycle_start_L;

        if (cycle_type_L == 1)
        // high part of cycle
        {
          if (temp1 > visual_high_cycle_L)
          {
            // start dark
             ledmatrixL.setFrame(pg_dark);
             light_panel_L(pg_dark,0);
             visual_cycle_start_L = temp_time;
             cycle_type_L = 0;
          }
        }
        else
        {
          //low part of cycle
            if (temp1 > visual_low_cycle_L)
            {
              //start low part of cycle if more to do
              number_of_visual_cycles_L = number_of_visual_cycles_L - 1;

              if (number_of_visual_cycles_L >0)
                {
                   ledmatrixL.setFrame(panel_mode_L);
                   light_panel_L(panel_mode_L,dac_val);
                  visual_cycle_start_L = temp_time;
                  cycle_type_L = 1;
                }
            }
       }
    }

// check visual DM  Right =====================================================
    temp_time = millis();

    if (number_of_visual_cycles_R > 0)
    {
        temp1 = temp_time - visual_cycle_start_R;

        if (cycle_type_R == 1)
        // high part of cycle
        {
          if (temp1 > visual_high_cycle_R)
          {
            // start dark
             ledmatrixR.setFrame(pg_dark);
             light_panel_R(pg_dark,0);
             visual_cycle_start_R = temp_time;
             cycle_type_R = 0;
          }
        }
        else
        {
          //low part of cycle
            if (temp1 > visual_low_cycle_R)
            {
              //start low part of cycle if more to do
              number_of_visual_cycles_R = number_of_visual_cycles_R - 1;

              if (number_of_visual_cycles_R >0)
                {
                  ledmatrixR.setFrame(panel_mode_R);
                  light_panel_R(panel_mode_R,dac_val);
                  visual_cycle_start_R = temp_time;
                  cycle_type_R = 1;
                }
            }
       }
    }
// check visual DM  Center =====================================================
    temp_time = millis();

    if (number_of_visual_cycles_C > 0)
    {
        temp1 = temp_time - visual_cycle_start_C;

        if (cycle_type_C == 1)
        // high part of cycle
        {
          if (temp1 > visual_high_cycle_C)
          {
            // start dark
             ledmatrixC.setFrame(pg_dark);
             light_panel_C(pg_dark,0);
             visual_cycle_start_C = temp_time;
             cycle_type_C = 0;
          }
        }
        else
        {
          //low part of cycle
            if (temp1 > visual_low_cycle_C)
            {
              //start low part of cycle if more to do
              number_of_visual_cycles_C = number_of_visual_cycles_C - 1;

              if (number_of_visual_cycles_C >0)
                {
                  ledmatrixC.setFrame(panel_mode_C);
                  light_panel_C(panel_mode_C,dac_val);
                  visual_cycle_start_C = temp_time;
                  cycle_type_C = 1;
                }
            }
       }
    }

// check auditory DM  Left =====================================================
    temp_time = millis();

    if (number_of_auditory_cycles_L > 0)
    {
        temp1 = temp_time - auditory_cycle_start_L;

        if (cycle_type_auditory_L == 1)
        // high part of cycle
        {
          if (temp1 > auditory_high_cycle_L)
          {
            // audio off
            uint8_t tb = 1;
            tone_OFF(tb);
            auditory_cycle_start_L = temp_time;
            cycle_type_auditory_L = 0;
          }
        }
        else
        {
          //low part of cycle
            if (temp1 > auditory_low_cycle_L)
            {
              //start low part of cycle if more to do
              number_of_auditory_cycles_L = number_of_auditory_cycles_L - 1;

              if (number_of_auditory_cycles_L >0)
                {
                  //audio on
                  uint8_t tb = 1;
                  tone_ON(tb,mbank_L);
//                  tone_ON(tb,1);
                  auditory_cycle_start_L = temp_time;
                  cycle_type_auditory_L = 1;
                }
            }
       }
    }

    
// check auditory DM  Right =====================================================
    temp_time = millis();

    if (number_of_auditory_cycles_R > 0)
    {
        temp1 = temp_time - auditory_cycle_start_R;

        if (cycle_type_auditory_R == 1)
        // high part of cycle
        {
          if (temp1 > auditory_high_cycle_R)
          {
            // audio off
             uint8_t tb = 2;
             tone_OFF(tb);
             auditory_cycle_start_R = temp_time;
             cycle_type_auditory_R = 0;
          }
        }
        else
        {
          //low part of cycle
            if (temp1 > auditory_low_cycle_R)
            {
              //start low part of cycle if more to do
              number_of_auditory_cycles_R = number_of_auditory_cycles_R - 1;

              if (number_of_auditory_cycles_R >0)
                {
                  //audio on
                  uint8_t tb = 2;
                  tone_ON(tb,mbank_R);
                  auditory_cycle_start_R = temp_time;
                  cycle_type_auditory_R = 1;
                }
            }
       }
    }


// check visual SS=====================================================
    temp_time = millis();

  if (visual_start_pending == 0)
  {

    if (number_of_visual_cycles > 0)
    {
        temp1 = temp_time - visual_cycle_start;
        if (temp1 > visual_half_cycle)
        {
          if (visual_on == 0)
          {
            number_of_visual_cycles = number_of_visual_cycles - 1;
            if (number_of_visual_cycles >0)
            {

              visual_on = 1;
              start_visual(left_right_flag_visual);
              visual_cycle_start = temp_time;
            }
          }
          else
          {
            visual_on = 0;
            #ifdef FULL_RIG
              dac.setChannelValue(MCP4728_CHANNEL_C, 0, MCP4728_VREF_INTERNAL,MCP4728_GAIN_2X);
            #endif
            digitalWrite(dac_write_indicator, LOW);   
            #ifdef LEFT_LED_PANEL
            ledmatrixL.setFrame(pg_dark);
            ledmatrixL.displayFrame(pg_dark);
            #endif
            #ifdef RIGHT_LED_PANEL
            ledmatrixR.setFrame(pg_dark);
            ledmatrixR.displayFrame(pg_dark);
            #endif
            visual_cycle_start = temp_time;
          }
        }
    }
  }


// check auditory SS=====================================================

    temp_time = millis();
      
  if (auditory_start_pending == 0)
  {
    if (number_of_auditory_cycles > 0)
    {
        temp1 = temp_time - auditory_cycle_start;
        if (temp1 > auditory_half_cycle)
        {
          if (audio_on == 0)
          {
            number_of_auditory_cycles = number_of_auditory_cycles - 1;
            if (number_of_auditory_cycles >0)
            {
              audio_on = 1;
              tone_ON(left_right_flag_auditory,mbank);
              auditory_cycle_start = temp_time;
            }
          }
          else
          {
            audio_on = 0;
            tone_OFF(left_right_flag_auditory);
            auditory_cycle_start = temp_time;
          }
        }
    }
  }

// check potential delayed items =====================================================

  if (visual_start_pending == 1)
  {

        if ((millis() - visual_delay_start_time)  > visual_start_delay)
          {
            visual_start_pending = 0;
            visual_on = 1;
            start_visual(left_right_flag_visual);
            visual_cycle_start = millis();
          }
  }
          
    
  if (auditory_start_pending == 1)
  {

        if ((millis() - auditory_delay_start_time)  > auditory_start_delay)
          {
            auditory_start_pending = 0;
            audio_on = 1;
            tone_ON(left_right_flag_auditory,mbank);
            auditory_cycle_start = millis();
          }
  }
          
  

//  if lick interrupts not active check if enough time has passed to make them active again
    if (int_active == 0)
    {
      //see how much time has passed since lick interrupts were made inactive
      temp_time = millis();
      temp_time = temp_time - int_disable_start;
      if (temp_time > 10)   // 50 ms
      {
        //  enable lick interrupts
            int_active = 1;
            digitalWrite(lick_indicator_C, LOW);
            digitalWrite(lick_indicator_R, LOW);
            digitalWrite(lick_indicator_L, LOW);

            // clear interrupt pending bits
            //EIFR = 0x1c;      //  EIFR = (1 << (INTF2 || INTF3 ||INTF3)); 
            EIFR = 0xff;      //  EIFR = (1 << (INTF2 || INTF3 ||INTF3)); 
            attachInterrupt(digitalPinToInterrupt(LickCenter), lick1, RISING);
            attachInterrupt(digitalPinToInterrupt(LickRight), lick2, RISING);
            attachInterrupt(digitalPinToInterrupt(LickLeft), lick3, RISING);
      }
    }
    
    //Check if serial data available
    if ( Serial.available())
    {
    decode_serial_data();
    }
    
  lp = lp + 1;  
}

// ------------------------------------------------------
//
// ------------------------------------------------------
//  act on serial data in
void decode_serial_data()
        {
           char inChar = (char)Serial.read();

          if (inChar == '^')
          {
           Serial.print("tst");
           return;
          }
         
          if (inChar == ';')
          {
              while (!Serial.available()) {}
              temp1 = Serial.read();   // 
              if (temp1 >0)
                initialize_light_panels_LR(temp1);
              else
                initialize_light_panels_short();
            return;
          }
//-----------------------------------------------
           
            if (inChar == '"')
            {
              initialize_light_panels_gonogo();
              return;
            }
//-----------------------------------------------
// response_window_indicator
            if (inChar == 'o')
            {
              while (!Serial.available()) {}
              temp = Serial.read();
              if (temp == 1)
                digitalWrite(response_window_indicator, HIGH);
              else
                digitalWrite(response_window_indicator, LOW);
              
              return;
            }
//-----------------------------------------------
// left/right flag and panel mode
            if (inChar == '?')
            {
              while (!Serial.available()) {}
              left_right_flag = Serial.read();
              return;
            }
//-----------------------------------------------
// light_pattern_speed
            if (inChar == '{')
            {
              while (!Serial.available()) {}
              light_pattern_speed = Serial.read();
              return;
            }
//-----------------------------------------------
// light_pattern_brightness
            if (inChar == '}')
            {
              while (!Serial.available()) {}
              light_pattern_brightness = Serial.read();
              while (!Serial.available()) {}
              temp = Serial.read();
              // if 0 then do not initialize light panels
              if (temp == 1)
                 initialize_light_panels();
              return;
            }
//-----------------------------------------------
// DM Left panel mode
            
            if (inChar == 'b')
            {
              while (!Serial.available()) {}
              temp1 = Serial.read();   // on  time
              while (!Serial.available()) {}
              temp2 = Serial.read();   //on time
              visual_high_cycle_L = temp1 + 256*temp2;
              while (!Serial.available()) {}
              temp1 = Serial.read();   // delay msb
              while (!Serial.available()) {}
              temp2 = Serial.read();   //delay lsb
              visual_low_cycle_L  = temp1 + 256*temp2;
              while (!Serial.available()) {}
              temp1 = Serial.read();   // delay msb
              while (!Serial.available()) {}
              temp2 = Serial.read();   //delay lsb
              number_of_visual_cycles_L  = temp1 + 256*temp2;
              while (!Serial.available()) {}
              panel_mode_L = Serial.read();   // 
              while (!Serial.available()) {}
              dac_val = Serial.read();   // 

              ledmatrixL.setFrame(panel_mode_L);
              light_panel_L(panel_mode_L,dac_val);
              cycle_type_L = 1;
              
              visual_cycle_start_L = millis();  
              return;
            }

//-----------------------------------------------
// DM Right panel mode
            
            if (inChar == '+')
            {
              while (!Serial.available()) {}
              temp1 = Serial.read();   // on  time
              while (!Serial.available()) {}
              temp2 = Serial.read();   //on time
              visual_high_cycle_R = temp1 + 256*temp2;
              while (!Serial.available()) {}
              temp1 = Serial.read();   // delay msb
              while (!Serial.available()) {}
              temp2 = Serial.read();   //delay lsb
              visual_low_cycle_R  = temp1 + 256*temp2;
              while (!Serial.available()) {}
              temp1 = Serial.read();   // delay msb
              while (!Serial.available()) {}
              temp2 = Serial.read();   //delay lsb
              number_of_visual_cycles_R  = temp1 + 256*temp2;
              while (!Serial.available()) {}
              panel_mode_R = Serial.read();   // 
              while (!Serial.available()) {}
              dac_val = Serial.read();   // 

              ledmatrixR.setFrame(panel_mode_R);
              light_panel_R(panel_mode_R,dac_val);
              cycle_type_R = 1;
              
              visual_cycle_start_R = millis();  
              return;
            }

//-----------------------------------------------
// DM Center panel mode
            
            if (inChar == '&')
            {
              while (!Serial.available()) {}
              temp1 = Serial.read();   // on  time
              while (!Serial.available()) {}
              temp2 = Serial.read();   //on time
              visual_high_cycle_C = temp1 + 256*temp2;
              while (!Serial.available()) {}
              temp1 = Serial.read();   // delay msb
              while (!Serial.available()) {}
              temp2 = Serial.read();   //delay lsb
              visual_low_cycle_C  = temp1 + 256*temp2;
              while (!Serial.available()) {}
              temp1 = Serial.read();   // delay msb
              while (!Serial.available()) {}
              temp2 = Serial.read();   //delay lsb
              number_of_visual_cycles_C  = temp1 + 256*temp2;
              while (!Serial.available()) {}
              panel_mode_C = Serial.read();   // 
              while (!Serial.available()) {}
              dac_val = Serial.read();   // 

              ledmatrixC.setFrame(panel_mode_C);
              light_panel_C(panel_mode_C,dac_val);
              cycle_type_C = 1;
              
              visual_cycle_start_C = millis();  
              return;
            }


//-----------------------------------------------
// DM Left audio
            
            if (inChar == 'm')
            {
              while (!Serial.available()) {}
              temp1 = Serial.read();   // on  time
              while (!Serial.available()) {}
              temp2 = Serial.read();   //on time
              auditory_high_cycle_L = temp1 + 256*temp2;
              while (!Serial.available()) {}
              temp1 = Serial.read();   // delay msb
              while (!Serial.available()) {}
              temp2 = Serial.read();   //delay lsb
              auditory_low_cycle_L  = temp1 + 256*temp2;
              while (!Serial.available()) {}
              temp1 = Serial.read();   // delay msb
              while (!Serial.available()) {}
              temp2 = Serial.read();   //delay lsb
              number_of_auditory_cycles_L  = temp1 + 256*temp2;
              while (!Serial.available()) {}
              mbank_L = Serial.read();   // 
              while (!Serial.available()) {}
              temp1 = Serial.read();   // 
              dac_val_audio = 100*temp1;

//audio on
              uint8_t tb = 1;
              tone_ON(tb,mbank_L);
              cycle_type_auditory_L = 1;
              auditory_cycle_start_L = millis();  
              return;
            }

//-----------------------------------------------
// DM Right audio
            
            if (inChar == 'n')
            {
              while (!Serial.available()) {}
              temp1 = Serial.read();   // on  time
              while (!Serial.available()) {}
              temp2 = Serial.read();   //on time
              auditory_high_cycle_R = temp1 + 256*temp2;
              while (!Serial.available()) {}
              temp1 = Serial.read();   // delay msb
              while (!Serial.available()) {}
              temp2 = Serial.read();   //delay lsb
              auditory_low_cycle_R  = temp1 + 256*temp2;
              while (!Serial.available()) {}
              temp1 = Serial.read();   // delay msb
              while (!Serial.available()) {}
              temp2 = Serial.read();   //delay lsb
              number_of_auditory_cycles_R  = temp1 + 256*temp2;
              while (!Serial.available()) {}
              mbank_R = Serial.read();   // 
              while (!Serial.available()) {}
              temp1 = Serial.read();   // 
              dac_val_audio = 100*temp1;

//audio on
              uint8_t tb = 2;
              tone_ON(tb,mbank_R);
              cycle_type_auditory_R = 1;
              auditory_cycle_start_R = millis();  
              return;
            }

//-----------------------------------------------
// stop all timers and lights snd audio
            
            if (inChar == ':')
            {
            digitalWrite(response_window_indicator, LOW);
             ledmatrixL.setFrame(pg_dark);
             ledmatrixL.displayFrame(pg_dark);
             ledmatrixC.setFrame(pg_dark);
             ledmatrixC.displayFrame(pg_dark);
             ledmatrixR.setFrame(pg_dark);
             ledmatrixR.displayFrame(pg_dark);
             number_of_visual_cycles_L  = 0;
             number_of_visual_cycles_R  = 0;
             number_of_visual_cycles_C  = 0;
             #ifdef FULL_RIG
                dac.setChannelValue(MCP4728_CHANNEL_C, 0, MCP4728_VREF_INTERNAL,MCP4728_GAIN_2X);
              #endif
             uint8_t tb = 3; 
             tone_OFF(tb);
             number_of_auditory_cycles_L  = 0;
             number_of_auditory_cycles_R  = 0;
             return;
            }

//-----------------------------------------------
// Sensory Stimulus panel mode
            
            if (inChar == '-')
            {
              
              while (!Serial.available()) {}
              temp1 = Serial.read();   // on time
              while (!Serial.available()) {}
              temp2 = Serial.read();   //off time
              visual_half_cycle = temp1 + 256*temp2;
              while (!Serial.available()) {}
              temp1 = Serial.read();   // delay msb
              while (!Serial.available()) {}
              temp2 = Serial.read();   //delay lsb
              visual_start_delay  = temp1 + 256*temp2;
              while (!Serial.available()) {}
              number_of_visual_cycles = Serial.read();   // 
              while (!Serial.available()) {}
              left_right_flag_visual = Serial.read();   // 
              while (!Serial.available()) {}
              panel_mode = Serial.read();   // 
              

              visual_delay_start_time = millis();  
              visual_start_pending = 1;  
              return;
            }


//-----------------------------------------------
//-----------------------------------------------
//        moving bars

            if (inChar == '(')
            {
            
              while (!Serial.available()) {}
              left_right_flag = Serial.read();    
              while (!Serial.available()) {}
              temp_byte = Serial.read();    
              switch (temp_byte)
              {
                case 1:
                  pattern_left_right_vertical();
                  break;
                case 2:
                  pattern_right_left_vertical();
                  break;
                case 3:
                  pattern_top_to_bottom_horizontal();
                  break;
                case 4:
                  pattern_bottom_to_top_horizontal();
                  break;
                case 5:
                  pattern_left_right_vertical_db();
                  break;
                case 6:
                  pattern_right_left_vertical_db();
                  break;
                case 7:
                  pattern_top_to_bottom_horizontal_db();
                  break;
                case 8:
                  pattern_bottom_to_top_horizontal_db();
                  break;
              }
              #ifdef FULL_RIG
                dac.setChannelValue(MCP4728_CHANNEL_C, 0, MCP4728_VREF_INTERNAL,MCP4728_GAIN_2X);
              #endif
              digitalWrite(dac_write_indicator,LOW);   
              return;
            }
        

//-----------------------------------------------
// move arm1
            if (inChar == 'i')
            {
              while (!Serial.available()) {}
              temp = Serial.read();            
              while (!Serial.available()) {}
              temp1 = Serial.read();
              if (temp1 == 0)
              {
                  temp = 100*temp;            
                  #ifdef FULL_RIG
                    dac.setChannelValue(MCP4728_CHANNEL_A, temp, MCP4728_VREF_INTERNAL,MCP4728_GAIN_2X);
                    #endif
              }
              else
                #ifdef SERVO_TIMERS_45
                    myServoC.write(temp);              // 
                #else
                    myservoC.write(temp);              // 
                #endif
              return;
            }
//-----------------------------------------------
// move arm2
            if (inChar == 'j')
            {
              while (!Serial.available()) {}
              temp = Serial.read();            
              while (!Serial.available()) {}
              temp1 = Serial.read();
              if (temp1 == 0)
              {
                temp = 100*temp; 
                #ifdef FULL_RIG
                  dac.setChannelValue(MCP4728_CHANNEL_B, temp, MCP4728_VREF_INTERNAL,MCP4728_GAIN_2X);
                #endif
              }
              else
                #ifdef SERVO_TIMERS_45
                  myServoLR.write(temp);              // 
                #else
                  myservoLR.write(temp);              // 
                #endif
              return; 
            }
//-----------------------------------------------
// reward L
            if (inChar == 'y')
            {
            digitalWrite(RewardL, HIGH);
            #ifdef FULL_RIG
              dac.setChannelValue(MCP4728_CHANNEL_D, D_reward_L, MCP4728_VREF_INTERNAL,MCP4728_GAIN_2X);
            #endif
            StartPulse(reward_pulse_L,RewardL);
            return;
            }
//-----------------------------------------------
// reward C
            if (inChar == 'z')
            {
              digitalWrite(RewardC, HIGH);
              #ifdef FULL_RIG
                dac.setChannelValue(MCP4728_CHANNEL_D, D_reward_C, MCP4728_VREF_INTERNAL,MCP4728_GAIN_2X);
                #endif
              StartPulse(reward_pulse_C,RewardC);
              return;
            }
//-----------------------------------------------
// reward R
            if (inChar == 'x')
            {
              digitalWrite(RewardR, HIGH);
              #ifdef FULL_RIG
                dac.setChannelValue(MCP4728_CHANNEL_D, D_reward_R, MCP4728_VREF_INTERNAL,MCP4728_GAIN_2X);
              #endif
              StartPulse(reward_pulse_R,RewardR);
              return;
            }
           
//-----------------------------------------------
// light panel control
            if (inChar == 'r')
            {
              while (!Serial.available()){}
              temp_byte1 = Serial.read();
              while (!Serial.available()){}
              temp_byte = Serial.read();
              while (!Serial.available()){}
              dac_val = Serial.read();

            switch (temp_byte1)
            {
            case 0:
              light_panel_L(temp_byte,dac_val);
              break;
            case 1:
              light_panel_C(temp_byte,dac_val);
              break;
            case 2:
              light_panel_R(temp_byte,dac_val);
              break;
            }
              return;
            }
//-----------------------------------------------
// AirPuff
            if (inChar == 'd')
            {
              digitalWrite(AirPuff, HIGH);
              StartPulse(airpuff_pulse,AirPuff);
              digitalWrite(AirPuff, LOW);
              return;
            }
//-----------------------------------------------
// airpuff duration 
            if (inChar == 'u')
            {
              while (!Serial.available()) {}
              tre = Serial.read();
              airpuff_pulse = 1000*tre;
              return;
            }
//-----------------------------------------------
// reward duration Center
            if (inChar == 'q')
            {
            #ifdef FRACTIONAL_REWARD_DURATION
              while (!Serial.available()) {}
              temp1 = Serial.read();   // on  time
              while (!Serial.available()) {}
              temp2 = Serial.read();   //on time
              tre = temp1 + 256*temp2;
              reward_pulse_C = 10*tre;
              return;
              
            #else
              
              while (!Serial.available()) {}
              tre = Serial.read();
              reward_pulse_C = 1000*tre;
              return;
              
            #endif
            }
//-----------------------------------------------
// reward duration Left
            if (inChar == 'v')
            {
            #ifdef FRACTIONAL_REWARD_DURATION
              while (!Serial.available()) {}
              temp1 = Serial.read();   // on  time
              while (!Serial.available()) {}
              temp2 = Serial.read();   //on time
              tre = temp1 + 256*temp2;
              reward_pulse_L = 10*tre;
              return;
              
            #else
              
              while (!Serial.available()) {}
              tre = Serial.read();
              reward_pulse_L = 1000*tre;
              return;
              
            #endif
             }
//-----------------------------------------------
// reward duration Right
            if (inChar == 'w')
            {
            #ifdef FRACTIONAL_REWARD_DURATION
              while (!Serial.available()) {}
              temp1 = Serial.read();   // on  time
              while (!Serial.available()) {}
              temp2 = Serial.read();   //on time
              tre = temp1 + 256*temp2;
              reward_pulse_R = 10*tre;
              return;
              
            #else
              
              while (!Serial.available()) {}
              tre = Serial.read();
              reward_pulse_R = 1000*tre;
              return;
              
            #endif
            }
//-----------------------------------------------
// Pulse durations
            if (inChar == '#')
            {
              while (!Serial.available()) {}
              tre = Serial.read();
              reward_pulse_L = 1000*tre;
              while (!Serial.available()) {}
              tre = Serial.read();
              reward_pulse_C = 1000*tre;
              while (!Serial.available()) {}
              tre = Serial.read();
              reward_pulse_R = 1000*tre;
              while (!Serial.available()) {}
              tre = Serial.read();
              airpuff_pulse = 1000*tre;
 //             Serial.println("pulse Initialization Complete");
              return;
            }
//-----------------------------------------------
// enable interrupts
//            if (inChar == 'p')
            if (inChar == '!')
            {
              int_flag1 = 1;
              int_flag2 = 1;
              int_flag3 = 1;
              attachInterrupt(digitalPinToInterrupt(LickCenter), lick1, RISING);
              attachInterrupt(digitalPinToInterrupt(LickRight), lick2, RISING);
              attachInterrupt(digitalPinToInterrupt(LickLeft), lick3, RISING);
              return;
            }  
        
//-----------------------------------------------
//
// valve control
            if (inChar == 'k')
            {
              while (!Serial.available()) {}
              temp_byte = Serial.read();
              while (!Serial.available()) {}
              temp_byte1 = Serial.read();

              
              if (temp_byte == 0)   // 0 is left valve
              {
                if (temp_byte1 == 1)
                  digitalWrite(RewardL, HIGH);
                  else
                  digitalWrite(RewardL, LOW);
              }
              else if (temp_byte == 1)   // 1 is center valve
              {
                if (temp_byte1 == 1)
                  digitalWrite(RewardC, HIGH);
                  else
                  digitalWrite(RewardC, LOW);
              }
              else     // 2 is right valve
              {
                if (temp_byte1 == 1)
                  digitalWrite(RewardR, HIGH);
                  else
                  digitalWrite(RewardR, LOW);
              }
              return;
            }

//-----------------------------------------------
// set audio volume
            if (inChar == 'a')
            {
              while (!Serial.available()) {}
              vol = Serial.read();
              return;
            }
//-----------------------------------------------
// set audio off
            if (inChar == 't')
            {
              vol = 0;
              setvolume(vol);
              return;
            }

//-----------------------------------------------
// auditory sequence
          if (inChar == 'l')
          {

              while (!Serial.available()) {}
              temp1 = Serial.read();   // 
              while (!Serial.available()) {}
              temp2 = Serial.read();   // 
              auditory_half_cycle = temp1 + 256*temp2;
              while (!Serial.available()) {}
              temp1 = Serial.read();   // 
              while (!Serial.available()) {}
              temp2 = Serial.read();   // 
              auditory_start_delay = temp1 + 256*temp2;  
              while (!Serial.available()) {}
              number_of_auditory_cycles = Serial.read();   // 
              while (!Serial.available()) {}
              left_right_flag_auditory = Serial.read();   // 
              while (!Serial.available()) {}
              mbank = Serial.read();   // 
              while (!Serial.available()) {}
              temp1 = Serial.read();   // 
              dac_val_audio = 100*temp1;

              auditory_cycle_start = millis();

              auditory_delay_start_time = millis();
              auditory_start_pending = 1;
              Serial.print("ack");
              return;
          }


//-----------------------------------------------
// set tone frequency
            if (inChar == '=')
            {
              while (!Serial.available()) {}
              skip = Serial.read();
//              while (!Serial.available()) {}
//              temp2 = Serial.read();
//              mbank = temp1; //+ 256*temp2;
//              skip = temp2;
              return;
            }

//-----------------------------------------------
//  tone0 on/off     1=on   0 = off
            if (inChar == 'e')
            {
              while (!Serial.available()) {}
              tb0 = Serial.read();
              while (!Serial.available()) {}
              tb1 = Serial.read();
              while (!Serial.available()) {}
              temp1 = Serial.read();   // 
              dac_val_audio = 100*temp1;

              tone_ON(tb0,tb1);
                  
              return;
            }
//-----------------------------------------------
//  tone1 on/off     1=on   0 = off
            if (inChar == 'f')
            {
              while (!Serial.available()) {}
              temp = Serial.read();
              if (temp == 1)
              {
                setvolume(vol);
//                tone(Tone1,mbank);
//                tone_ON(2,mbank);
              }
              else
              {
                setvolume(0);
//                noTone(Tone1);
                tone_OFF(2);
                digitalWrite(Tone1, LOW);                 
              }
              return;
            }


//-----------------------------------------------
            if (inChar == '@')
            {
              write_panel_pageL(0,15,0,9,6,0); // small panel
              write_panel_pageR(0,15,0,9,6,0); // small panel
              return;
            }



//-----------------------------------------------
//write to single dac
           if (inChar == 'g')
              {
                while (!Serial.available()) {}
                tempbyte  = Serial.read();
                
                #ifdef FULL_RIG
                  dac_single.begin(0x62);
                  dac_val_audio = 100*tempbyte;
                  dac_single.setVoltage(dac_val_audio, false);          
                #endif
                return;
              }

//-----------------------------------------------
//write to dac
           if (inChar == 'c')
              {
                while (!Serial.available()) {}
                tempbyte  = Serial.read();
                while (!Serial.available()) {}
                temp1 = Serial.read();   // low part
                while (!Serial.available()) {}
                temp2 = Serial.read();   //high
                temp = temp1 + 256*temp2;

            #ifdef FULL_RIG

                switch (tempbyte)
                {
                case 0:
                   dac.setChannelValue(MCP4728_CHANNEL_A,temp, MCP4728_VREF_INTERNAL,MCP4728_GAIN_2X);
                  break;
                case 1:
                   dac.setChannelValue(MCP4728_CHANNEL_B,temp, MCP4728_VREF_INTERNAL,MCP4728_GAIN_2X);
                  break;
                case 2:
                   dac.setChannelValue(MCP4728_CHANNEL_C,temp, MCP4728_VREF_INTERNAL,MCP4728_GAIN_2X);
                  break;
                case 3:
                   dac.setChannelValue(MCP4728_CHANNEL_D,temp, MCP4728_VREF_INTERNAL,MCP4728_GAIN_2X);
                  break;
                }
                  return;
            #endif
              }   
                         
}

// end of decode_serial_data
//void serialEvent() {
  //            decode_serial_data();
//}

// ------------------------------------------------------
// subroutines
// ------------------------------------------------------

// Setting the volume is very simple! Just write the 6-bit
// volume to the i2c bus. That's it!
boolean setvolume(int8_t v) {

  #ifdef NO_AUDIO_AMPLIFIER
    return true;
  #endif
  // cant be higher than 63 or lower than 0
  if (v > 63) v = 63;
  if (v < 0) v = 0;

//  Serial.print("Setting volume to ");
//  Serial.println(v);
  Wire.beginTransmission(MAX9744_I2CADDR);
  Wire.write(v);
  if (Wire.endTransmission() == 0) 
    return true;
  else
    return false;
}

// ------------------------------------------------------
// lick 1
void lick1()
{
    digitalWrite(lick_indicator_C, HIGH);
    Serial.print("lcC");
    detachInterrupt(digitalPinToInterrupt(LickCenter));
    int_disable_start = millis();
    int_active = 0;
}
// ------------------------------------------------------
// lick 2
void lick2()
{
    digitalWrite(lick_indicator_R, HIGH);
    Serial.print("lcR");
    detachInterrupt(digitalPinToInterrupt(LickRight));
    int_disable_start = millis();
    int_active = 0;
}
// ------------------------------------------------------
// lick 3
void lick3()
{
    digitalWrite(lick_indicator_L, HIGH);
    Serial.print("lcL");
    detachInterrupt(digitalPinToInterrupt(LickLeft));
    int_disable_start = millis();
    int_active = 0;
}
// ------------------------------------------------------

// ------------------------------------------------------

void write_panel_pageL(uint8_t a,uint8_t b,uint8_t c,uint8_t d,uint8_t idx, uint8_t intensity) {
   
    
#ifndef LEFT_LED_PANEL
  return;
#endif

ledmatrixL.setFrame(idx);
    for (uint8_t x=0; x<16; x++) {
      for (uint8_t y=0; y<9; y++) {
        ledmatrixL.drawPixel(x, y,0 );
      }
    }
    for (uint8_t x=a; x<=b; x++) {
      for (uint8_t y=c; y<=d; y++) {
        ledmatrixL.drawPixel(x, y,intensity);
      }
    }
}

void write_panel_pageL_NZ(uint8_t a,uint8_t b,uint8_t c,uint8_t d,uint8_t idx, uint8_t intensity) {
   
    
#ifndef LEFT_LED_PANEL
  return;
#endif
    ledmatrixL.setFrame(idx);
    for (uint8_t x=a; x<=b; x++) {
      for (uint8_t y=c; y<=d; y++) {
        ledmatrixL.drawPixel(x, y,intensity);
      }
    }
}


void write_panel_pageR(uint8_t a,uint8_t b,uint8_t c,uint8_t d,uint8_t idx, uint8_t intensity) {

#ifndef RIGHT_LED_PANEL
  return;
#endif
    ledmatrixR.setFrame(idx);
    for (uint8_t x=0; x<16; x++) {
      for (uint8_t y=0; y<9; y++) {
        ledmatrixR.drawPixel(x, y,0 );
      }
    }
    for (uint8_t x=a; x<=b; x++) {
      for (uint8_t y=c; y<=d; y++) {
        ledmatrixR.drawPixel(x, y,intensity);
      }
    }
}

void write_panel_pageR_NZ(uint8_t a,uint8_t b,uint8_t c,uint8_t d,uint8_t idx, uint8_t intensity) {


#ifndef RIGHT_LED_PANEL
  return;
#endif
    ledmatrixR.setFrame(idx);
    for (uint8_t x=a; x<=b; x++) {
      for (uint8_t y=c; y<=d; y++) {
        ledmatrixR.drawPixel(x, y,intensity);
      }
    }
}


void write_panel_pageC(uint8_t a,uint8_t b,uint8_t c,uint8_t d,uint8_t idx, uint8_t intensity) {


#ifndef CENTER_LED_PANEL
  return;
#endif
    ledmatrixC.setFrame(idx);
    for (uint8_t x=0; x<16; x++) {
      for (uint8_t y=0; y<9; y++) {
        ledmatrixC.drawPixel(x, y,0 );
      }
    }
    for (uint8_t x=a; x<=b; x++) {
      for (uint8_t y=c; y<=d; y++) {
        ledmatrixC.drawPixel(x, y,intensity);
      }
    }
}


void StartPulse(uint32_t pwidth, uint8_t port) {
  
  Timer3.initialize(pwidth);
  Timer3.attachInterrupt(StopPulse);
  //Timer3.start();
  TCNT1 = 1;
  }

void StopPulse() {
  Timer3.stop();
  Timer3.detachInterrupt();
  digitalWrite(RewardL, LOW);
  digitalWrite(RewardC, LOW);
  digitalWrite(RewardR, LOW);
  CHD_zeroflag = 1;
 }

 void flash()
{
  static boolean output = HIGH;
  
  digitalWrite(cclockpin, output);
  output = !output;
}



void initialize_light_panels_LR(uint8_t nstripes)
{
  digitalWrite(Test1, HIGH);

  #ifdef LEFT_LED_PANEL
  ledmatrixL.displayFrame(pg_dark);
  #endif 
  #ifdef CENTER_LED_PANEL
  ledmatrixC.displayFrame(pg_dark);
  #endif 
  #ifdef RIGHT_LED_PANEL
  ledmatrixR.displayFrame(pg_dark);
  #endif 

   //init_angled_stripes(leftright, page, nstripes,angle) 


  init_straight_stripes(0,2,nstripes,0); 
  init_straight_stripes(1,2,nstripes,0); 
  init_straight_stripes(0,3,nstripes,1); 
  init_straight_stripes(1,3,nstripes,1); 

  init_angled_stripes(0,5,nstripes,0); 
  init_angled_stripes(1,5,nstripes,0); 
  init_angled_stripes(0,6,nstripes,1); 
  init_angled_stripes(1,6,nstripes,1); 

  
  //show dark pages
  #ifdef LEFT_LED_PANEL
  ledmatrixL.displayFrame(pg_dark);
  #endif 
  #ifdef CENTER_LED_PANEL
  ledmatrixC.displayFrame(pg_dark);
  #endif 
  #ifdef RIGHT_LED_PANEL
  ledmatrixR.displayFrame(pg_dark);
  #endif 
  digitalWrite(Test1, LOW);
  Serial.print("ack");
}


void initialize_light_panels()
{
  
  //light_level = 1;
   
  // new 6  panel mode
  // x from a to b,   y from c to d
  digitalWrite(Test1, HIGH);
  
  ////left panel
  write_panel_pageL(6,9,ystart,ystop,0,light_pattern_brightness); 
  write_panel_pageL(12,15,ystart,ystop,1,light_pattern_brightness); 
  write_panel_pageL(0,15,0,ystop,2,0); 
  write_panel_pageL(5,9,3,6,pg_small,0); // small panel
  write_panel_pageL(0,15,0,ystop,pg_full,light_pattern_brightness); //full panel
  write_panel_pageL(0,3,ystart,ystop,5,light_pattern_brightness);    // for one panel case
  write_panel_pageL(0,15,0,ystop,6,0); // small panel
  write_panel_pageL(0,15,0,ystop,pg_dark,0); //dark
  

  
  //middle panel
  write_panel_pageC(2,5,ystart,ystop,0,light_pattern_brightness); 
  write_panel_pageC(10,13,ystart,ystop,1,light_pattern_brightness); 
  write_panel_pageC(0,15,0,ystop,2,0); 
  write_panel_pageC(0,15,0,ystop,pg_small,0); 
  write_panel_pageC(0,15,0,ystop,pg_full,light_pattern_brightness); //full panel
//  write_panel_pageC(0,15,0,ystop,5,0); 
  write_panel_pageC(0,15,3,5,5,light_pattern_brightness); 
  write_panel_pageC(0,15,0,ystop,6,0); 
  write_panel_pageC(0,15,0,ystop,pg_dark,0); 
  
  //right panel
  write_panel_pageR(12,15,ystart,ystop,0,light_pattern_brightness); 
  write_panel_pageR(6,9,ystart,ystop,1,light_pattern_brightness); 
  write_panel_pageR(0,15,0,ystop,2,0); 
  write_panel_pageR(5,9,3,6,pg_small,0); // small panel
  write_panel_pageR(0,15,0,ystop,pg_full,light_pattern_brightness); //full panel
  write_panel_pageR(0,3,ystart,ystop,5,light_pattern_brightness);    // for one panel case
  write_panel_pageR(0,15,0,ystop,6,0); 
  write_panel_pageR(0,15,0,ystop,pg_dark,0); 
  
  
  //show dark pages
  #ifdef LEFT_LED_PANEL
  ledmatrixL.displayFrame(pg_dark);
  #endif 
  #ifdef CENTER_LED_PANEL
  ledmatrixC.displayFrame(pg_dark);
  #endif 
  #ifdef RIGHT_LED_PANEL
  ledmatrixR.displayFrame(pg_dark);
  #endif 
  digitalWrite(Test1, LOW);
  Serial.print("ack");

  //  Serial.println("LEDMatrix done");
}



void initialize_light_panels_short()
{
  
  //light_level = 1;
   
  // new 6  panel mode
  // x from a to b,   y from c to d
  digitalWrite(Test1, HIGH);
  
  ////left panel
  write_panel_pageL(0,15,0,ystop,2,0); 
  write_panel_pageL(5,9,3,6,pg_small,0); // small panel
  write_panel_pageL(0,15,0,ystop,pg_full,light_pattern_brightness); //full panel
  write_panel_pageL(0,3,ystart,ystop,5,light_pattern_brightness);    // for one panel case
  write_panel_pageL(0,15,0,ystop,6,0); // small panel
  
  //right panel
  write_panel_pageR(0,15,0,ystop,2,0); 
  write_panel_pageR(5,9,3,6,pg_small,0); // small panel
  write_panel_pageR(0,15,0,ystop,pg_full,light_pattern_brightness); //full panel
  write_panel_pageR(0,3,ystart,ystop,5,light_pattern_brightness);    // for one panel case
  write_panel_pageR(0,15,0,ystop,6,0); 


  //show dark pages
  #ifdef LEFT_LED_PANEL
  ledmatrixL.displayFrame(pg_dark);
  #endif 
  #ifdef CENTER_LED_PANEL
  ledmatrixC.displayFrame(pg_dark);
  #endif 
  #ifdef RIGHT_LED_PANEL
  ledmatrixR.displayFrame(pg_dark);
  #endif 
  digitalWrite(Test1, LOW);
  Serial.print("ack");

  //  Serial.println("LEDMatrix done");
}




void initialize_light_panels_gonogo()
{

   while (!Serial.available()) {}
   uint8_t pattern_GO = Serial.read();   // pattern    go
   while (!Serial.available()) {}
   uint8_t nstripes_GO = Serial.read();   // number of stripes go
   
   while (!Serial.available()) {}
   uint8_t pattern_NOGO = Serial.read();   // pattern nogo
   while (!Serial.available()) {}
   uint8_t nstripes_NOGO = Serial.read();   // number of stripes nogo



    switch (pattern_GO)    // goes to page 5
    {
      case 1:
        write_panel_pageL(0,15,0,9,5,light_pattern_brightness); 
        write_panel_pageR(0,15,0,9,5,light_pattern_brightness); 
        break;
      case 2:
        init_straight_stripes(0,5,nstripes_GO,0); 
        init_straight_stripes(1,5,nstripes_GO,0); 
        break;
      case 3:
        init_straight_stripes(0,5,nstripes_GO,1); 
        init_straight_stripes(1,5,nstripes_GO,1); 
        break;
      case 4:
        init_angled_stripes(0,5,nstripes_GO,0); 
        init_angled_stripes(1,5,nstripes_GO,0); 
        break;
      case 5:
        init_angled_stripes(0,5,nstripes_GO,1); 
        init_angled_stripes(1,5,nstripes_GO,1); 
        break;
      case 6:  
        init_single_stripe(0,5,nstripes_GO ,0); 
        init_single_stripe(1,5,nstripes_GO ,0); 
        break;
      case 7:
        init_single_stripe(0,5,nstripes_GO ,1); 
        init_single_stripe(1,5,nstripes_GO ,1); 
    }


    switch (pattern_NOGO)   // goes to page 6
    {
      case 1:
        write_panel_pageL(0,15,0,9,6,light_pattern_brightness); 
        write_panel_pageR(0,15,0,9,6,light_pattern_brightness); 
        break;
      case 2:
        init_straight_stripes(0,6,nstripes_NOGO,0); 
        init_straight_stripes(1,6,nstripes_NOGO,0); 
        break;
      case 3:
        init_straight_stripes(0,6,nstripes_NOGO,1); 
        init_straight_stripes(1,6,nstripes_NOGO,1); 
        break;
      case 4:
        init_angled_stripes(0,6,nstripes_NOGO,0); 
        init_angled_stripes(1,6,nstripes_NOGO,0); 
        break;
      case 5:
        init_angled_stripes(0,6,nstripes_NOGO,1); 
        init_angled_stripes(1,6,nstripes_NOGO,1); 
        break;
      case 6:  
        init_single_stripe(0,6,nstripes_NOGO ,0); 
        init_single_stripe(1,6,nstripes_NOGO ,0); 
        break;
      case 7:
        init_single_stripe(0,6,nstripes_NOGO ,1); 
        init_single_stripe(1,6,nstripes_NOGO ,1); 
    }

// start signal
    write_panel_pageC(0,15,3,5,5,light_pattern_brightness); 
 
    Serial.print("ack");
  
}



void light_panel_L(uint8_t tbyte, uint8_t dval)
{
      temp = 100*dval;
     #ifdef FULL_RIG
       dac.setChannelValue(MCP4728_CHANNEL_C, temp, MCP4728_VREF_INTERNAL,MCP4728_GAIN_2X);
     #endif
      ledmatrixL.displayFrame(tbyte);
      if (temp == 0)
      {
        digitalWrite(dac_write_indicator, LOW);   
      }
      else
      {
        digitalWrite(dac_write_indicator, HIGH);   
      }
      return;
 }


void light_panel_C(uint8_t tbyte, uint8_t dval)

{
    temp = 100*dval;
    #ifdef FULL_RIG
      dac.setChannelValue(MCP4728_CHANNEL_C, temp, MCP4728_VREF_INTERNAL,MCP4728_GAIN_2X);
    #endif
    ledmatrixC.displayFrame(tbyte);
      if (temp == 0)
      {
        digitalWrite(dac_write_indicator, LOW);   
      }
      else
      {
        digitalWrite(dac_write_indicator, HIGH);   
      }
  return;
}


//------------------------------------------
void light_panel_R(uint8_t tbyte, uint8_t dval)
{
    temp = 100*dval;
    #ifdef FULL_RIG
      dac.setChannelValue(MCP4728_CHANNEL_C, temp, MCP4728_VREF_INTERNAL,MCP4728_GAIN_2X);
    #endif
    ledmatrixR.displayFrame(tbyte);
      if (temp == 0)
      {
        digitalWrite(dac_write_indicator, LOW);   
      }
      else
      {
        digitalWrite(dac_write_indicator, HIGH);   
      }
     return;
}





//------------------------------------------
void pattern_left_right_vertical()

            {

            if (left_right_flag == 1)
            {
              #ifdef FULL_RIG
              dac.setChannelValue(MCP4728_CHANNEL_C, left_right_vertical_L, MCP4728_VREF_INTERNAL,MCP4728_GAIN_2X);
              #endif
              digitalWrite(dac_write_indicator, HIGH);   
              ledmatrixL.setFrame(6);
              for (uint8_t x = 0; x < 16; x++)
              {
                for (uint8_t y = 0; y < 9; y++)
                {
                  ledmatrixL.drawPixel(x, y, light_pattern_brightness);
                }
                  
                ledmatrixL.displayFrame(6);
                delay(light_pattern_speed);
                
                for (uint8_t y = 0; y < 9; y++)
                {
                  ledmatrixL.drawPixel(x, y, 0);
                }
                ledmatrixL.displayFrame(6);

              }
            }
            else if (left_right_flag == 2)
            {
              #ifdef FULL_RIG
              dac.setChannelValue(MCP4728_CHANNEL_C, left_right_vertical_R, MCP4728_VREF_INTERNAL,MCP4728_GAIN_2X);
              #endif
              digitalWrite(dac_write_indicator, HIGH);   
              ledmatrixR.setFrame(6);
              for (uint8_t x = 0; x < 16; x++)
              {
                for (uint8_t y = 0; y < 9; y++)
                {
                  ledmatrixR.drawPixel(x, y, light_pattern_brightness);
                }
                  
                ledmatrixR.displayFrame(6);
                delay(light_pattern_speed);
                
                for (uint8_t y = 0; y < 9; y++)
                {
                  ledmatrixR.drawPixel(x, y, 0);
                }
                ledmatrixR.displayFrame(6);
              }
            }
            else if (left_right_flag == 4)
            {
                ledmatrixC.setFrame(6);
                for (uint8_t x = 0; x < 16; x++)
                {
                  for (uint8_t y = 0; y < 9; y++)
                  {
                    ledmatrixC.drawPixel(x, y, light_pattern_brightness);
                  }
                    
                  ledmatrixC.displayFrame(6);
                  delay(light_pattern_speed);
                  
                  for (uint8_t y = 0; y < 9; y++)
                  {
                    ledmatrixC.drawPixel(x, y, 0);
                  }
                  ledmatrixC.displayFrame(6);
                }
              }
              else      // all panels
              {
               #ifdef FULL_RIG
                dac.setChannelValue(MCP4728_CHANNEL_C, left_right_vertical_R, MCP4728_VREF_INTERNAL,MCP4728_GAIN_2X);
                digitalWrite(dac_write_indicator, HIGH);  
               #endif
                ledmatrixL.setFrame(6);
                ledmatrixR.setFrame(6);
                for (uint8_t x = 0; x < 16; x++)
                {
                  for (uint8_t y = 0; y < 9; y++)
                  {
                    ledmatrixL.drawPixel(x, y, light_pattern_brightness);
                    ledmatrixR.drawPixel(x, y, light_pattern_brightness);
                  }
                    
                  ledmatrixL.displayFrame(6);
                  ledmatrixR.displayFrame(6);
                  delay(light_pattern_speed);
                  
                  for (uint8_t y = 0; y < 9; y++)
                  {
                    ledmatrixL.drawPixel(x, y, 0);
                    ledmatrixR.drawPixel(x, y, 0);
                  }
                  ledmatrixL.displayFrame(6);
                  ledmatrixR.displayFrame(6);
                }
              }
            
            return;
            }
//------------------------------------------
void pattern_left_right_vertical_db()

            {

            if (left_right_flag == 1)
            {
              #ifdef FULL_RIG
              dac.setChannelValue(MCP4728_CHANNEL_C, left_right_vertical_L, MCP4728_VREF_INTERNAL,MCP4728_GAIN_2X);
              #endif
              digitalWrite(dac_write_indicator, HIGH);   
              ledmatrixL.setFrame(6);
              for (uint8_t x = 0; x < 15; x++)
              {
                for (uint8_t y = 0; y < 9; y++)
                {
                  ledmatrixL.drawPixel(x, y, light_pattern_brightness);
                  ledmatrixL.drawPixel(x+1, y, light_pattern_brightness);
                }
                  
                ledmatrixL.displayFrame(6);
                delay(light_pattern_speed);
                
                for (uint8_t y = 0; y < 9; y++)
                {
                  ledmatrixL.drawPixel(x, y, 0);
                  ledmatrixL.drawPixel(x+1, y, 0);
                }
                ledmatrixL.displayFrame(6);

              }
            }
            else if (left_right_flag == 2)
            {
              #ifdef FULL_RIG
              dac.setChannelValue(MCP4728_CHANNEL_C, left_right_vertical_R, MCP4728_VREF_INTERNAL,MCP4728_GAIN_2X);
              #endif
              digitalWrite(dac_write_indicator, HIGH);   
              ledmatrixR.setFrame(6);
              for (uint8_t x = 0; x < 15; x++)
              {
                for (uint8_t y = 0; y < 9; y++)
                {
                  ledmatrixR.drawPixel(x, y, light_pattern_brightness);
                  ledmatrixR.drawPixel(x+1, y, light_pattern_brightness);
                }
                  
                ledmatrixR.displayFrame(6);
                delay(light_pattern_speed);
                
                for (uint8_t y = 0; y < 9; y++)
                {
                  ledmatrixR.drawPixel(x, y, 0);
                  ledmatrixR.drawPixel(x+1, y, 0);
                }
                ledmatrixR.displayFrame(6);
              }
            }
            else if (left_right_flag == 4)
            {
              ledmatrixC.setFrame(6);
              for (uint8_t x = 0; x < 15; x++)
              {
                for (uint8_t y = 0; y < 9; y++)
                {
                  ledmatrixC.drawPixel(x, y, light_pattern_brightness);
                  ledmatrixC.drawPixel(x+1, y, light_pattern_brightness);
                }
                  
                ledmatrixC.displayFrame(6);
                delay(light_pattern_speed);
                
                for (uint8_t y = 0; y < 9; y++)
                {
                  ledmatrixC.drawPixel(x, y, 0);
                  ledmatrixC.drawPixel(x+1, y, 0);
                }
                ledmatrixC.displayFrame(6);
              }
            }
            else
            {
             #ifdef FULL_RIG
              dac.setChannelValue(MCP4728_CHANNEL_C, left_right_vertical_R, MCP4728_VREF_INTERNAL,MCP4728_GAIN_2X);
              digitalWrite(dac_write_indicator, HIGH);
             #endif
              ledmatrixL.setFrame(6);
              ledmatrixR.setFrame(6);
              for (uint8_t x = 0; x < 15; x++)
              {
                for (uint8_t y = 0; y < 9; y++)
                {
                  ledmatrixL.drawPixel(x, y, light_pattern_brightness);
                  ledmatrixR.drawPixel(x, y, light_pattern_brightness);
                  ledmatrixL.drawPixel(x+1, y, light_pattern_brightness);
                  ledmatrixR.drawPixel(x+1, y, light_pattern_brightness);
                }
                  
                ledmatrixL.displayFrame(6);
                ledmatrixR.displayFrame(6);
                delay(light_pattern_speed);
                
                for (uint8_t y = 0; y < 9; y++)
                {
                  ledmatrixL.drawPixel(x, y, 0);
                  ledmatrixL.drawPixel(x+1, y, 0);
                  ledmatrixR.drawPixel(x, y, 0);
                  ledmatrixR.drawPixel(x+1, y, 0);
                }
                ledmatrixL.displayFrame(6);
                ledmatrixR.displayFrame(6);
              }
            }
            
            return;
            }

//-----------------------------------------------
void pattern_right_left_vertical()

            {

            if (left_right_flag == 1)
              {
                #ifdef FULL_RIG
                 dac.setChannelValue(MCP4728_CHANNEL_C, right_to_left_vertical_L, MCP4728_VREF_INTERNAL,MCP4728_GAIN_2X);
                #endif
                digitalWrite(dac_write_indicator, HIGH);   
                ledmatrixL.setFrame(6);
                for (uint8_t x = 0; x < 16; x++)
                {
                  for (uint8_t y = 0; y < 9; y++)
                  {
                    ledmatrixL.drawPixel(15-x, y, light_pattern_brightness);
                  }
                    
                  ledmatrixL.displayFrame(6);
                  delay(light_pattern_speed);
                  
                  for (uint8_t y = 0; y < 9; y++)
                  {
                    ledmatrixL.drawPixel(15-x, y, 0);
                  }
                  ledmatrixL.displayFrame(6);
                }
              }
            else if (left_right_flag == 2)
              {
                #ifdef FULL_RIG
                dac.setChannelValue(MCP4728_CHANNEL_C, right_to_left_vertical_R, MCP4728_VREF_INTERNAL,MCP4728_GAIN_2X);
                #endif
                digitalWrite(dac_write_indicator, HIGH);   
                ledmatrixR.setFrame(6);
                for (uint8_t x = 0; x < 16; x++)
                {
                  for (uint8_t y = 0; y < 9; y++)
                  {
                    ledmatrixR.drawPixel(15-x, y, light_pattern_brightness);
                  }
                    
                  ledmatrixR.displayFrame(6);
                  delay(light_pattern_speed);
                  
                  for (uint8_t y = 0; y < 9; y++)
                  {
                    ledmatrixR.drawPixel(15-x, y, 0);
                  }
                  ledmatrixR.displayFrame(6);
                }
              }
              else if (left_right_flag == 4)
              {
                ledmatrixC.setFrame(6);
                for (uint8_t x = 0; x < 16; x++)
                {
                  for (uint8_t y = 0; y < 9; y++)
                  {
                    ledmatrixC.drawPixel(15-x, y, light_pattern_brightness);
                  }
                    
                  ledmatrixC.displayFrame(6);
                  delay(light_pattern_speed);
                  
                  for (uint8_t y = 0; y < 9; y++)
                  {
                    ledmatrixC.drawPixel(15-x, y, 0);
                  }
                  ledmatrixC.displayFrame(6);
                }
              }
              else
              {
               #ifdef FULL_RIG
                dac.setChannelValue(MCP4728_CHANNEL_C, right_to_left_vertical_R, MCP4728_VREF_INTERNAL,MCP4728_GAIN_2X);
                digitalWrite(dac_write_indicator, HIGH);   
                #endif
                ledmatrixL.setFrame(6);
                ledmatrixR.setFrame(6);
                for (uint8_t x = 0; x < 16; x++)
                {
                  for (uint8_t y = 0; y < 9; y++)
                  {
                    ledmatrixL.drawPixel(15-x, y, light_pattern_brightness);
                    ledmatrixR.drawPixel(15-x, y, light_pattern_brightness);
                  }
                    
                  ledmatrixL.displayFrame(6);
                  ledmatrixR.displayFrame(6);
                  delay(light_pattern_speed);
                  
                  for (uint8_t y = 0; y < 9; y++)
                  {
                    ledmatrixL.drawPixel(15-x, y, 0);
                    ledmatrixR.drawPixel(15-x, y, 0);
                  }
                  ledmatrixL.displayFrame(6);
                  ledmatrixR.displayFrame(6);
                }
              }
             return;
            }
//-----------------------------------------------

void        pattern_right_left_vertical_db()

            {

            if (left_right_flag == 1)
              {
                #ifdef FULL_RIG
                dac.setChannelValue(MCP4728_CHANNEL_C, right_to_left_vertical_L, MCP4728_VREF_INTERNAL,MCP4728_GAIN_2X);
                #endif
                digitalWrite(dac_write_indicator, HIGH);   
                ledmatrixL.setFrame(6);
                for (uint8_t x = 0; x < 15; x++)
                {
                  for (uint8_t y = 0; y < 9; y++)
                  {
                    ledmatrixL.drawPixel(15-x, y, light_pattern_brightness);
                    ledmatrixL.drawPixel(14-x, y, light_pattern_brightness);
                  }
                    
                  ledmatrixL.displayFrame(6);
                  delay(light_pattern_speed);
                  
                  for (uint8_t y = 0; y < 9; y++)
                  {
                    ledmatrixL.drawPixel(15-x, y, 0);
                    ledmatrixL.drawPixel(14-x, y, 0);
                  }
                  ledmatrixL.displayFrame(6);
                }
              }
            else if (left_right_flag == 2)
              {
                #ifdef FULL_RIG
                dac.setChannelValue(MCP4728_CHANNEL_C, right_to_left_vertical_R, MCP4728_VREF_INTERNAL,MCP4728_GAIN_2X);
                #endif
                digitalWrite(dac_write_indicator, HIGH);   
                ledmatrixR.setFrame(6);
                for (uint8_t x = 0; x < 15; x++)
                {
                  for (uint8_t y = 0; y < 9; y++)
                  {
                    ledmatrixR.drawPixel(15-x, y, light_pattern_brightness);
                    ledmatrixR.drawPixel(14-x, y, light_pattern_brightness);
                  }
                    
                  ledmatrixR.displayFrame(6);
                  delay(light_pattern_speed);
                  
                  for (uint8_t y = 0; y < 9; y++)
                  {
                    ledmatrixR.drawPixel(15-x, y, 0);
                    ledmatrixR.drawPixel(14-x, y, 0);
                  }
                  ledmatrixR.displayFrame(6);
                }
              }
              else if (left_right_flag == 4)
              {
                ledmatrixC.setFrame(6);
                for (uint8_t x = 0; x < 15; x++)
                {
                  for (uint8_t y = 0; y < 9; y++)
                  {
                    ledmatrixC.drawPixel(15-x, y, light_pattern_brightness);
                    ledmatrixC.drawPixel(14-x, y, light_pattern_brightness);
                  }
                    
                  ledmatrixC.displayFrame(6);
                  delay(light_pattern_speed);
                  
                  for (uint8_t y = 0; y < 9; y++)
                  {
                    ledmatrixC.drawPixel(15-x, y, 0);
                    ledmatrixC.drawPixel(14-x, y, 0);
                  }
                  ledmatrixC.displayFrame(6);
                }
              }
              else
              {
               #ifdef FULL_RIG
                dac.setChannelValue(MCP4728_CHANNEL_C, right_to_left_vertical_R, MCP4728_VREF_INTERNAL,MCP4728_GAIN_2X);
                digitalWrite(dac_write_indicator, HIGH); 
                #endif
                ledmatrixL.setFrame(6);
                ledmatrixR.setFrame(6);
                for (uint8_t x = 0; x < 15; x++)
                {
                  for (uint8_t y = 0; y < 9; y++)
                  {
                    ledmatrixL.drawPixel(15-x, y, light_pattern_brightness);
                    ledmatrixR.drawPixel(15-x, y, light_pattern_brightness);
                    ledmatrixL.drawPixel(14-x, y, light_pattern_brightness);
                    ledmatrixR.drawPixel(14-x, y, light_pattern_brightness);
                  }
                    
                  ledmatrixL.displayFrame(6);
                  ledmatrixR.displayFrame(6);
                  delay(light_pattern_speed);
                  
                  for (uint8_t y = 0; y < 9; y++)
                  {
                    ledmatrixL.drawPixel(15-x, y, 0);
                    ledmatrixR.drawPixel(15-x, y, 0);
                    ledmatrixL.drawPixel(14-x, y, 0);
                    ledmatrixR.drawPixel(14-x, y, 0);
                  }
                  ledmatrixL.displayFrame(6);

                  ledmatrixR.displayFrame(6);
                }
              }
             return;
            }

//-----------------------------------------------
// pattern top to bottom
void        pattern_top_to_bottom_horizontal()

            {

            if (left_right_flag == 1)
              {            
                #ifdef FULL_RIG
                dac.setChannelValue(MCP4728_CHANNEL_C, top_to_bottom_horizontal_L, MCP4728_VREF_INTERNAL,MCP4728_GAIN_2X);
                #endif
                digitalWrite(dac_write_indicator, HIGH);   
                ledmatrixL.setFrame(6);
                for (uint8_t y = 0; y < 9; y++)
                {
                  for (uint8_t x = 0; x < 16; x++)
                  {
                    ledmatrixL.drawPixel(x, y, light_pattern_brightness);
                  }
            
                  ledmatrixL.displayFrame(6);
                  delay(light_pattern_speed);
            
                  for (uint8_t x = 0; x < 16; x++)
                  {
                    ledmatrixL.drawPixel(x, y, 0);
                  }
                  ledmatrixL.displayFrame(6);
                }
              }
            else if (left_right_flag == 2)
              {
                #ifdef FULL_RIG
                dac.setChannelValue(MCP4728_CHANNEL_C, top_to_bottom_horizontal_R, MCP4728_VREF_INTERNAL,MCP4728_GAIN_2X);
                #endif
                digitalWrite(dac_write_indicator, HIGH);   
                ledmatrixR.setFrame(6);
                for (uint8_t y = 0; y < 9; y++)
                {
                  for (uint8_t x = 0; x < 16; x++)
                  {
                    ledmatrixR.drawPixel(x, y, light_pattern_brightness);
                  }
            
                  ledmatrixR.displayFrame(6);
                  delay(light_pattern_speed);
            
                  for (uint8_t x = 0; x < 16; x++)
                  {
                    ledmatrixR.drawPixel(x, y, 0);
                  }
                  ledmatrixR.displayFrame(6);
                }
              }
              else if (left_right_flag == 4)
              {
                ledmatrixC.setFrame(6);
                for (uint8_t y = 0; y < 9; y++)
                {
                  for (uint8_t x = 0; x < 16; x++)
                  {
                    ledmatrixC.drawPixel(x, y, light_pattern_brightness);
                  }
            
                  ledmatrixC.displayFrame(6);
                  delay(light_pattern_speed);
            
                  for (uint8_t x = 0; x < 16; x++)
                  {
                    ledmatrixC.drawPixel(x, y, 0);
                  }
                  ledmatrixC.displayFrame(6);
                }
              }
              else
              {
               #ifdef FULL_RIG
                dac.setChannelValue(MCP4728_CHANNEL_C, top_to_bottom_horizontal_R, MCP4728_VREF_INTERNAL,MCP4728_GAIN_2X);
                digitalWrite(dac_write_indicator, HIGH);
                #endif
                ledmatrixL.setFrame(6);
                ledmatrixR.setFrame(6);
                for (uint8_t y = 0; y < 9; y++)
                {
                  for (uint8_t x = 0; x < 16; x++)
                  {
                    ledmatrixL.drawPixel(x, y, light_pattern_brightness);
                    ledmatrixR.drawPixel(x, 9-y, light_pattern_brightness);
                  }
            
                  ledmatrixL.displayFrame(6);
                  ledmatrixR.displayFrame(6);
                  delay(light_pattern_speed);
            
                  for (uint8_t x = 0; x < 16; x++)
                  {
                    ledmatrixL.drawPixel(x, y, 0);
                    ledmatrixR.drawPixel (x, 9-y, 0);
                  }
                  ledmatrixL.displayFrame(6);
                  ledmatrixR.displayFrame(6);
                }
              }
             return;
            }
//-----------------------------------------------
// pattern top to bottom double bars
void        pattern_top_to_bottom_horizontal_db()

            {

            if (left_right_flag == 1)
              {            
                #ifdef FULL_RIG
                dac.setChannelValue(MCP4728_CHANNEL_C, top_to_bottom_horizontal_L, MCP4728_VREF_INTERNAL,MCP4728_GAIN_2X);
                #endif
                digitalWrite(dac_write_indicator, HIGH);   
                ledmatrixL.setFrame(6);
                for (uint8_t y = 0; y < 8; y++)
                {
                  for (uint8_t x = 0; x < 16; x++)
                  {
                    ledmatrixL.drawPixel(x, y, light_pattern_brightness);
                    ledmatrixL.drawPixel(x, y+1, light_pattern_brightness);
                  }
            
                  ledmatrixL.displayFrame(6);
                  delay(light_pattern_speed);
            
                  for (uint8_t x = 0; x < 16; x++)
                  {
                    ledmatrixL.drawPixel(x, y, 0);
                    ledmatrixL.drawPixel(x, y+1, 0);
                  }
                  ledmatrixL.displayFrame(6);
                }
              }
            else if (left_right_flag == 2)
              {
                #ifdef FULL_RIG
                dac.setChannelValue(MCP4728_CHANNEL_C, top_to_bottom_horizontal_R, MCP4728_VREF_INTERNAL,MCP4728_GAIN_2X);
                #endif
                digitalWrite(dac_write_indicator, HIGH);   
                ledmatrixR.setFrame(6);
                for (uint8_t y = 0; y < 8; y++)
                {
                  for (uint8_t x = 0; x < 16; x++)
                  {
                    ledmatrixR.drawPixel(x, y, light_pattern_brightness);
                    ledmatrixR.drawPixel(x, y+1, light_pattern_brightness);
                  }
            
                  ledmatrixR.displayFrame(6);
                  delay(light_pattern_speed);
            
                  for (uint8_t x = 0; x < 16; x++)
                  {
                    ledmatrixR.drawPixel(x, y, 0);
                    ledmatrixR.drawPixel(x, y+1, 0);
                  }
                  ledmatrixR.displayFrame(6);
                }
              }
              else if (left_right_flag == 4)
              {
                ledmatrixC.setFrame(6);
                for (uint8_t y = 0; y < 8; y++)
                {
                  for (uint8_t x = 0; x < 16; x++)
                  {
                    ledmatrixC.drawPixel(x, y, light_pattern_brightness);
                    ledmatrixC.drawPixel(x, y+1, light_pattern_brightness);
                  }
            
                  ledmatrixC.displayFrame(6);
                  delay(light_pattern_speed);
            
                  for (uint8_t x = 0; x < 16; x++)
                  {
                    ledmatrixC.drawPixel(x, y, 0);
                    ledmatrixC.drawPixel(x, y+1, 0);
                  }
                  ledmatrixC.displayFrame(6);
                }
              }
              else
              {
               #ifdef FULL_RIG
                dac.setChannelValue(MCP4728_CHANNEL_C, top_to_bottom_horizontal_R, MCP4728_VREF_INTERNAL,MCP4728_GAIN_2X);
                digitalWrite(dac_write_indicator, HIGH);
                #endif
                ledmatrixL.setFrame(6);
                ledmatrixR.setFrame(6);
                for (uint8_t y = 0; y < 8; y++)
                {
                  for (uint8_t x = 0; x < 16; x++)
                  {
                    ledmatrixL.drawPixel(x, y, light_pattern_brightness);
                    ledmatrixR.drawPixel(x, 9-y, light_pattern_brightness);
                    ledmatrixL.drawPixel(x, y+1, light_pattern_brightness);
                    ledmatrixR.drawPixel(x, 8-y, light_pattern_brightness);
                  }
            
                  ledmatrixL.displayFrame(6);
                  ledmatrixR.displayFrame(6);
                  delay(light_pattern_speed);
            
                  for (uint8_t x = 0; x < 16; x++)
                  {
                    ledmatrixL.drawPixel(x, y, 0);
                    ledmatrixR.drawPixel(x, 9-y, 0);
                    ledmatrixL.drawPixel(x, y+1, 0);
                    ledmatrixR.drawPixel(x, 8-y, 0);
                  }
                  ledmatrixL.displayFrame(6);
                  ledmatrixR.displayFrame(6);
                }
              }
             return;
            }


//-----------------------------------------------
// pattern bottom to top 
void       pattern_bottom_to_top_horizontal()

            {
           
            if (left_right_flag == 1)
            {
              #ifdef FULL_RIG
              dac.setChannelValue(MCP4728_CHANNEL_C, bottom_to_top_horizontal_L, MCP4728_VREF_INTERNAL,MCP4728_GAIN_2X);
              #endif
              digitalWrite(dac_write_indicator, HIGH);   
              ledmatrixL.setFrame(6);
              for (uint8_t y = 0; y < 9; y++)
              {
                for (uint8_t x = 0; x < 16; x++)
                {
                  ledmatrixL.drawPixel(x, 9-y, light_pattern_brightness);
                }
          
                ledmatrixL.displayFrame(6);
                delay(light_pattern_speed);
          
                for (uint8_t x = 0; x < 16; x++)
                {
                  ledmatrixL.drawPixel(x, 9-y, 0);
                }
                ledmatrixL.displayFrame(6);
              }
            }
            else if (left_right_flag == 2)
            {
              #ifdef FULL_RIG
              dac.setChannelValue(MCP4728_CHANNEL_C, bottom_to_top_horizontal_R, MCP4728_VREF_INTERNAL,MCP4728_GAIN_2X);
              #endif
              digitalWrite(dac_write_indicator, HIGH);   
              ledmatrixR.setFrame(6);
              for (uint8_t y = 0; y < 9; y++)
              {
                for (uint8_t x = 0; x < 16; x++)
                {
                  ledmatrixR.drawPixel(x, 9-y, light_pattern_brightness);
                }
          
                ledmatrixR.displayFrame(6);
                delay(light_pattern_speed);
          
                for (uint8_t x = 0; x < 16; x++)
                {
                  ledmatrixR.drawPixel(x, 9-y, 0);
                }
                ledmatrixR.displayFrame(6);
              }
            } 
            else if (left_right_flag == 4)
            {
              ledmatrixC.setFrame(6);
              for (uint8_t y = 0; y < 9; y++)
              {
                for (uint8_t x = 0; x < 16; x++)
                {
                  ledmatrixC.drawPixel(x, 9-y, light_pattern_brightness);
                }
          
                ledmatrixC.displayFrame(6);
                delay(light_pattern_speed);
          
                for (uint8_t x = 0; x < 16; x++)
                {
                  ledmatrixC.drawPixel(x, 9-y, 0);
                }
                ledmatrixC.displayFrame(6);
              }
            } 
            else
            {
             #ifdef FULL_RIG
              dac.setChannelValue(MCP4728_CHANNEL_C, bottom_to_top_horizontal_R, MCP4728_VREF_INTERNAL,MCP4728_GAIN_2X);
              digitalWrite(dac_write_indicator, HIGH);
              #endif
              ledmatrixL.setFrame(6);
              ledmatrixR.setFrame(6);
              for (uint8_t y = 0; y < 9; y++)
              {
                for (uint8_t x = 0; x < 16; x++)
                {
                  ledmatrixL.drawPixel(x, 9-y, light_pattern_brightness);
                  ledmatrixR.drawPixel(x, y, light_pattern_brightness);
                }
          
                ledmatrixL.displayFrame(6);
                ledmatrixR.displayFrame(6);
                delay(light_pattern_speed);
          
                for (uint8_t x = 0; x < 16; x++)
                {
                  ledmatrixL.drawPixel(x, 9-y, 0);
                  ledmatrixR.drawPixel(x, y, 0);
                }
                ledmatrixL.displayFrame(6);
                ledmatrixR.displayFrame(6);
              }
            } 
             return;
            }
//-----------------------------------------------
// pattern bottom to top double bars
void       pattern_bottom_to_top_horizontal_db()

            {
           
            if (left_right_flag == 1)
            {
              #ifdef FULL_RIG
              dac.setChannelValue(MCP4728_CHANNEL_C, bottom_to_top_horizontal_L, MCP4728_VREF_INTERNAL,MCP4728_GAIN_2X);
              #endif
              digitalWrite(dac_write_indicator, HIGH);   
              ledmatrixL.setFrame(6);
              for (uint8_t y = 0; y < 8; y++)
              {
                for (uint8_t x = 0; x < 16; x++)
                {
                  ledmatrixL.drawPixel(x, 9-y, light_pattern_brightness);
                  ledmatrixL.drawPixel(x, 8-y, light_pattern_brightness);
                }
          
                ledmatrixL.displayFrame(6);
                delay(light_pattern_speed);
          
                for (uint8_t x = 0; x < 16; x++)
                {
                  ledmatrixL.drawPixel(x, 9-y, 0);
                  ledmatrixL.drawPixel(x, 8-y, 0);
                }
                ledmatrixL.displayFrame(6);
              }
            }
            else if (left_right_flag == 2)
            {
              #ifdef FULL_RIG
              dac.setChannelValue(MCP4728_CHANNEL_C, bottom_to_top_horizontal_R, MCP4728_VREF_INTERNAL,MCP4728_GAIN_2X);
              #endif
              digitalWrite(dac_write_indicator, HIGH);   
              ledmatrixR.setFrame(6);
              for (uint8_t y = 0; y < 8; y++)
              {
                for (uint8_t x = 0; x < 16; x++)
                {
                  ledmatrixR.drawPixel(x, 9-y, light_pattern_brightness);
                  ledmatrixR.drawPixel(x, 8-y, light_pattern_brightness);
                }
          
                ledmatrixR.displayFrame(6);
                delay(light_pattern_speed);
          
                for (uint8_t x = 0; x < 16; x++)
                {
                  ledmatrixR.drawPixel(x, 9-y, 0);
                  ledmatrixR.drawPixel(x, 8-y, 0);
                }
                ledmatrixR.displayFrame(6);
              }
            } 
            else if (left_right_flag == 4)
            {
              ledmatrixC.setFrame(6);
              for (uint8_t y = 0; y < 8; y++)
              {
                for (uint8_t x = 0; x < 16; x++)
                {
                  ledmatrixC.drawPixel(x, 9-y, light_pattern_brightness);
                  ledmatrixC.drawPixel(x, 8-y, light_pattern_brightness);
                }
          
                ledmatrixC.displayFrame(6);
                delay(light_pattern_speed);
          
                for (uint8_t x = 0; x < 16; x++)
                {
                  ledmatrixC.drawPixel(x, 9-y, 0);
                  ledmatrixC.drawPixel(x, 8-y, 0);
                }
                ledmatrixC.displayFrame(6);
              }
            } 
            else
            {
             #ifdef FULL_RIG
              dac.setChannelValue(MCP4728_CHANNEL_C, bottom_to_top_horizontal_R, MCP4728_VREF_INTERNAL,MCP4728_GAIN_2X);
              digitalWrite(dac_write_indicator, HIGH);
              #endif
              ledmatrixL.setFrame(6);
              ledmatrixR.setFrame(6);
              for (uint8_t y = 0; y < 8; y++)
              {
                for (uint8_t x = 0; x < 16; x++)
                {
                  ledmatrixL.drawPixel(x, 9-y, light_pattern_brightness);
                  ledmatrixR.drawPixel(x, y, light_pattern_brightness);
                  ledmatrixL.drawPixel(x, 8-y, light_pattern_brightness);
                  ledmatrixR.drawPixel(x, y+1, light_pattern_brightness);
                }
          
                ledmatrixL.displayFrame(6);
                ledmatrixC.displayFrame(6);
                ledmatrixR.displayFrame(6);
                delay(light_pattern_speed);
          
                for (uint8_t x = 0; x < 16; x++)
                {
                  ledmatrixL.drawPixel(x, 9-y, 0);
                  ledmatrixR.drawPixel(x, y, 0);
                  ledmatrixL.drawPixel(x, 8-y, 0);
                  ledmatrixR.drawPixel(x, y+1, 0);
                }
                ledmatrixL.displayFrame(6);
                ledmatrixR.displayFrame(6);
              }
            } 
             return;
            }


void       tone_ON(uint8_t lrflag, uint8_t freq)

{
        Wire.beginTransmission(9); // transmit to device #9
        Wire.write(lrflag);              // sends x 
        Wire.write(freq);              // sends y 
        Wire.write(skip);              // sends skip 
        Wire.endTransmission();    // stop transmitting
        

        #ifdef FULL_RIG
        dac_single.begin(0x62);
        dac_single.setVoltage(dac_val_audio, false);          
        #endif


         if (freq == 0)  // 0 means tone off
         {
            digitalWrite(dac_write_indicator_audio, LOW);   
         }
         else
         {
            digitalWrite(dac_write_indicator_audio, HIGH);   
         }
}


void       tone_OFF(uint8_t lrflag)
{
//        dac.setChannelValue(MCP4728_CHANNEL_D, 0, MCP4728_VREF_INTERNAL,MCP4728_GAIN_2X);
        digitalWrite(dac_write_indicator_audio,LOW );   
        Wire.beginTransmission(9); // transmit to device #9
        Wire.write(lrflag);              // sends x 
        Wire.write(0);              // sends x 
        Wire.write(skip);              // sends x 
        Wire.endTransmission();    // stop transmitting

        
        #ifdef FULL_RIG
        dac_single.begin(0x62);
        dac_single.setVoltage(00, false);          
        #endif
}
//freq


void       start_visual(uint8_t lrflag)

{
         
        temp = 0;  
        if (bitRead(left_right_flag_visual,0) == 1)
          {
          switch (panel_mode)
          {
           case 2:
            temp = stripes_vertical_L;
             break;
           case 3:
            temp = stripes_horizontal_L;           
             break;
           case 4:
            temp = stripes_angled_M45_L; // for full panel
             break;
           case 5:
            temp = stripes_angled_P45_L;
             break;
           case 6:
            temp = stripes_angled_M45_L;
             break;
          }

           ledmatrixL.setFrame(panel_mode);
           ledmatrixL.displayFrame(panel_mode);
          }
           #ifdef FULL_RIG
           dac.setChannelValue(MCP4728_CHANNEL_C, temp, MCP4728_VREF_INTERNAL,MCP4728_GAIN_2X);
           #endif
           digitalWrite(dac_write_indicator, HIGH);   


          
         if (bitRead(left_right_flag_visual,1) == 1)
          {
          switch (panel_mode)
          {
           case 2:
            temp = stripes_vertical_R;
             break;
           case 3:
            temp = stripes_horizontal_R;           
             break;
           case 4:
            temp = stripes_angled_M45_R; // for full panel
             break;
           case 5:
            temp = stripes_angled_P45_R;
             break;
           case 6:
            temp = stripes_angled_M45_R;
             break;
          }
            ledmatrixR.setFrame(panel_mode);
            ledmatrixR.displayFrame(panel_mode);
          }
            #ifdef FULL_RIG
            dac.setChannelValue(MCP4728_CHANNEL_C, temp, MCP4728_VREF_INTERNAL,MCP4728_GAIN_2X);
            #endif
          digitalWrite(dac_write_indicator, HIGH);   

}




void init_angled_stripes(uint8_t leftright,uint8_t page, uint8_t nstripes,uint8_t angle) 
{

  digitalWrite(Test1, HIGH);


  
  if (leftright == 0)
    ledmatrixL.setFrame(page);
   else
    ledmatrixR.setFrame(page);
  

  uint16_t x = 0;
  uint8_t y = 0;
  uint8_t bt = 0;
  uint8_t mod = 0;
  uint16_t  ref = 0;
  
 
  switch (nstripes)
  {
    case 1:
//      ref = (B01010101 * 256) + B01010101;
      ref = (B10010010 * 256) + B01001001;
      mod = 18;
      break;
    case 2:
      ref = (B00110011 * 256) + B00110011; 
      mod = 16;
      break;
    case 3:
      ref = (B01110001 * 256) + B11000111;
      mod = 18;
      break;
  }
  
  while (y<10)
  {
    for (uint8_t cnt=0; cnt<16; cnt++)
    {
      bt = light_pattern_brightness*bitRead(ref,x);
      if (angle == 0)
      {
       if (leftright == 0)
          ledmatrixL.drawPixel(cnt,y,bt);
        else
          ledmatrixR.drawPixel(cnt,y,bt);
      }
      else
      {
       if (leftright == 0)       
           ledmatrixL.drawPixel(cnt,9-y,bt);
       else
           ledmatrixR.drawPixel(cnt,9-y,bt);
      }   
      x = (x + 1)%mod;
    }
    y = y + 1;
    x = y;
  }
digitalWrite(Test1, LOW);

}  

  
void init_single_stripe(uint8_t leftright,uint8_t page, uint8_t width ,uint8_t angle) 
{


  
   digitalWrite(Test1, HIGH);
  
  if (leftright == 0)
    ledmatrixL.setFrame(page);
   else
    ledmatrixR.setFrame(page);


      if (angle == 0)    // horizontal
      {
        switch (width)
        {
          case 1:
            if (leftright == 0)
            {
              ledmatrixL.clear();
              ledmatrixL.drawRect(7,0, 1, 9,light_pattern_brightness);       
            }
            else
            {
              ledmatrixR.clear();
              ledmatrixR.drawRect(7,0, 1, 9,light_pattern_brightness);       
            }
            break;
          case 2:
            if (leftright == 0)
            {
              ledmatrixL.clear();
              ledmatrixL.drawRect(7,0, 2, 9,light_pattern_brightness);       
            }
            else
            {
              ledmatrixR.clear();
              ledmatrixR.drawRect(7,0, 2, 9,light_pattern_brightness);       
            }
            break;
          case 3:
            if (leftright == 0)
            {
              ledmatrixL.clear();
              ledmatrixL.drawRect(6,0, 3, 9,light_pattern_brightness);       
              ledmatrixL.drawRect(7,0, 1, 9,light_pattern_brightness);       
            }
            else
            {
              ledmatrixR.clear();
              ledmatrixR.drawRect(6,0, 3, 9,light_pattern_brightness);       
              ledmatrixR.drawRect(7,0, 1, 9,light_pattern_brightness);       
            }
            break;
        }
        
      }
      else              // vertical
      {
        switch (width)
        {
          case 1:
            if (leftright == 0)
            {
              ledmatrixL.clear();
              ledmatrixL.drawRect(4,4, 9, 1,light_pattern_brightness);       
            }
            else
            {
              ledmatrixR.clear();
              ledmatrixR.drawRect(4,4, 9, 1,light_pattern_brightness);       
              
            }
            break;
          case 2:
            if (leftright == 0)
            {
              ledmatrixL.clear();
              ledmatrixL.drawRect(4,3, 9, 2,light_pattern_brightness);       
            }
            else
            {
              ledmatrixR.clear();
              ledmatrixR.drawRect(4,3, 9, 2,light_pattern_brightness);       
              
            }
            break;
          case 3:
            if (leftright == 0)
            {
              ledmatrixL.clear();
              ledmatrixL.drawRect(4,3, 9, 3,light_pattern_brightness);       
              ledmatrixL.drawRect(4,4, 9, 1,light_pattern_brightness);       
            }
            else
            {
              ledmatrixR.clear();
              ledmatrixR.drawRect(4,3, 9, 3,light_pattern_brightness);       
              ledmatrixR.drawRect(4,4, 9, 1,light_pattern_brightness);       
            }
            break;
        }
        
      }
}


void init_straight_stripes(uint8_t leftright,uint8_t page, uint8_t nstripes,uint8_t angle) 
{

  digitalWrite(Test1, HIGH);
  


  if (leftright == 0)
    ledmatrixL.setFrame(page);
     else
    ledmatrixR.setFrame(page);
  
  uint16_t x = 0;
  uint8_t y = 0;
  uint8_t bt = 0;
  uint8_t mod = 0;
  uint16_t  ref = 0;


  switch (nstripes)
  {
    case 1:
//      ref = (B01010101 * 256) + B01010101;
      ref = (B10010010 * 256) + B01001001;
      break;
    case 2:
      ref = (B00110011 * 256) + B00110011; 
      break;
    case 3:
      ref = (B01110001 * 256) + B11000111;
      break;
  }

  if (angle == 0)
  {
  for (y=0;y<10;y++)
  {
    for (uint8_t cnt=0; cnt<16; cnt++)
    {
      bt = light_pattern_brightness*bitRead(ref,cnt);
       if (leftright == 0)
          ledmatrixL.drawPixel(cnt,y,bt);
        else
          ledmatrixR.drawPixel(cnt,y,bt);
    }
  }
  }
else
  {
  for (x = 0; x<16; x++)
  {
    for (uint8_t cnt=0; cnt<9; cnt++)
    {
      bt = light_pattern_brightness*bitRead(ref,cnt);
       if (leftright == 0)
          ledmatrixL.drawPixel(x,cnt,bt);
        else
          ledmatrixR.drawPixel(x,cnt,bt);
    }
  }
}
digitalWrite(Test1, LOW);
}  
  
  
  
