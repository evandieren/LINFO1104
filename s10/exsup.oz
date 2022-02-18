declare

fun {NotGate A}
  case A of
  H|T then
    if A == 0 then
      1|{NotGate T}
    else
      0|{NotGate T}
    end
  end
end

fun {AndGate A B}
  case A#B of
  (H|T)#(L|J) then
    if H==1 andthen L==1 then
      1|{AndGate T J}
    else
      0|{AndGate T J}
    end
  end
end
fun {OrGate A B}
  case A#B of
  (H|T)#(L|J) then
    if {Max H L}==1 then
      1|{OrGate T J}
    else
      0|{OrGate T J}
    end
  end
end

fun {ProduceTF} % 1 [s] per call
  local Aux in
     fun {Aux}
      {Delay 1000}
      ({OS.rand} mod 2)|{Aux}
     end
     {Aux}
   end
end

A1
A2
A1A2
A1A2B
thread A1 = {ProduceTF} end
thread A2 = {ProduceTF} end
thread A1A2 = {AndGate A1 A2} end
thread A1A2B = {OrGate A1 A2} end
{Browse source1}
{Browse A1}
{Browse source2}
{Browse A2}
{Browse andgate}
{Browse A1A2}
{Browse orgate}
{Browse A1A2B}

fun {Simulate G A}

  thread
   case {Label G} of gate then
      case G.value of
        'or' then {OrGate {Simulate G.1 A} {Simulate G.2 A}}
        [] 'and' then {AndGate {Simulate G.1 A} {Simulate G.2 A}}
        [] 'not' then {NotGate {Simulate G.1 A}}
      end
      [] input then A.(G.1)
      end
   end
end

G = gate(value:'or' gate(value:'and' input(x) input(y)) gate(value:'not' input(z)))
SS = input(x: 1|0|1|0|_ y:0|1|0|1|_ z:1|1|0|0|_)
{Browse simulate}
{Browse {Simulate G SS}}
