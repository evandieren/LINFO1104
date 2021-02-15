declare
fun {Fibonacci N A}
    fib(N+A fun{$} {Fibonacci A N+A})
end

declare
fun {FiFib}
  {Fibonacci 0 1}
end

{Browse {FiFib}.1}
{Browse {{FiFib}.2}.1}
{Browse {{{FiFib}.2}.2}.1}
{Browse {{{{FiFib}.2}.2}.2}.1}