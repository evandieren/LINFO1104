declare
fun {Counter L}
   fun {UpdateCounter L C}
      case L
      of (S#N)|T then
        if S == C then (C#N+1)|T
        else (S#N)|{UpdateCounter T C} end
      else C#1|nil end
   end
   fun {CounterAux L P}
      case L of C|T then U in
        U = {UpdateCounter P C}
        U|{CounterAux T U}
      else nil end
   end
in
   thread {CounterAux L nil} end
end

declare InS
{Browse {Counter InS}}
InS = a|b|a|c|_

% sup
declare
fun {Not X}
   1-X
end
fun {NotGate Xs}
   fun {NotGateAux L}
      case L
      of H|T then {Not H}|{NotGateAux T}
      else nil end
   end in
   thread {NotGateAux Xs} end
end
fun {AndGate Xs Ys}
   fun {AndGateAux X Y}
      case X#Y
      of (H1|Xs)#(H2|Ys) then
        H1*H2|{AndGateAux Xs Ys}
      else nil end
   end in
   thread {AndGateAux Xs Ys} end
end
fun {OrGate Xs Ys}
   fun {OrGateAux X Y}
      case X#Y
      of (H1|Xs)#(H2|Ys) then
        (H1+H2 - H1*H2)|{OrGateAux Xs Ys}
      else nil end
   end in
   thread {OrGateAux Xs Ys} end
end
declare
fun {Simulate G Ss}
   fun {GetInput G N}
      case G.N
      of input(X) then Ss.X
      [] gate(...) then {Simulate G.N Ss} end
   end
in
   thread
      case G of gate(value:Op ...) then
        case Op
        of 'not' then {NotGate {GetInput G 1}}
        [] 'and' then {AndGate {GetInput G 1} {GetInput G 2}}
        [] 'or' then {OrGate {GetInput G 1} {GetInput G 2}}
        end
      end
   end
end

declare
G = gate(value:'or'
   gate(value:'and'
        input(x)
        input(y))
   gate(value:'not' input(z)))
Ss
{Browse {Simulate G Ss}}
Ss = input(x: 1|0|1|0|_ y:0|1|0|1|_ z:1|1|0|0|_)


% 3
declare
fun {MakeBinaryGate F} % complexity O(1)
   fun {FG X Y}
      case X#Y
      of (H1|Xs)#(H2|Ys) then
        {F H1 H2}|{FG Xs Ys}
      else nil end
   end in
   fun {$ Xs Ys} thread {FG Xs Ys} end end % complexité O(1)
end
fun {And A B} A*B end
fun {Or A B} A+B - A*B end
fun {Xor A B} (A+B) mod 2 end
fun {Nor A B} 1 - {Or A B} end

XorG = {MakeBinaryGate Xor}
AndG = {MakeBinaryGate And}
OrG = {MakeBinaryGate Or}
NorG = {MakeBinaryGate Nor}

declare
X = [0 0 1 1]
Y = [0 1 0 1]
{Browse {AndG X Y}}
{Browse {OrG X Y}}
{Browse {XorG X Y}}
{Browse {NorG X Y}}
