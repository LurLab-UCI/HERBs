     
function loadStatus(app,fn)

load(fn);

h = findobj(app.figure1,'Type','uicheckbox');
for i = 1:length(h)
    try
           h(i).Value = state.checkboxes_value(i);
    catch
        break;
    end
end

 h = findobj(app.figure1,'Type','uieditfield');
 for i = 1:length(h)
     try
        h(i).Value = state.editfields_value{i};
     catch
         break;
     end
 end

 h = findobj(app.figure1,'Type','uinumericeditfield');
 for i = 1:length(h)
     try
        h(i).Value = state.numeric_editfields_value{i};
     catch
         break;
     end
 end


 h = findobj(app.figure1,'Type','uiradiobutton');
  for i = 1:length(h)
      try
        h(i).Value = state.radiobuttons_value{i};
      catch
          break;
      end
  end

 h = findobj(app.figure1,'Type','uiDropDown');
  for i = 1:length(h)
      try
        h(i).Value = state.dropdowns_value{i};
      catch
          break
      end
  end

 app.figure1.Position = ps;

       
        