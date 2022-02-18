declare

fun {MakeGate F}
  local Fg in
    fun {Fg S1 S2}
      case S1#S2 of
      (H|T)#(H2|T2) then {F H H2}|{Fg T T2}
      else nil end
    end

    fun {$ S1 S2}
      thread
        {Fg S1 S2}
      end
    end
  end
end

fun {Delay S}
  thread
  0|S
  end
end

fun {AndF A B}
  A*B
end
fun {NotF A}
  1-A
end

fun {NotGate S1}
  case S1 of
  (H|T) then {NotF H}|{NotGate T}
  else nil end
end

B = {{MakeGate AndF} SIN SOUT}
NOTB = thread {NotGate B} end
SOUT = thread {Delay NOTB} end

SIN = [1 0 1 1 1 0 1 1 0 1 0 0 0 1]
{Browse SOUT}
