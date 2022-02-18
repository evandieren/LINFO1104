declare
%proc {ForCollect Xs P Ys}
%  Acc={NewCell Ys}
%  fun {C X} R2 in @Acc=X|R2 Acc:=R2 end
%in
%  for X in Xs do {P C X} end @Acc=nil
%end
%{Browse {ForCollect [ 0 2 4 6 8 ] proc {$ Collect X} {Collect X div 2} end}}
fun {forCollect Xs P}
  local C in
    fun {C X}
      local R2 in
        X
      end
    end
    thread


    end
  end
end

{Browse {ForCollect [ 0 2 4 6 8 ] proc {$ Collect X} {Collect X div 2} end}}
