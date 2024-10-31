function ot = print_settings_gonogo(app)

ot = [];
idx = 1;

% create header containing parameter information
hhh = fieldnames(app);
for i = 1:length(hhh)
     % i
   s = app.(hhh{i});
    if ~isa(s,'numeric')
        if ~strcmp(hhh{i},'opto')
            if~isempty(s) 
                if  ~isprop(s,'Port')
                    if isobject(s)
                        if  isprop(s,'Type')
                            if strcmp(s.Type,'uieditfield')
                                    fprintf('%s     %s \n',hhh{i}, s.Value);
                                    st = [hhh{i}, '   ',s.Value];
                                    ot{idx} = st;
                                    idx = idx + 1;
                            end
                            if strcmp(s.Type,'uinumericeditfield')
                                        fprintf('%s     %4.1f \n',hhh{i}, s.Value);
                                        st = [hhh{i}, '   ',num2str(s.Value)];
                                        ot{idx} = st;
                                        idx = idx + 1;
                             end
                             if strcmp(s.Type,'uicheckbox')
                                    fprintf('%s     %d \n',hhh{i}, s.Value);
                                    st = [hhh{i}, '   ',num2str(s.Value)];
                                    ot{idx} = st;
                                    idx = idx + 1;
                            end
                        end
                    end
                end
            end
        end
    end
end