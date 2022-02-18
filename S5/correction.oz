
declare
fun {Prefix L1 L2}
    case L1#L2
    of nil#_ then true
    [] (H|T1)#(H|T2) then {Prefix T1 T2}
    else false end
end
fun {FindString S1 S2}
    fun {FS S L P}
        case L
        of _|T then
            if {Prefix S L} then P|{FS S T P+1}
            else {FS S T P+1} end
        [] nil then nil end
    end
in
    {FS S1 S2 1}
end
S = "ababab"
{Browse {FindString "abab" S}}
{Browse {FindString "a" S}}
{Browse {FindString "c" S}}

%% correction ex 2
declare
T1 = '|'(1:1 2:nil)
T2 = '|'(1:1 2:'|'(1:2 2:'|'(1:3 2:nil)))
T3 = nil
T4 = state(1:4 2:f 3:3)

%% correction ex 3

%3.1
proc {Q A} % E0 = {Q->q0, A->a0, P->p0}
   local One Ap1 in % E1 = {One->one1, Ap1->ap1} U E0
      One = 1
      Ap1 = A + One
      {P Ap1}
   end
end

%3.2
proc {P} % E0 = {P->p0, A->a0, Browse->browse}
   {Browse A}
end

%3.3
local P Q in % E0 = {P->p0, Q->q0}
   proc {P A R} % E1 = {A->a1, R->r1} U E0
      local Two in % E2 = {Two->two2} U E1
   Two = 2
   R = A + Two
      end
   end
   local P R in % E3 = {P->p3, R->r3, Q->q0}
      proc {Q A ?Ret} % E4 = {A->a4, Ret->ret4} U E3
   {P A R}
   Ret = R
      end
      proc {P A R} % E5 = {A->a5, R->r5, P->p3, Q->q0}
   local Two in % E6 = {Two->two6} U E5
      Two = 2
      R = A-Two
   end
      end
   end
   {Browse {Q 4}} % 2
end

%4.1
%...
((
  ( (Arg1=7), {Browse->browse, Res->res, Arg1->arg1, Arg2->arg2} ),
  ( (Arg2=6), {Browse->browse, Res->res, Arg1->arg1, Arg2->arg2} ),
  ( (Res=Arg1*Arg2), {Browse->browse, Res->res, Arg1->arg1, Arg2->arg2} ),
  ( ({Browse Res}), {Browse->browse, Res->res} )
 ), {browse=proc ... end, res, arg1, arg2})
%
((
  ( (Arg2=6), {Browse->browse, Res->res, Arg1->arg1, Arg2->arg2} ),
  ( (Res=Arg1*Arg2), {Browse->browse, Res->res, Arg1->arg1, Arg2->arg2} ),
  ( ({Browse Res}), {Browse->browse, Res->res} )
 ), {browse=proc ... end, res, arg1=7, arg2})
%
((
  ( (Res=Arg1*Arg2), {Browse->browse, Res->res, Arg1->arg1, Arg2->arg2} ),
  ( ({Browse Res}), {Browse->browse, Res->res} )
 ), {browse=proc ... end, res, arg1=7, arg2=6})
%
((
  ( ({Browse Res}), {Browse->browse, Res->res} )
 ), {browse=proc ... end, res=42, arg1=7, arg2=6})
%
((
  ()
 ), {browse=proc ... end, res=42, arg1=7, arg2=6})
% end

%4.2
((
 ( (local Res in ... end), {Browse->browse} )
 ), {browse=proc ... end})
%
((
 ( (local Arg1 Arg2 in ... end), {Browse->browse, Res->res} ),
 ( ({Browse Res}), {Browse->browse, Res->res} )
 ), {browse=proc ... end, res})
%
((
  ( (Arg1 = 7), {Browse->browse, Res->res, Arg1->arg1, Arg2->arg2} ),
  ( (Res = Arg1*Arg2), {Browse->browse, Res->res, Arg1->arg1, Arg2->arg2} ),
  ( (Arg2 = 6), {Browse->browse, Res->res, Arg1->arg1, Arg2->arg2} ),
  ( ({Browse Res}), {Browse->browse, Res->res} )
 ), {browse=proc ... end, res, arg1, arg2})
%
% on ne peut pas calculer Res car arg2 en mémoire n'a pas encore de val !
((
  ( (Res = Arg1*Arg2), {Browse->browse, Res->res, Arg1->arg1, Arg2->arg2} ),
  ( (Arg2 = 6), {Browse->browse, Res->res, Arg1->arg1, Arg2->arg2} ),
  ( ({Browse Res}), {Browse->browse, Res->res} )
 ), {browse=proc ... end, res, arg1=7, arg2})


%5
local MakeAdd Add1 Add2 in
   proc {MakeAdd X Add} % Add is the result and is a proc
      proc {Add Y Z}  % E = {X->x, ...}
   Z=X+Y
      end
   end
   {MakeAdd 1 Add1} % Add1 is thus a proc and X->x1, x1 = 1
   {MakeAdd 2 Add2} % Add2 is thus a proc and X->x2, x2 = 2
   local V in
      {Add1 42 V}
      {Browse V}
   end
   local V in
      {Add2 42 V}
      {Browse V}
   end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Devoir pour la semaine prochaine: TP4 ex 1 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

