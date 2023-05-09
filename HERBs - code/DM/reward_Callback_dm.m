% --- Executes on button press in reward1.
function reward_Callback_dm(app,str)
% hObject    handle to reward1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global arduino;
global reward_denied;

% potentially deny rewards only in retrial mode  5/2/2023
if app.retrial_mode.Value
        % if reward_denied && app.training_reward.Value        old code befo
        if reward_denied && (rand  >  (app.percent_retrial_rewards.Value)/100 )
                fprintf('%4.3f reward denied \n',toc);
                return; 
        end
end

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


