local
fun {F A}
C={ NewCell  0}
in
fun {$ B}
A-{B C}+{B C}
end
end
in
{Browse  {{F 1} fun{$ C} C:=@C+1 @C end}}
end

local F UnnestApply1 UnnestApply2 UnnestApply3 Fun1 in
   proc {F A Result1}
      local C UnnestApply4 in
   UnnestApply4 = 0
   {NewCell UnnestApply4 C}
   proc {Result1 B Result2}
      local UnnestApply5 UnnestApply6 UnnestApply7 in
         {B C UnnestApply6}
         UnnestApply5 = A - UnnestApply6
         {B C UnnestApply7}
         Result2 = UnnestApply5 + UnnestApply7
      end
   end
      end
   end
   UnnestApply3 = 1
   {F UnnestApply3 UnnestApply2}
   proc {Fun1 C Result3}
      local UnnestApply8 UnnestApply9 UnnestApply10 in
   {`catAccess` C UnnestApply9}
   UnnestApply10 = 1
   UnnestApply8 = UnnestApply9 + UnnestApply10
   {`catAssign` C UnnestApply8}
   {`catAccess` C Result3}
      end
   end
   {UnnestApply2 Fun1 UnnestApply1}
   {Browse UnnestApply1}
end
