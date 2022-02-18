declare

fun {TakeAux A N}
  if N==0 then
   nil
  else
    A.1|{TakeAux A.2 N-1}
  end
end

fun {Take A N}
  {TakeAux A N}
end

{Browse {Take [a b c d] 2}}

fun {DropAux A N}
  if N>0 then
    if A.2==nil then nil else {DropAux A.2 N-1} end
  else
    A
  end

end
fun {Drop A N}
  {DropAux A N}
end
{Browse {Drop [r a p h] 1}}
