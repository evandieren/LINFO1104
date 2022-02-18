declare

fun {Append L1 L2}
  if L1 == nil then
    L2
  else
    {Append L1.2 L1.1|L2}
  end
end

{Browse {Append [1 2] [3 4]}}
