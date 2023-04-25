function  cond = get_no_punish_condition(app)
global lightval;
global training_rate_selected;

 if app.SideDiscrimination.Value % if no punish on test panels
        cond = (app.no_test_punishment.Value && lightval >0 && lightval<7 ) ;
 else
         cond = app.no_test_punishment_rd.Value  && training_rate_selected;
 end     
  