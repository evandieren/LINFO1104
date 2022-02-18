declare

fun {Test A B C}
   if {Max (A mod C) (B mod C)} == 0 then C
   else
      {Test A B C-1}
   end
end


fun {PGCD A B}
   {Test A B {Max A B}}
end

{Show {PGCD 4 8}}