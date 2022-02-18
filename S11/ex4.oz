declare

fun {MakeBinaryGate F} % complexity O(1)
   fun {FG X Y}
      case X#Y
      of (H1|Xs)#(H2|Ys) then
        {F H1 H2}|{FG Xs Ys}
      else nil end
   end in
   fun {$ Xs Ys} thread {FG Xs Ys} end end % complexité O(1)
end


fun {N A B}
  (A*B-A-B+1)
end
NorG ={MakeBinaryGate N}

local R=1|0|0|1|0|_ S=0|0|1|0|0|_ Q NotQ
  proc {Bascule Rs Ss Qs NotQs}
    Qs = {NorG Rs 1|NotQs}
    NotQs = {NorG Ss 0|Qs}
  end
in
  {Bascule R S Q NotQ}

  {Browse Q#NotQ}
end
