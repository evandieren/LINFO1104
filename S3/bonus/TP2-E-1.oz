declare

fun {FlattenAux A}
  if A.2==nil then

  else
    A.1|{FlattenAux A.2}
  end
end

fun {Flatten A}

  {FlattenAux A}
end

{Browse {Flatten [a [b [c d]] e [[[f]]]]}}
