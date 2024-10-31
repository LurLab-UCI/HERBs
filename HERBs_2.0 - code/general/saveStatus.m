  function state = saveStatus(app,fn)
            
    h = findobj(app.figure1,'Type','uicheckbox');
    xa = [];
    ya = [];
    state.checkboxes_value = xa;
    state.checkboxes_tag =  ya;
    if ~isempty(h)
        xarr = zeros(length(h),1);
        for i = 1:length(h)
           xa(i) = h(i).Value;
           ya{i} = h(i).Tag;
        end
        state.checkboxes_value = xa;
        state.checkboxes_tag =  ya;
    end

     h = findobj(app.figure1,'Type','uieditfield');
    xa = [];
    ya = [];
    state.editfields_value = xa;
    state.editfields_tag =  ya;
     if ~isempty(h)
         for i = 1:length(h)
            xa{i} = h(i).Value;
            ya{i} = h(i).Tag;
         end
        state.editfields_value = xa;
        state.editfields_tag =  ya;
     end

     h = findobj(app.figure1,'Type','uinumericeditfield');
    xa = [];
    ya = [];
    state.numeric_editfields_value = xa;
    state.numeric_editfields_tag =  ya;
    if ~isempty(h)
         for i = 1:length(h)
            xa{i} = h(i).Value;
            ya{i} = h(i).Tag;
         end
        state.numeric_editfields_value = xa;
        state.numeric_editfields_tag =  ya;
     end

     h = findobj(app.figure1,'Type','uiradiobutton');
    xa = [];
    ya = [];
    state.radiobuttons_value = xa;
    state.radiobuttons_tag =  ya;
     if ~isempty(h)
         for i = 1:length(h)
            xa{i} = h(i).Value;
            ya{i} = h(i).Tag;
         end
        state.radiobuttons_value = xa;
        state.radiobuttons_tag =  ya;
     end

     h = findobj(app.figure1,'Type','uiDropDown');
    xa = [];
    ya = [];
    state.dropdowns_value = xa;
    state.dropdowns_tag =  ya;
     if ~isempty(h)
         for i = 1:length(h)
                 xa{i} = h(i).Value;
                  ya{i} = h(i).Tag;
          end
        state.dropdowns_value = xa;
        state.dropdowns_tag =  ya;
     end
     

   ps = app.figure1.Position;
   save(fn,'state','ps');

  end