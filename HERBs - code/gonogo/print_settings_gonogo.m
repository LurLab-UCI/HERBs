function print_settings_gonogo(app)

% create header containing parameter information
hhh = fieldnames(app);
for i = 1:length(hhh)
   s = app.(hhh{i});
   if strcmp(s.Type,'uieditfield')
            fprintf('%s     %s \n',hhh{i}, s.Value);
    end
end

for i = 1:length(hhh)
   s = app.(hhh{i});
   if strcmp(s.Type,'uinumericeditfield')
            fprintf('%s     %4.1f \n',hhh{i}, s.Value);
    end
end

for i = 1:length(hhh)
   s = app.(hhh{i});
   if strcmp(s.Type,'uicheckbox')
            fprintf('%s     %d \n',hhh{i}, s.Value);
    end
end

