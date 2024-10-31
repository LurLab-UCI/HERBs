     
function write_excel_file(state,fname)

warning off MATLAB:xlswrite:AddSheet
sheet_index = 1;

if ~isempty(state.checkboxes_tag)
    writecell(state.checkboxes_tag',fname,'Sheet',sheet_index,'Range','A1:A100');
    writematrix(state.checkboxes_value',fname,'Sheet',sheet_index,'Range','B1:B100');
    sheet_index = sheet_index + 1;
end

if ~isempty(state.editfields_tag)
    writecell(state.editfields_tag',fname,'Sheet',sheet_index,'Range','A1:A100');
    writecell(state.editfields_value',fname,'Sheet',sheet_index,'Range','B1:B100');
    sheet_index = sheet_index + 1;
end

if ~isempty(state.numeric_editfields_tag)
    writecell(state.numeric_editfields_tag',fname,'Sheet',sheet_index,'Range','A1:A100');
    writecell(state.numeric_editfields_value',fname,'Sheet',sheet_index,'Range','B1:B100');
    sheet_index = sheet_index + 1;
end

if ~isempty(state.radiobuttons_tag)
    writecell(state.radiobuttons_tag',fname,'Sheet',sheet_index,'Range','A1:A100');
    writecell(state.radiobuttons_value',fname,'Sheet',sheet_index,'Range','B1:B100');
    sheet_index = sheet_index + 1;
end

if ~isempty(state.dropdowns_tag)
    writecell(state.dropdowns_tag',fname,'Sheet',sheet_index,'Range','A1:A100');
    writecell(state.dropdowns_value',fname,'Sheet',sheet_index,'Range','B1:B100');
end