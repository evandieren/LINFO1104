local P in %E0 = {P->p0}
  local Z in %E1 = {Z->z0} U E0
    Z=1
  proc {P X Y} Y=X+Z end %E3={X->x0, Y-y0} U E1
  end
local B A in %E4 = {B->b0,A->a0}
  A=10
  {P A B}
  {Browse B}
  end
end

/*

La procédure P est définie avec 2 arguments X Y, X est fixé à l'appel Y est une variable qui contiendra le resultat.
Z est défini dans l'environnement de P.

Quand on appelle P depuis le 2e bloque, on défini une variable d'environnement A (10),
et on appelle P (défini précedemment dans l'autre environnement) avec la variable B qui contiendra la réponse.

ce qui nous donne B = A + Z (A B étant les arguments et Z la variable contextuelle autours de la définissions de P))


*/
