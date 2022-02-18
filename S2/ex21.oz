declare

fun {Flatten L}
   
   {List.Flatten +L}
   
end

{Browse {Flatten [a [b [c d]] e [[[f]]]]}}