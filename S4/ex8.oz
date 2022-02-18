declare

fun {FindStringAux S T I R}
  {Show T}
  if T == nil then R else
    if {Prefix S T} then
      {FindStringAux S T.2 I+1 I|R}
    else
      {FindStringAux S T.2 I+1 R}
    end
  end
end
fun {FindString S T}
  {FindStringAux S T 1 nil}
end

fun {Prefix A B}
  if A==nil then true
  elseif A==B then true
  elseif B==nil then false
  else
    if A.1 == B.1 then
      {Prefix A.2 B.2}
    else
      false
    end
  end

end

{Browse {FindString [a] [a b a b a b]}}
