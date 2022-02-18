declare
fun {MakeBinaryGate F}
   fun {$ Stream1 Stream2}
      fun {Helper S1 S2}
     case S1#S2
     of (H1|T1)#(H2|T2) then
        {F H1 H2}|{Helper T1 T2}
     [] nil#nil then
        nil
     end
      end
   in
      thread {Helper Stream1 Stream2} end
   end
end

AndGate = {MakeBinaryGate fun {$ X Y} X * Y end}
OrGate = {MakeBinaryGate fun {$ X Y} (X + Y) - (X * Y) end}
NotGate = {MakeBinaryGate fun {$ X} 1 - X end}

fun {SimulateAux G Ss}
   if ({Not {Value.hasFeature G value}}) then
   G
   else
      if (G.value == 'and') then {AndGate {Simulate G.1 Ss} {Simulate G.2 Ss}}
      else
         if (G.value == 'or') then {OrGate {Simulate G.1 Ss} {Simulate G.2 Ss}}
         else
            {NotGate {Simulate G.1 Ss}}
         end
      end
   end
end

fun {Simulate G Ss}
thread
  {SimulateAux G Ss}
  end
end

declare Ss G
Ss=input(x: 1|0|1|0|_ y:0|1|0|1|_ z:1|1|0|0_)
G = gate(value:'or' gate(value:'and' Ss.x Ss.y) gate(value:'not' Ss.z))
{Browse {Simulate G Ss}}
