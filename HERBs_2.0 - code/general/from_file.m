function [next_spout] = from_file(app)

global from_file_count fidtxt type run;

next_spout = 0;

if from_file_count == 0
%     read new line

    c = fgets(fidtxt);
    if c == -1
        run = 0;
        return;
    end
    
    q = textscan(c,'%d %c');
    from_file_count = q{1};
    type = q{2};
    from_file_count = from_file_count - 1;

else
%     continue
    from_file_count = from_file_count - 1;
    
end

if strcmp(type,'L')
    next_spout = 0;
else
    next_spout = 1;
end
    
    
