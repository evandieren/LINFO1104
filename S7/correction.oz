1)
λx.xyz valide
λx.λy invalide car pas de corps
m valide
xλwy.y valide
xλ invalide car pas d'argument
λλxz.zx invalide car deux λ de suite
(mnop)(qrst)vwλxyz.zxy valide

2)
λx.λy.x
 |    |

λx.λx.x
    | |

λx.xλy.x
 | |   |

λx.xλx.x
 | | ^ ^

λz.xλy.x

λz.xλx.x
     | |


3)
λa.λb.abb == λb.λa.baa
λa.λb.λa.bb /= λi.λj.jji
λx.xλy.x /= λe.eλf.f
λx.xλy.x == λe.eλf.e


4)
(λx.xx)y
yy

(λx.axxa)y
ayya

(λx.(λz.zx)q)y
(λx.qx)y
qy

(λx.x((λz.zx)(λx.bx)))y
(λx.x((λx.bx)x))y
(λx.x (bx))y % <--------- /!\ oui il y a bien des () ici
y(by)

(λm.m)(λn.n)(λc.cc)(λd.d)
(λn.n)(λc.cc)(λd.d)
(λc.cc)(λd.d)
(λd.d)(λd.d)
λd.d

λz.xλx.x (normale)

5)
λx.((λy.y)x)
λy.y

λx.(λy.(λz.p)y)x
λy.(λz.p)y
λz.p

λx.(λy.(λz.z))x
λy.(λz.z)

λx.(λy.yx)p (normale)

(λf.fx)(λy.gy)
(λf.fx)g


6)
(λx.λy.x) ((λx.x)y)
ordre normal:
λy.((λx.x)y)
λy.y
ordre applicatif:
(λx.λy.x)y
λy.y

((λx.λy.xy) (λz.z) )(λw.w)
ordre normal:
(λy.(λz.z)y)(λw.w)
(λz.z)(λw.w)
λw.w
ordre applicatif:
(λx.λy.xy)((λz.z)(λw.w))
(λx.λy.xy)(λw.w)
λy.((λw.w)y)
λy.y % alpha eq à λw.w


