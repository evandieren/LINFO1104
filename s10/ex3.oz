declare
N =20
Arr = {NewArray 1 N nil}
Tail ={NewCell ~1}
Head = {NewCell 1}
Sum = {NewCell 0}
R
thread
  for I in 1..(N-1) do
    Arr.@Head := I
    if @Tail == ~1 then Tail := 1 end
    Head := @Head +1
    {Delay 500}
  end
end

thread

  local Aux in
    proc {Aux}
        %sum

        if Arr.@Tail \= nil then
          Sum := @Sum + Arr.@Tail
          Tail := @Tail + 1
        end

        {Delay 100}
      if @Tail >= N then
        R = @Sum
      else
        {Aux}
      end
    end
    {Aux}

  end
end

{Browse R}
