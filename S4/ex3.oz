declare
fun {Append A B}
  if A ==nil then
    B
  elseif B==nil then
    A
  else
    A|B
  end
end

declare
fun {Append A B}
  case A of
  nil then B
  else A|B end
end

{Browse {Append nil [l u i s]}}
