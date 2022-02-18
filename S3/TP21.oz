declare
fun {Rl List Acc}
  if List==nil then
    Acc
  else
    {Rl List.2 Acc+1}
  end

end

fun {Length List}
  {Rl List 0}
end

{Show {Length [1 2 3 4]}}
