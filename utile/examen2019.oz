declare

fun {Producteur}
  local Aux in
     fun {Aux N}
      {Delay 1000}
      (N)|{Aux N+1}
     end
     {Aux 0}
   end
end

fun {Add S1 S2}
  case S1#S2 of
  (H|T)#(H2|T2) then
    (H+H2)|{Add T T2}
  end
end
fun {DelayG S}
  0|S
end
B
A = thread {Producteur} end
C = thread {Add A B} end
B = thread {DelayG C} end

{Browse A}
{Browse C}
