
%1
% Definition:
sigma = (browse=(...), p=(proc... end, Ep), z=1)
    avec Ep = {Z->z} % (on se limite à ce qui est utilisé dans P)

% Avant l'appel
([
    ({P A B}, {P->p, Browse->browse, B->b, A->a}),
    ({Browse B}}, {P->p, Browse->browse, B->b, A->a})
], (browse=(...), p=(proc ... end, Ep), z=1, a=10, b))
%
% Pendant l'appel
([
    (Y=X+Z, Ep U {X->a, Y->b}),
    ({Browse B}}, {P->p, Browse->browse, B->b, A->a})
], (browse=(...), p=(proc ... end, Ep), z=1, a=10, b))
%
% Apres l'appel
([
    ({Browse B}}, {P->p, Browse->browse, B->b, A->a})
], (browse=(...), p=(proc ... end, Ep), z=1, a=10, b=11))

%% Ex 7

declare
local Y LB in   % E0 = {Y->y, LB->lb, Browse->browse}
    Y=10
    proc {LB X ?Z}      % E1 = E0 U {X->x, Z->z}
        local Equal1 in     % E2 = E1 U {Equal1->equal1}
            Equal1 = (X >= Y)
            if Equal1 then Z = X
            else Z = Y end
        end
    end
    local Y Z Five in   % E3 = {LB->lb, Y->y2, Z->z2, Five->five, Browse->browse}
        Y = 15
        Five = 5
        {LB Five Z}
        {Browse Z}  % --> 10
    end
end

% machine abstraite:

(
   [
      ( local Y LB in ... end, {{Browse->browse}} )
   ],
   ({browse=(...)})
),
(
   [
      ( Y=10, {Browse->browse, Y->y1, LB->lb} ),
      ( Lb = proc {$ X Z} ... end, {Browse->browse, Y->y1, LB->lb} ),
      ( local Y Z Five in ... end, {Browse->browse, Y->y1, LB->lb} )
   ],
   ({browse=(...), y1, lb})
),
(
   [
      ( Lb = proc {$ X Z} ... end, {Browse->browse, Y->y1, LB->lb} ),
      ( local Y Z Five in ... end, {Browse->browse, Y->y1, LB->lb} )
   ],
   ({browse=(...), y1=10, lb})
),
(
   [
      ( local Y Z Five in ... end, {Browse->browse, Y->y1, LB->lb} )
   ],
   ({browse=(...), y1=10, lb=(proc{$ X Z}...end, {Y->y1})})
),
(
   [
      ( Y=15, {Y->y4, Z->z, Five->five, LB->lb, Browse->browse} ),
      ( Five=5, {Y->y4, Z->z, Five->five, LB->lb, Browse->browse} ),
      ( {LB Five Z}, {Y->y4, Z->z, Five->five, LB->lb, Browse->browse} ),
      ( {Browse Z}, {Y->y4, Z->z, Five->five, LB->lb, Browse->browse} ),
   ],
   ({browse=(...), y1=10, lb=(proc{$ X Z}...end, {Y->y1}), y4, z, five})
),
(
   [
      ( Five=5, {Y->y4, Z->z, Five->five, LB->lb, Browse->browse} ),
      ( {LB Five Z}, {Y->y4, Z->z, Five->five, LB->lb, Browse->browse} ),
      ( {Browse Z}, {Y->y4, Z->z, Five->five, LB->lb, Browse->browse} ),
   ],
   ({browse=(...), y1=10, lb=(proc{$ X Z}...end, {Y->y1}), y4=15, z, five})
),
(
   [
      ( {LB Five Z}, {Y->y4, Z->z, Five->five, LB->lb, Browse->browse} ),
      ( {Browse Z}, {Y->y4, Z->z, Five->five, LB->lb, Browse->browse} ),
   ],
   ({browse=(...), y1=10, lb=(proc{$ X Z}...end, {Y->y1}), y4=15, z, five=5})
),

... Suite:

(
   [
      ( local B in ... end, {X->five, Z->z, Y->y1} ),
      ( {Browse Z}, {Y->y4, Z->z, Five->five, LB->lb, Browse->browse} ),
   ],
   ({browse=(...), y1=10, lb=(proc{$ X Z}...end, {Y->y1}), y4=15, z, five=5})
),
(
   [
      ( B = X >= Y, {B->b, X->five, Z->z, Y->y1} ),
      ( if B then...end, {B->b, X->five, Z->z, Y->y1} ),
      ( {Browse Z}, {Y->y4, Z->z, Five->five, LB->lb, Browse->browse} ),
   ],
   ({browse=(...), y1=10, lb=(proc{$ X Z}...end, {Y->y1}), y4=15, z, five=5, b})
),
(
   [
      ( if B then...end, {B->b, X->five, Z->z, Y->y1} ),
      ( {Browse Z}, {Y->y4, Z->z, Five->five, LB->lb, Browse->browse} ),
   ],
   ({browse=(...), y1=10, lb=(proc{$ X Z}...end, {Y->y1}), y4=15, z, five=5, b=false})
),
(
   [
      ( Y=Z, {B->b, X->five, Z->z, Y->y1} ),
      ( {Browse Z}, {Y->y4, Z->z, Five->five, LB->lb, Browse->browse} ),
   ],
   ({browse=(...), y1=10, lb=(proc{$ X Z}...end, {Y->y1}), y4=15, z, five=5, b=false})
),
(
   [
      ( {Browse Z}, {Y->y4, Z->z, Five->five, LB->lb, Browse->browse} ),
   ],
   ({browse=(...), y1=10, lb=(proc{$ X Z}...end, {Y->y1}), y4=15, z=10, five=5, b=false})
),
(
   [
   ],
   ({browse=(...), y1=10, lb=(proc{$ X Z}...end, {Y->y1}), y4=15, z=10, five=5, b=false})
)

% Ex 2
% proposition de solution (sans isprime)
declare
fun {MakeFilter N} % c'est compliqué mais je suppose que ça fonctionne
  fun {$ I}
    if I==1 andthen I mod N ==0 then
      true
    elseif {Min (I mod N) (N mod I)} ==0 andthen ((I==1)==false)  then
      true
    else
      false
    end
  end
end

fun {FilterAux L F}
  if L==nil then
    nil
elseif {F L.1} then
    L.1|{FilterAux L.2 F}
  else
    {FilterAux L.2 F}
  end
end
fun {Filter L F}
  {FilterAux L F}
end

F1 = {MakeFilter 2}
F2 = {MakeFilter 3}
{Show {Filter [1 2 3 4 5 6 7 8] F1}}
{Show {Filter [1 2 3 4 5 6 7 8] F2}}

%
%2.1
declare
fun {MakeMulFilter N}
   fun {$ I}
      (I mod N) == 0
   end
end

F2 = {MakeMulFilter 2}
{Browse {F2 4}}

%2.2
declare
fun {Filter L F}
   case L of H|T then
      if {F H} then H|{Filter T F}
      else {Filter T F} end
   [] nil then nil end
end

%2.3
{Browse {Filter [0 1 2 3 4 5 6] {MakeMulFilter 2}}}

%2.4
{Browse {Filter [0 1 3 5 6 9 10] {MakeMulFilter 3}}}

%2.5
declare
fun {IsPrime N}
   fun {IsPrimeRec N K}
      if K =< 1 then true
      elseif (N mod K) == 0 then false
      else {IsPrimeRec N K-1} end
   end
in
   if N < 2 then false
   else {IsPrimeRec N N-1} end
end
fun {Seq From To}
   if From == To then nil
   else From|{Seq From+1 To} end
end
{Browse {Filter {Seq 0 100} IsPrime}}


% 3
declare
L = [1 2 3]
{Browse {FoldL L fun {$ X Y} X*Y end 1}}
{Browse {FoldL L fun {$ X Y} X-Y end 2*L.1}}

%4
declare
{Browse {Map [1 2 3] fun{$ X} {Pow X 2} end}}


%5
declare
fun {Convertir T V O} T*V+O end
fun {MakeConverter R O}
   fun {$ V} {Convertir R V O} end
end
FahrenheitToCelsisus = {MakeConverter 0.56 ~17.78}
{Browse {FahrenheitToCelsisus 50.0}}

