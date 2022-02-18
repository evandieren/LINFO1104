declare
B=Browse
local
   fun {WhatsThis R}
      if {IsList R} then list else
   if {IsTuple R} then tuple else
      record
   end
      end
   end
   T1=t1
   T2=t2
in
% Tuple de Label | et de 2 Fields à Features implicites
% Liste
% Liste (Les Features sont simplement inversees ([a]))
% Tuple de Label state et de 3 Fields à Features implicites
% Tuple de label state et Fields désordonnes
% Record de Lable tree et de Features v 1 et 2
% Tuple
% Liste
% Tuple
   {B {WhatsThis  [a b c]}}

end
