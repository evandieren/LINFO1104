declare
fun {Test N I}
   if I < 2 then true
   else
      if (N mod I) == 0 then false else {Test N I-1} end
   end

end
fun {Premier N}
   {Test N N-1}
end

{Show {Premier 6}}
