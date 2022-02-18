declare

fun {MultListAux L A}
  if L == nil then A else {MultListAux L.2 A*L.1} end
end
fun {MultList L}
  {MultListAux L 1}
end

{Browse {MultList [1 2 3 4]}}
