declare
class Collection
   attr elements
   meth init
      elements := nil
   end
   meth put(X)
      elements := X|@elements
   end
   meth get($)
      case @elements of X|Xr then elements := Xr X end
   end
   meth isEmpty($)
      @elements == nil
   end
   meth union(C)
      if {Not {C isEmpty($)}} then
        {self put({C get($)})}
        {self union(C)}
      end
   end
   meth toList($)
      @elements
   end
end

declare
class SortedCollection from Collection
   meth put(X)
      fun {PutAux L}
        case L of nil then X|nil
        [] H|T then
           if X =< H then X|L
           else H|{PutAux T} end
        end
      end in
      elements := {PutAux @elements}
   end
end

declare % tests
C1 = {New Collection init}
C2 = {New SortedCollection init}

{C1 put(0)}
{C1 put(1)}
{C2 put(2)}
{C2 put(1)}
{C2 put(3)}

{C1 union(C2)}
{Browse {C2 isEmpty($)}}
{Browse {C1 isEmpty($)}}
{Browse {C1 get($)}}

% if C1, C2 are Collections, union is O(|C2|)
% because put is O(1)

% if C1, C2 are SortedCollections,
% union is O(|C2|^2 + |C1|*|C2|)

% proof:
% (n1 + (n1+1) + (n1+2) + ... + (n1+n2-1))
% = n2*n1 + (0+1+2+...+n2-1)
% ~= n2*n1 + (0+1+2+...+n2)
% = n2*n1 + 0.5*n2*(n2+1)
% ~= n2*n1 + 0.5*n2*n2
% => O(n2^2 + n2*n1)

declare
Xs = [7 8 0 4 3]
C3 = {New SortedCollection init}
for X in Xs do
   {C3 put(X)}
end
{Browse {C3 toList($)}}
% insertion sort O(n^2)


% 1
declare A B C D
thread D = C+1 end
thread C = B+1 end
thread A = 1 end
thread B = A+1 end
{Browse D}

% threads are created in the order they are written
% they terminate their exectution in this order : A, B, C, D
% E = {D->d, C->c, B->b, A->a, Browse->browse}
% s = {a, b, c, d, browse = ...}
% ({[({Browse D}), E], [(D=C+1), E], [(C=B+1), E], [(A=1), E], [(B=A+1), E]}, s)
% on ne peut executer que le Browse D ou A=1


% 2
local X Y Z in
   thread if X==1 then Y=2 else Z=2 end end
   thread if Y==1 then X=1 else Z=2 end end
   X=1
   {Browse X} % 1
   {Browse Y} % 2
   {Browse Z} % 2
end
% ({}, {x=1, y=2, z=2})

local X Y Z in
   thread if X==1 then Y=2 else Z=2 end end
   thread if Y==1 then X=1 else Z=2 end end
   X=2
   {Browse X} % 2
   {Browse Z} % 2
   {Browse Y} % _
end
% ({[(if Y==1 then X=1 else Z=2 end), E]}, {x=2, y, z=2})


% 3

declare
fun {ProduceInts N} % 1 [s] per call
   fun {ProduceIntsAux N C}
      if N == C then C|nil
      else C|{ProduceIntsAux N C+1} end
   end in
   {ProduceIntsAux N 1}
end
fun {Sum Str} % 1 [s] per call
   case Str of H|T then H+{Sum T} else 0 end
end


declare Xs S
thread Xs = {ProduceInts 666} end
thread S = {Sum Xs} end
{Browse S} % print after 666 [s]

declare Xs S
Xs = {ProduceInts 666}
S = {Sum Xs}
{Browse S} % print after 2*666 [s]


% 4.1
declare
fun {FilterOdd L}
   case L
   of H|T then
      if H mod 2 == 0 then H|{FilterOdd T}
      else {FilterOdd T} end
   else nil end
end
local S1 S2 in
   thread S1 = {ProduceInts 10} end
   thread S2 = {FilterOdd S1} end
   {Browse S2}
end

% 4.2
declare
fun {ServeBeer}
   case {OS.rand} mod 2
   of 0 then beer
   else trappist end
end
fun {Barman N}
   {Delay 3000}
   {ServeBeer}|
   if N == 1 then nil
   else {Barman N-1} end
end
fun {SmellTrappist Beer}
   Beer == trappist
end
fun {Charlotte L}
   case L of H|T then
      if {SmellTrappist H} then {Charlotte T}
      else H|{Charlotte T} end
   else nil end
end
fun {Friend L}
   case L of H|T then 1|{Friend T}
   else nil end
end
local B C F T in
   thread B = {Barman 3} end
   thread C = {Charlotte B} end
   thread F = {Friend C} end
   T = {Sum F}
   {Browse "Charlotte drank " # 3-T # " beers"}
   {Browse "The friend drank " # T # " beers"}
end


% 5



