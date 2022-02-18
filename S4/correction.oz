
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Seance 3
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 3.1.1
declare Sum in
proc{Sum N ?R}
   local B One in
      One = 1
      B = (N == One)
      if B then
	 R = 1
      else
	 local R1 N1 One Square in
	    One = 1
	    N1 = N - One
	    {Sum N1 R1}
	    Square = N * N
	    R = Square + R1
	 end
      end
   end
end

% 3.1.2
local SumAux Sum in
   proc {SumAux N Acc ?R}
      local One B in
         One = 1
         B = (N == One)
         if B then
            local One in
               One = 1
               R = Acc + One
            end
         else
         local N_1 One NxN A S2 in
            One = 1
            N_1 = N - One
            NxN = N * N
            A = NxN + Acc
            {SumAux N_1 A R}
         end
      end
   end
   proc {Sum N ?R}
      local Zero in
         Zero = 0
         {SumAux N Zero R}
      end
   end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Seance 2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%
%% ex.2 %%
%%%%%%%%%%%exe

% non-tail recursive
declare
fun {Length L}
    if L == nil then 0
    else 1 + {Length L.2} end
end
{Browse {Length [1 2 3 4]}}

% tail recursive
declare
fun {BetterLength L Acc}
    if L == nil then Acc
    else {BetterLength L.2 (Acc + 1)} end
end
{Browse {BetterLength [1 2 3 4] 0}}
% Invariant Acc + len(L) = len(L_original)

%%%%%%%%%%
%% ex.3 %%
%%%%%%%%%%

declare
fun {Append L1 L2}
    if L1 == nil then L2
    else
      L1.1 | {Append L1.2 L2} end
end
{Browse {Append [1 2] [3 4]}}


%%%%%%%%%%
%% ex.4 %%
%%%%%%%%%%

declare
fun{Vide L}
   case L
   of nil then empty
   [] H|T then nonEmpty
   else
      other
   end
end
% Head
declare
fun {Head L}
    case L
    of nil then nil
    [] H|_ then H
    end
end

fun {Head H|_} H end

% Tail
declare
fun {Tail L}
    case L
    of nil then nil
    [] _|T then T
    end
end

fun {Tail _|T} T end

% Length
declare
fun {Length2 L N}
    case L of _|T then {Length2 T N+1}
    [] nil then N
    end
end
fun {Length L}
    {Length2 L 0}
end

fun {Append L1 L2}
    case L1 of nil then L2
    [] H|T then H|{Append T L2} end
end


%%%%%%%%%%
%% ex.5 %%
%%%%%%%%%%

declare
fun {Take L N}
    if L == nil then nil
    elseif N == 0 then nil
    else L.1|{Take L.2 N-1} end
end

{Browse {Take [r a p h] 2}}
{Browse {Take [r a p h] 7}}
{Browse {Take [r [a p] h] 2}}

fun {Drop L N}
    if L == nil then nil
    elseif N == 0 then L
    else {Drop L.2 N-1} end
end


%%%%%%%%%%
%% ex.6 %%
%%%%%%%%%%

declare
fun {MultListAux L Acc}
   if L == nil then Acc
   else {MultListAux L.2 Acc*L.1} end
end
fun {MultList L}
   {MultListAux L 1}
end

  % Version pattern matching
declare
fun {MultList2 L Acc}
    case L
    of nil then Acc
    [] H|T then {MultList2 T Acc*H}
    end
end
fun {MultList L}
    {MultList2 L 1}
end



declare
fun {MultList L}
  case L of nil then liste_vide
  [] End|nil then End
  [] Head|Tail then Head * {MultList Tail} end
end


%%%%%%%%%%%
%% ex.10 %%
%%%%%%%%%%%


declare
fun {Promenade Tree} % Peut on eviter append ?
    case Tree
    of btree(V left:L right:R) then
        V|{List.append {Promenade L} {Promenade R}}
    [] empty then nil end
end

declare
fun {Promenade Tree}
    fun {P Tree Acc}
        case Tree
        of btree(V left:L right:R) then AccR in
            AccR = {P R Acc}
            V|{P L AccR}
        [] empty then Acc end
    end
in
    {P Tree nil}
end

declare
fun {Promenade Tree} % une approche equivalante
    proc {P Tree Start End}
        case Tree
        of btree(V left:L right:R) then
            local StartL EndL in
                Start = V|StartL
                {P L StartL EndL}
                {P R EndL End}
            end
        [] empty then Start = End end
    end
in
    {P Tree $ nil}
end

declare
Tree = btree(42
    left: btree(26
        left: btree(54
            left: empty
            right: btree(18
                left: empty
                right: empty))
        right: empty)
    right: btree(37
        left: btree(11
            left: empty
            right: empty)
        right: empty))
TtoL = {Promenade Tree}
{Browse TtoL}

{Browse {List.foldL TtoL fun {$ X Y} X+Y end 0}} % comme une corde à rouler

fun {SumTree Tree}
   case Tree
   of btree(T left:L right:R) then
      T + {SumTree L} + {SumTree R}
   [] empty then 0 end
end
{Browse {SumTree Tree}}


