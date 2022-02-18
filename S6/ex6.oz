declare



fun {GenerateList N}
  local GenAux in
    fun {GenAux N I}
      if I==N then
        I|nil
      else
        I|{GenAux N I+1}
      end
    end
  {GenAux N 0}
  end
end


fun {MyFilter L F}
  local FilterAux in
  fun {FilterAux L F}
    if L==nil then
      nil
    elseif {F L.1} == true then
      L.1|{FilterAux L.2 F}
    else
      {FilterAux L.2 F}
    end
  end
  {FilterAux L F}
  end
end


fun {MyMap L F}
  local MyMapAux in
    fun {MyMapAux L F}
      if L==nil then
        nil
      else
        {F L.1}|{MyMapAux L.2 F}
      end
    end
  end
  {MyMapAux L F}
end


fun {MyFoldL L F A}
  local MyFoldAux in
    fun {MyFoldAux L F A}
      if L==nil then
        A
      else
        {MyFoldAux L.2 F {F A L.1}}
      end
    end
  {MyFoldAux L F A}
  end
end


P1 = {GenerateList 20}
P2 = {MyFilter P1 fun {$ X} X mod 2 \= 0 end}
P3 = {MyMap P2 fun {$ X} X*X end}
P4 = {MyFoldL P3 fun {$ Acc X} X + Acc end 0}
{Browse P4}
