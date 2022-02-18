6)

(λx.λy.x) ((λx.x)y)
ordre normal:
λy.((λx.x)y)
λy.y
ordre applicatif:
(λx.λy.x)y
λy.y1

((λx.λy.xy) (λz.z) )(λw.w)
ordre normal:
(λy.(λz.z)y)(λw.w)
(λz.z)(λw.w)
λw.w
ordre applicatif:
(λx.λy.xy) ((λz.z)(λw.w))
(λx.λy.xy)(λw.w)
λy.((λw.w)y)
λy.y


7)

NOT := λb.b FALSE TRUE
b = FALSE: FALSE FALSE TRUE = TRUE
b = TRUE: TRUE FALSE TRUE = FALSE

OR := λab.aab
a = FALSE, B: FALSE FALSE B = B
a = TRUE, B: TRUE TRUE B = TRUE

OR TRUE FALSE
TRUE TRUE FALSE
TRUE

8)
SUCC := λn.(λfx.f(nfx))
PLUS := λmn.(λfx.mf(nfx))

PLUS 1 2
λfx.1 f (2 fx)
λfx.1 f (λfx.f(fx) fx)
λfx.1 f (f(fx))
λfx.(λfx.fx) f (f(fx))
λfx.f(f(fx))
3


9)
PAIR := λab.(λf.fab)

FIRST := λp.(p λab.a)
SECOND := λp.(p λab.b)
SECOND λf.fab = (λf.fab) FALSE = FALSE a b = b

p := PAIR 4 2
	= λf.(f 4 2)
FIRST p
	= p λab.a
	= λab.(a) 4 2
	= 4
SECOND p
	= p λab.b
	= λab.(b) 4 2
	= 2

LIST = PAIR
exemple d'une liste: [1 2]
l := λf.(f 1 λf.(f 2 NIL))

10) (pas fait pendant le tp, si vous voulez essayer vous pouvez demander au tuteur de vous corriger)

11)
a)
(λxλyλu.y)((λz.((λx.z)λz.v))z)
ordre normal:
λyλu.y
ordre applicatif:
(λxλyλu.y)((λz.z)z)
(λxλyλu.y)z
(λxλyλu.y)z
λyλu.y

b)
((λvλu(vv))λz.x)v
ordre normal et applicatif:
(λu(λz.x)(λz.x))v

------------------------------------------------------------------------------------------------------
TP S8
------------------------------------------------------------------------------------------------------

1)


