declare

fun {NewStack}
  {NewCell nil}
end

proc {Push Stack Elem}
  Stack := Elem|@Stack
end

fun {Pop Stack}
  local A in
    A = @Stack.1
    Stack := @Stack.2
    A
  end
end
fun {IsEmpty Stack}
  @Stack == nil
end

fun {Eval L}

end

{Browse {Eval [13 45 '+' 89 17 '-' '*']}}
%S = {NewStack}
%{Browse {IsEmpty S}}
%{Push S 1}
%{Push S 2}
%{Push S 3}
%{Browse {IsEmpty S}}
%{Browse {Pop S}}
