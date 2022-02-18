declare
fun {MakeFilter N}
  fun {$ I}
    if I==1 andthen I mod N ==0 then
      I
    elseif {Min (I mod N) (N mod I)} ==0 andthen ((I==1)==false) then
      I
    else
      I-1
    end
  end
end

fun {FilterAux L F}
  if L==nil then
    nil
  elseif {F L.1} == L.1 then
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
