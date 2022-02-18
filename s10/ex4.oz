declare

fun {ProduceInts N} % 1 [s] per call
   fun {ProduceIntsAux N C}
      if N == C then C|nil
      else C|{ProduceIntsAux N C+1} end
   end in
   {ProduceIntsAux N 1}
end

fun {OddFilter A}
    case A of
    H|T then
      if H mod 2 == 0 then
        H|{OddFilter T}
      else
        {OddFilter T}
      end
   else
    nil
   end
end

fun {Consumer A}
  case A of
  H|T then
  {Browse H}
  H+{Consumer T}
  else
    0
  end
end
A1
F1
C

thread A1 = {ProduceInts 10} end
thread F1 = {OddFilter A1} end
thread C = {Consumer F1} end
{Browse C}
