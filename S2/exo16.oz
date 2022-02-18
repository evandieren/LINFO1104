declare

fun {Test N T C}
   if C <1 then T
   else
      if N mod C == 0 then {Test N T+1 C-1} else {Test N T C-1} end
   end

end

fun {NombrePavages N}
  {Test N 0 N}
end

{Show {NombrePavages 6}}

% question 2
declare
fun {Test N T C}
   if C <1 then T
   else
      if N mod C == 0 then {Test N T+(C*C) C-1} else {Test N T C-1} end
   end

end

fun {NombrePaves N}
   {Test N 0 N}
end

{Show {NombrePaves 6}}