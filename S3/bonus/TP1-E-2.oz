
declare
fun {Fib N}
  if N < 2 then
    N
  else
    {Fib N-1} + {Fib N-2}
  end
end

fun {Fib2aux N Ac1 Ac2}
  if N<0 then Ac2
  else
    {Fib2aux N-1 Ac2 Ac1+Ac2}
  end
end

fun {Fib2 N}
  if N==0 then 0 else {Fib2aux N-2 0 1} end

end
{Browse {Fib 9}}
{Browse {Fib2 9}}
