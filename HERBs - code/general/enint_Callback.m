
% --- Executes on button press in enint.
function enint_Callback(app)
% hObject    handle to enint (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global arduino;
write(arduino,'p',"uint8");
% fprintf('enable int at %3.3f\n',toc);
