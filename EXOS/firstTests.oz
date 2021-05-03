


%%%% TP 1 %%%%%%%

local
   X
in
   X = 1
   {Browse X}
end
{Browse X}


% Signe d'un nombre
declare
fun {Signe N}
   if (N > 0) then 1
   else
      if (N < 0) then ~1
      else
	 0
      end
   end
end
{Browse {Signe 0}}


%Exo 8

local P Q X Y Z in

   local Y
   in
      Y = X
      fun {P X}
         X*Y + Z
      end
   end
   
   local Z
   in
      Z = Y
      fun {Q Y}
	 X*Y+Z
      end
   end
   
   X=1
   Y=2
   Z=3
   {Browse {P 4}}
   {Browse {Q 4}}
   {Browse {Q {P 4}}}
   {Browse {P Z}}
end


#Exo 9

declare
X = 3

proc {Add2}
   {Browse (X+2)}
end

proc {Mult2}
   {Browse (X*2)}
end

{Add2}
{Mult2}

# PARTIE 2 - EXO 2

declare

fun {Miroir N}
   fun {MiroirAux N A}
      if N == 0 then A
      else
	 {MiroirAux (N div 10) A*10 + (N mod 10)}
      end
   end
in
   {MiroirAux N 0}
end

{Browse {Miroir 12345}}


declare
proc {CountDown N}
   if N \= ~1 then
      {Browse N}
      {CountDown N-1}
   end
end

# PARTIE EXTRA


declare
fun {Aux N M}
   if (M == {Float.toInt {Sqrt {Int.toFloat N}}}) then true
   else
      if ((N mod M) == 0) then false
      else
	 {Aux N M+1}
      end
   end
end

fun {Premier N}
   {Aux N 2}
end

declare
fun {Fibonacci N}
   fun {FibonacciAux N A B}
      if N == 0 then A
      elseif N == 1 then B
      else
	 {FibonacciAux N-1  B A+B}
      end
   end
in
   {FibonacciAux N 0 1}
end

# EXO 4 (Manque PPCM flemme)
declare
fun {PGCD N M}
   if (M == 0) then N
   elseif (N == 0) then M
   else
      if (N >= M) then {PGCD (N mod M) M}
      else
	 {PGCD (M mod N) N}
      end
   end
end

# EXO 6

declare
fun {Compteur N A I}
   if (N == I) then (A+1)
   else
      if ((N mod I) == 0) then {Compteur N A+1 I+1}
      else
	 {Compteur N A I+1}
      end
   end
end

fun {Pave N} {Compteur N 0 1} end

%%%% TP 2 %%%%%%%

%EXO 1
declare
L1=[a]
L2=[a [b c] d]
L3=[proc {$} {Browse oui} end proc {$} {Browse non} end]
L4=[est une liste]
L5=[[a p]]

L6 = '|'(a nil)
L7 = '|'(a '|'('|'(b '|'(c nil))'|'(d nil)))
% L8 = '|' (({proc {$} {Browse oui} end}) '|' ( ({proc {$} {Browse non} end}) nil))
L9 = ceci | L4
{L3.1}
{Browse L2.2}

declare
fun {Head A}
   A.1
end

fun {Tail A}
   A.2
end

%EXO 2

declare
fun {Length L}
   fun {LengthAux L A}
      case L
      of H|T then {LengthAux L.2 A+1}
      [] nil then A
      end
   end
in
   {LengthAux L 0}
end

%EXO 4

declare
fun {PatternMatching A}
   case A
   of nil then empty
   [] H|T then nonEmpty
   else
      other
   end
end

fun {Head A}
   case A
   of nil then empty
   [] H|T then H
   else
      other
   end
end

fun {Tail A}
   case A
   of nil then empty
   [] H|T then T
   else
      other
   end
end
   
fun {Length A B}
   case A
   of nil then B
   [] H|T then {Length A.2 B+1}
   else
      erreur
   end
end


declare
fun {Append A B}
   if (A == nil) then B
   elseif (B == nil) then A
   else
      A.1 | {Append A.2 B}
   end
end

{Browse {Append [r a] [p h]}}


declare
fun {Append A B}
   case A
   of nil then B
   [] H|T then
      case B
      of nil then A
      [] H|T then
	 A.1|{Append A.2 B}
      end
   end
end


declare
fun {Take L A}
   if A == 0 then nil
   else
      case L
      of nil then nil
      [] H|T then L.1 | {Take L.2 A-1}
      end
   end
end

declare
fun {Drop L A}
   case L
   of nil then nil
   [] H|T then
      if A \= 0 then {Drop L.2 A-1}
      else
	 L
      end
   end
end

% TP 2 . EXTRA

%1 Flatten

declare
fun {Flatten X}
   fun {FlattenAux X Y}
      if (X == nil) then Y
      else
	 if ({IsList X.1}) then
	    {FlattenAux X.2 {Append Y {FlattenAux X.1 nil}}}
	 else
	    {FlattenAux X.2 {Append Y [X.1]}}
	 end
      end
   end
in
   {FlattenAux X nil}
end

declare
fun {Flatten2 X}
   case X
   of H|T then {Append {Flatten2 H} {Flatten2 T}}
   [] nil then nil
   else
      [X]
   end
end

%%10

declare
fun {PromenadeAux BT L} % Noeud gauche droite
   case BT of btree(V left:TL right:TR) then
      V | {PromenadeAux TL {PromenadeAux TR L}}
   [] empty then L
   end
end

declare
fun {Promenade BT}
   {PromenadeAux BT nil}
end

%%11

declare
fun {DictionaryFilter D F}
   case D
   of dict(key:K info:I left:L right:R) then
      if {F I} then
	 K#I | {Append {DictionaryFilter L F} {DictionaryFilter R F}}
      else
	 {Append {DictionaryFilter L F} {DictionaryFilter R F}}
      end
   [] leaf then nil
   end
end


local Old Class Val in
   Class = dict(key:10
		info:person('Christian' 19)
		left:dict(key:7
			  info: person('Denys' 25)
			  left:leaf
			  right:dict(key:9
				     info:person('David' 7)
				     left:leaf
				     right:leaf))
		right:dict(key:18
			   info:person('Rose' 12)
			   left:dict(key:14
				     info:person('Ann' 27)
				     left:leaf
				     right:leaf)
			   right:leaf))
   fun {Old Info}
      Info.2 > 20
   end
   Val = {DictionaryFilter Class Old}
   {Browse Val}
   % Val --> [7#person('Denys'25) 14#person('Ann'27)]
end

%%12



%%%%TP 3

local MakeAdd Add1 Add2 B C in
   proc {MakeAdd X Add}
      proc {Add Y Z}
	 Z = X + Y
      end
   end
   B = 1
   C = 2
   {MakeAdd B Add1}
   {MakeAdd C Add2}

   local V D in
      D = 42
      {Add1 D V}
      {Browse V}
   end

   local V E in
      E = 42
      {Add2 E V}
      {Browse V}
   end
end

%%%%TP 4

declare
fun {MakeMulFilter N}
   fun {$ I}
      I mod N == 0
   end 
end

%%EXO 2
declare
fun {MakeMulFilter N}
   fun {$ I}
      I mod N == 0
   end 
end

declare
fun {Filter A F}
   case A
   of H|T then
      if {F H}
      then H | {Filter T F}
      else
	 {Filter T F}
      end
   [] nil then nil
   end
end



declare
fun {Random N} {OS.rand} mod N + 1 end

declare
fun {Shuffle L}
   local Arr R Len Count Result I in
      Len = {List.length L}
      Arr = {NewArray 1 Len 0}
      I = {NewCell 0}   
      for X in L do
	 Arr.@I := X
	 I := @I+1
      end
      Count = {NewCell Len}
      Result = {NewCell nil}
      R = {NewCell 0}
      for Y in Len..1;~1 do
	 R := {Random Y}
	 Result := Arr.@R | @Arr
	 Arr.R := Arr.@Count
	 Count := @Count - 1
      end
      {List.reverse @Result}
   end
end
{Browse {Shuffle [1 2 3]}}


 
declare
fun {Shuffle Xs}
   local T Len R Count Arr in
    Len = {List.length Xs}
    T = {NewArray 1 Len 0}
    for Y in 1..Len do
        T.Y := {List.nth Xs Y}
    end
    Count = {NewCell Len}
    Arr = {NewCell nil}
    R = {NewCell 0}
    for Y in Len..1;~1 do
        R := {Random Y}
        Arr := T.@R | @Arr
        T.@R := T.@Count
        Count := @Count - 1
    end
    {List.reverse @Arr}
   end
end

{Browse {Shuffle [1 2 3]}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%TP 9

 
declare
fun {MakeBinaryGate F}
   fun {$ Xs Ys} % On va return une fonction (donc un higher order N = 1)
      local GateLoop in
        fun {GateLoop Xs Ys} % Ici on chope les deux Streams et les concatène pour pouvoir faire du patern mathcing
           case Xs#Ys of (X|Xr)#(Y|Yr) then
              {F X Y}|{GateLoop Xr Yr} % On applique F sur les deux têtes et on call GateLoop sur les deux queues
           end
        end
        thread {GateLoop Xs Ys} end % On lance le thread de GateLoop sur Xs et Ys après l'avoir défini ci-dessus.
      end
   end
end

AndG = {MakeBinaryGate fun {$ X Y} X *Y end} % On crée le AndGate (en utilisant fun ...)
Stream1 = 0|1|1|0|_ % Nos deux streams
Stream2 = 1|1|0|0|_
Stream3 = {AndG Stream1 Stream2} % La solution

{Browse Stream1}
{Browse Stream2}
{Browse Stream3}



declare
fun {Not X}
   1-X
end

fun {NotGate Str}
   fun {NotGateAux L} %Fonction annexe qui applique Not sur le stream donné en input
      case L
      of H|T then {Not H}|{NotGateAux T}
      else nil end
   end in
   thread {NotGateAux Str} end %On crée le thread concurrent
end

fun {AndGate Xs Ys}
   fun {AndGateAux X Y} % Pareil mais pour And
      case X#Y % Permet de concatener et travailler avec les deux, c'est clean :)
      of (H1|Xs)#(H2|Ys) then
        H1*H2|{AndGateAux Xs Ys}
      else nil end
   end in
   thread {AndGateAux Xs Ys} end % Pareil pour le concurrent
end

fun {OrGate Xs Ys} %Pareil pour le Or
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
   fun {SimulateAux G I}
      case G.I
      of gate(...) then {Simulate G.I Ss} %On relance le simulate car on a pas encore d'input
      [] input(X) then Ss.X %On peut donner l'input aux portes logiques
      end
   end
in
   thread % On relance encore un thread
      case G of gate(value:V ...) then % Les ... servent à ne pas forcément spécifier le reste de gate, juste la value
        case V
        of 'not' then {NotGate {SimulateAux G 1}}
        [] 'and' then {AndGate {SimulateAux G 1} {SimulateAux G 2}}
        [] 'or' then {OrGate {SimulateAux G 1} {SimulateAux G 2}}
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