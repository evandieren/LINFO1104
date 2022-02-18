
% pour le 6:
% class SortedCollection from Collection

% exemples
declare
C = {NewCell 0}
C := @C + 1
{Browse @C}

class MyClass
   attr a1:'default' a2
   meth init(A2) a2 := A2 end
   meth doStuff(Arg1 key:Optional <= 'default')
      {Browse Arg1#Optional}
   end
   meth getA1($) @a1 end
   meth setA2(A2) a2 := A2 end
end
Obj = {New MyClass init(1)}
{Browse {Obj getA1($)}}
{Obj doStuff(0)}

% 1
fun{Reverse2 Xs}
   local C in
      C = {NewCell nil}
      for X in Xs do C := X|@C end
      @C
   end
end





% Ex2 : stack functions. (Correct)
declare
fun {NewStack} % pas besoin de tout ça, {NewCell nil} suffit
    local Cell in
        Cell = {NewCell nil}
        Cell
    end
end

declare
fun {IsEmpty S}
    case @S
        of nil then true
        else false
    end
end

declare
fun {Pop S}
    case @S
        of nil then nil
        [] H|T then S := T H
        else nil
    end
end

declare
proc {Push S X}
    S := X|@S
end



%%%% autre proposition (correct)%%%%%
declare

fun {NewStack}
  {NewCell nil}
end

proc {Push Stack Elem}
  Stack := Elem|@Stack
end

fun {Pop Stack}
  local A in
    A = @Stack.1
    Stack := @Stack.2
    A
  end
end
fun {IsEmpty Stack}
  @Stack == nil
end



%%% Eval %%%

fun {Eval Xs}
   S = {NewStack}
in
   for X in Xs do
      case X
      of '+' then
	      {Push S {Pop S} + {Pop S}}
      [] '-' then Op1 Op2 in
	      Op1 = {Pop S}
	      Op2 = {Pop S}
	      {Push S Op2 - Op1}
      [] '*' then
	      {Push S {Pop S} * {Pop S}}
      [] '/' then Op1 Op2 in
	      Op1 = {Pop S}
	      Op2 = {Pop S}
	      {Push S Op2 / Op1}
      [] N then
         {Push S N}
      end
   end
   {Pop S}
end

{Browse {Eval [13 45 '+' 89 17 '-' '*']}} % affiche 4176 = (13+45)*(89-17)
{Browse {Eval [13 45 '+' 89 '*' 17 '-']}} % affiche 5145 = ((13+45)*89)-17
{Browse {Eval [13 45 89 17 '-' '+' '*']}} % affiche 1521 = 13*(45+(89-17))


declare % je crois que c'est bon mais c'est un peu fort shift vers la droite je trouve xD
fun {Eval Expr} % Ret = ?
    local Stack in
        Stack = {NewStack}
        for Elem in Expr do
            case Elem
                of '+' then
                    local E1 E2 in
                        E1 = {Pop Stack}
                        E2 = {Pop Stack}
                        % if E1 == nil orelse E2 == nil then nil
                        % else {Push Stack E2+E1} end
                        {Push Stack E2+E1}
                    end
                [] '-' then
                    local E1 E2 in
                        E1 = {Pop Stack}
                        E2 = {Pop Stack}
                        % if E1 == nil orelse E2 == nil then nil
                        % else {Push Stack E2-E1} end
                        {Push Stack E2-E1}
                    end
                [] '*' then
                    local E1 E2 in
                        E1 = {Pop Stack}
                        E2 = {Pop Stack}
                        % if E1 == nil orelse E2 == nil then nil
                        % else {Push Stack E2*E1} end
                        {Push Stack E2*E1}
                    end
                [] '/' then
                    local E1 E2 in
                        E1 = {Pop Stack}
                        E2 = {Pop Stack}
                        % if E1 == nil orelse E2 == nil then nil
                        % else {Push Stack E2/E1} end
                        {Push Stack E2/E1}
                    end
                else {Push Stack Elem}
            end
        end
    	{Pop Stack}
    end
end



% 3
declare
fun {NewStack}
   S = {NewCell nil}
   fun {IsEmpty}
      @S == nil
   end
   proc {Push X}
      S := X|@S
   end
   proc {Pop ?R}
      if {IsEmpty} then R = nil
      else
	      R = @S.1
	      S := @S.2
      end
   end
in
   stack(isEmpty:IsEmpty push:Push pop:Pop)
end

% 4
%4
declare
fun {Shuffle Xs} Len A I Head Tail in
   Len = {Length Xs}
   I = {NewCell 0}
   A = {NewArray 0 Len 0}
   for X in Xs do
      A.@I := X
      I := @I+1
   end
   Tail = {NewCell Head}
   for N in 0..(Len-1) do Idx Range Next in
      Range = Len - 1 - N
      Idx = {OS.rand} mod (Range+1)
      @Tail = A.Idx|Next
      Tail := Next
      A.Idx := A.Range
   end
   @Tail = nil
   Head
end
{Browse {Shuffle [0 1 2 3 4 5 6 7 8]}}

% shuffle en declaratif ?
% => court et facile à comprendre mais moins efficace
declare
fun {Shuffle Xs} Tags Sorted in
   Tags = [{OS.rand}#X suchthat X in Xs]
   Sorted = {List.sort Tags fun{$ A#_ B#_} A<B end}
   [X suchthat _#X in Sorted]
end

