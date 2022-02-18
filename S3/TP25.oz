declare

fun {TakeAux Source Rendu Reste}
  if Reste==0 then
    Rendu
  else
    {TakeAux Source.2 Source.1|Rendu Reste-1}
  end
end
fun {Take List Tot}
  {TakeAux List nil Tot}
end

{Browse {Take [1 2 3 4 5] 2}}
