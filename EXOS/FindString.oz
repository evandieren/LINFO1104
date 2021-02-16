declare
fun {Prefix A B}
   if (A == nil)  then true
   elseif (B == nil) then false
   elseif (A.1 == B.1) then {Prefix A.2 B.2}
   else
      false
   end
end

declare
fun {FindStringAux A B L I}
   if (B == nil) then L
   elseif ({Prefix A B}) then {FindStringAux A B.2 {Append L [I]} I+1}
   else
      {FindStringAux A B.2 L I+1}
   end
end

declare
fun {FindString A B}
   {FindStringAux A B nil 1}
end


{Browse {FindString [c] [a b a b a b]}}