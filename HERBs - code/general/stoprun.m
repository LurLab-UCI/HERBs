function stoprun(app,~)
global run;
run  =  0;
fprintf('%4.3f   experiment ended \n',toc);