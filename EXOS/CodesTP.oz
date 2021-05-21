


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


% ARBRE

declare
fun {Insert K W T}
   case T
   of leaf then tree(key:K value:W left:leaf right:leaf)
   []tree(key:Y value:V left:T1 right:T2) andthen K==Y then
      tree(key:K value:W left:T1 right:T2)
   []tree(key:Y value:V left:T1 right:T2) andthen K<Y then
      tree(key:Y value:V left:{Insert K W T1} right:T2)
   []tree(key:Y value:V left:T1 right:T2) andthen K>Y then
      tree(key:Y value:V left:T1 right:{Insert K W T2})
   end
end

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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

declare
fun {Not X}
   1-X
end

fun {NotGate Str}
   fun {NotGateAux L} %Fonction annexe qui applique Not sur le stream donné en input
      case L
      of H|T then {Not H}|{NotGateAux T}
      else nil end
   end
   in
   thread {NotGateAux Str} end %On crée le thread concurrent
end

fun {AndGate Xs Ys}
   fun {AndGateAux X Y} % Pareil mais pour And
      case X#Y % Permet de concatener et travailler avec les deux, c'est clean :)
      of (H1|Xs)#(H2|Ys) then
        H1*H2|{AndGateAux Xs Ys}
      else nil end
   end 
   in
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


%%TP 11

%FACTORY DE PORT AVEC STATE
declare
fun {NewPortObject Behaviour Init}
   proc {MsgLoop S1 State}
      case S1 of Msg|S2 then {MsgLoop S2 {Behaviour Msg State}}
      [] nil then skip
      end
   end
   Sin in
   thread {MsgLoop Sin Init} end
   {NewPort Sin}
end

fun {Portier}
   
   fun {PortierAux Msg State}
      case Msg of getIn(N) then State+N
      [] getOut(N) then
   if State=<N then 0
   else
      State-N
   end
      [] getCount(N) then State
      end
   end
in
   {NewPortObject PortierAux 0}
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

declare

fun {NewStack}
   fun {StackMsg Msg Stack}
      case Msg
      of push(X) then X|Stack
      [] pop(S) then
   if Stack==nil then S=nil nil
   else
      S = Stack.1 Stack.2
   end
      [] isEmpty(B) then B = Stack==nil Stack
      end
   end
in
   {NewPortObjectState StackMsg nil}
end

declare S X in
S = {NewStack}
{Send S push(4)}
{Send S pop(X)}
{Browse X}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

declare
fun {NewPortObject MsgHandler InitState}
   S
   proc {MsgLoop S1 State}
      case S1 of Msg|S2 then {MsgLoop S2 {MsgHandler Msg State}}
      [] nil then skip
      end
   end
in
   thread {MsgLoop S InitState} end
   {NewPort S}
end


fun {NewQueue}
   fun {QueueAux S State}
      case S
      of enqueue(X) then {Append [X] State}
      [] dequeue(X) then
   case State
   of nil then X=nil nil
   [] H|T then X=H T
   end
      [] isempty(B) then B= State==nil State
      [] getElements(Q) then Q=State State
      end
   end
in
   {NewPortObject QueueAux nil}
end

declare Q X in
Q = {NewQueue}
{Send Q enqueue(4)}
{Browse X}
{Send Q dequeue(X)}




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%REDO
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ADT NORMAL (Bas gauche)

declare
proc {NewWrapper ?Wrap ?Unwrap}
    Key={NewName}
in
    fun {Wrap X}
        fun {$ K} if K==Key then X end end
    end
    fun {Unwrap W}
        {W Key}
    end
end

local Wrap Unwrap in
   {NewWrapper Wrap Unwrap}
   fun {NewStack} {Wrap nil} end
   fun {Push W X} {Wrap X|{Unwrap W}} end
   fun {Pop W X} S={Unwrap W} in X=S.1 {Wrap S.2} end
   fun {IsEmpty W} {Unwrap W}==nil end
end


declare
S = {NewStack}
S2 = {Push {Push S 2} 9}
local X Y in
   S3 = {Pop {Pop S2 Y} X}
   {Browse X} % Prints 2
end

% ADT Avec State (donc avec Cellules)

local Wrap Unwrap in
   {NewWrapper Wrap Unwrap}
   fun {NewStack} {Wrap {NewCell nil}} end
   proc {Push W X} C={Unwrap W} in C:=X|@C end
   fun {Pop W} C={Unwrap W} in
      case @C of X|T then C:=T X end
   end
   fun {IsEmpty W} @{Unwrap W}==nil end
in
   Stack=stack(new:NewStack push:Push pop:Pop isEmpty:IsEmpty)
end

% Object (avec Cells)

declare
fun {NewStack}
   %INIT
   C = {NewCell nil} %Création de la STACK
   proc {Push X} C := X|@C end
   proc {Pop X} S=@C in X=S.1 C:=S.2 end
   fun {IsEmpty} @C==nil end
in
   stack(push:Push pop:Pop isEmpty:IsEmpty) %Création du record final
end

X = {NewStack}
{Browse {X.isEmpty}}
{X.push 4}
{X.push 6}
{Browse {X.isEmpty}}
{Browse {X.pop}}
{Browse {X.pop}}

% Functionnal Object

declare
local

   fun {StackObjectFunc S}
      fun {Push E} {StackObjectFunc E|S} end
      fun {Pop S1} case S of X|T then S1={StackObjectFunc T} X end end
      fun {IsEmpty} S==nil end
   in
      stack(push:Push pop:Pop isEmpty:IsEmpty)
   end

in
   fun {NewStack}
      {StackObjectFunc nil}
   end
end

local E in
   A = {NewStack}
   {Browse {A.isEmpty}}
   B = {A.push 4}
   C = {B.push 6}
   D = {C.pop E}
   {Browse D}
end



%CONCURRENCY - DETERMINISTIC DATAFLOW

%TEST de threads avec feed region

declare
proc {Disp S}
   case S of X|S2 then {Browse X} {Disp S2} end
end

declare S in
thread {Disp S} end %Waits until S in bounded

declare S2 in
S = a|b|c|S2

declare S3 in
S2 = d|e|f|S3

S3 = s|t|u|_

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Producer consumer
declare
proc {Disp S}
   case S of X|S2 then {Browse X} {Disp S2} end
end
fun {Prod N} {Delay 1000} N|{Prod N+1} end
declare S
thread S = {Prod 1} end % Crée le producer
thread {Disp S} end % On crée le consumer qui va récup le thread et print ce qu'il y a dedans en attendant la fin du thread

%pipeline

fun {Trans S}
  case S of X|S2 then X*X|{Trans S2} end
end

declare S1 S2
thread S1 = {Prod 1} end
thread S2 = {Trans S1} end
thread {Disp S2} end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

declare
fun {ProduceInts N}
   fun {ProdAux A}
      if A>N then nil
      else
   A|{ProdAux A+1}
      end
   end
in
   {ProdAux 1}
end      

fun {Sum Stream}
   case Stream of X|S then X+{Sum S}
   [] nil then 0
   end
end

declare Xs S
Xs = {ProduceInts 666}
S = {Sum Xs}
{Browse S}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

declare
fun {Producer N}
   fun {ProdAux A}
      if A>N then nil
      else
   A|{ProdAux A+1}
      end
   end
in
   {ProdAux 1}
end

fun {Filter Str}
   case Str of X|S then
      if  ((X mod 2)==0) then X|{Filter S}
      else
   {Filter S}
      end
   [] nil then nil
   end
end

fun {Consumer Str}
   case Str of X|S then X+{Consumer S}
   [] nil then 0
   end
end

declare S1 S2 S3
thread S1 = {Producer 500} end
thread S2 = {Filter S1} end
thread S3 = {Consumer S2} end

{Browse S1}
{Browse S2}
{Browse S3}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Petit Consumer des familles

declare
fun {Counter Str}
   fun {CounterAux Str L}
      case Str of nil then nil
      [] H|T then
   local NewList in
      NewList = {Add H L}
      NewList|{CounterAux T NewList}
   end
      end
   end
   fun {Add X L}
      case L of A#B|T then
   if A==X then A#(B+1)|T
   else
      A#B|{Add X T}
   end
      else
      X#1|nil
      end
   end
in
   thread {CounterAux Str nil} end
end

local InS in
   {Browse {Counter InS}}
   InS=a|b|a|c|_
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%proc {ForCollect Xs P ?Ys} % Ys = var non liée de retour
%   Acc = {NewCell Ys}
%   proc {C X} R2 in @Acc=X|R2 Acc:=R2 end %On remplit la mémoire de Ys avec X|R2 et on remet la cellule sur R2
%in
%   for X in Xs do {P C X} end @Acc= nil % Une fois fini, on pose nil sur la fin de Ys.
%end

%{Browse {ForCollect [0 2 4 6 8] proc {$ Collect X} {Collect X div 2} end}}

declare
proc {ForCollect Xs P Ys}
   Ys = nil
   proc {C X} X|Ys end
in
   for X in Xs do {P C X} end% Une fois fini, on pose nil sur la fin de Ys.
   {Browse done}
end

{Browse {ForCollect [0 2 4 6 8] proc {$ Collect X} {Collect (X div 2)} end}}







%%%%%%%%%%%%%%%%
%PORTS
%%%%%%%%%%%%%%%%


% Port Normal (pas de State)
declare

fun {NewPortObject P} % Créateur de ports avec une boucle et un thread.
   S
   proc {Loop Stream}
      case Stream of Msg|T then {P Msg} {Loop T}
      [] nil then skip end
   end
in
   thread {Loop S} end
   {NewPort S}
end

proc {Calculator Msg} % Gère juste un cas, un message. C'est le port qui s'occupe du stream !
   case Msg of add(X Y ?R) then R=X+Y
   [] pow(X Y ?R) then R={Pow X Y}
   [] 'div'(X Y ?R) then
      if Y == 0 then skip
      else R= X div Y end
   else
      {Browse 'je ne comprends pas ton message'}
   end
end

fun {LaunchServer}
   {NewPortObject Calculator}
end


declare A B N S Res1 Res2 Res3 Res4 Res5 Res6

S = {LaunchServer}
{Send S add(321 345 Res1)}
{Browse Res1}
{Send S pow(2 N Res2)}
N = 8
{Browse Res2}
{Send S add(A B Res3)}
{Send S add(10 20 Res4)}
{Send S foo}
{Browse Res4}
A = 3
B = 0-A
{Send S'div'(90 Res3 Res5)}
{Send S'div'(90 Res4 Res6)}
{Browse Res3}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fun {NewPortObjectState P InitState}
   S
   proc {Loop Stream State}
      case Stream of Msg|T then {Loop T {P Msg State}}
      [] nil then skip end
   end
in
   thread {Loop S InitState} end
   {NewPort S}
end

fun {StudentRMI} % Chaque StudentRMI est un Port et Charlotte va demander au Port le nombre de bières bues
   S in
   thread for ask(howmany:Beers) in S do Beers={OS.rand} mod 24 end end
   {NewPort S}
end

fun {StudentCallBack} % Charlotte est un port et va recevoir les envois des students (qui donneront un nombre de bieres)
   S in
   thread
      for ask(howmany:P) in S do {Send P {OS.rand} mod 24} end
   end
   {NewPort S}
end

fun {CreateUniversity Size} % Ici on va créer les students
   fun {CreateLoop I}
      if I =< Size then
     {StudentRMI} | {CreateLoop I+1}
      else nil end
   end
in
   {CreateLoop 1}
end


fun {Charlotte Universite}
   fun {CharlotteAux Universite State}
      case Universite of Student|T then Beers in
     {Send Student ask(howmany:Beers)}
     {CharlotteAux T info(stud:State.stud + 1
                  beers: State.beers + Beers
                  min: if State.min == 0-1 then Beers
                   elseif State.min > Beers then Beers
                   else State.min end
                  max: if State.max < Beers then Beers
                   else State.max end
                 )}
      [] nil then State
      end
   end
in
   {CharlotteAux Universite info(stud:0 beers:0 min: 0-1 max: 0-1)}
end
Students = {CreateUniversity 10}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

declare
fun {NewPortObject Behaviour InitialState}
   S
   proc {MsgLoop S1 State}
      case S1 of Msg|T then {MsgLoop T {Behaviour Msg State}}
      else
    skip
      end
   end
in
   thread {MsgLoop S InitialState} end
   {NewPort S}
end

fun {Counter Output}
   P = {NewPort Output}
   
   fun {CounterAux S State}
      case S of nil then State
      [] H|T then
    local NewList in
       NewList = {Add H State}
       {Send P NewList}
       NewList|{CounterAux T NewList}
    end
      end
   end
   
   fun {Add X L}
      case L of A#B|T then
   if A==X then A#(B+1)|T
   else
      A#B|{Add X T}
   end
      else
      X#1|nil
      end
   end
in
   {NewPortObject CounterAux nil}
end

declare S P={Counter S}

{Send P [a a c a d]}
{Browse S}