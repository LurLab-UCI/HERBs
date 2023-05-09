% --- Executes on button press in reward1.
function reward_Callback(app,str)
% hObject    handle to reward1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global arduino;


switch str
    case 'R'
        write(arduino,'x',"uint8");  %right
        fprintf('%4.3f reward_R \n',toc);
    case 'L'
        write(arduino,'y',"uint8"); %left
        fprintf('%4.3f reward_L \n',toc);
    case 'C'
        write(arduino,'z',"uint8"); % center
        fprintf('%4.3f reward_C \n',toc);
end


