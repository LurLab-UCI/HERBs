function light_Callback(vl1,vl2)
% hObject    handle to lightr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global arduino;
global dac_val_table;
                        
dac_val = dac_val_table(vl1+1,vl2+1);
write(arduino,['r' vl1 vl2 dac_val],"uint8");
