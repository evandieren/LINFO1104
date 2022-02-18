declare

fun {SumOdd L A}
  local Aux in
    fun {Aux L A}
      case L of
      (H|_|J) then {Aux J H+A}
      [] (H|_) then H+A
      else
        A
      end
    end
    {Aux L A}
  end
end


fun {Test L A}
  local Aux in
    fun {Aux L A}
      case L of
      (H|T) then
      {Browse T}
      {Aux T H+A}
      else
      {Browse L}

        A
      end
    end
    {Aux L A}
  end
end
{Browse {Test [1 2 3 4] 3}}
