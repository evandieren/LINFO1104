declare
fun {ProduceTF} % 1 [s] per call
  local Aux in
     fun {Aux}
      {Delay 1000}
      ({OS.rand} mod 2)|{Aux}
     end
     {Aux}
   end
end
fun {AndG A B}
  (A*B)
end
fun {OrG A B}
  (A+B-A*B)
end
fun {NorG A B}
  (A*B-A-B+1)
end
fun {Xor A B} (A + B) mod 2 end % complexite O(K) (constante)
% complexité O(K) (constant) car aucune boucle, ne fait que créer une fonction
fun {MakeBinaryGate F}
  local Aux Aux2 in
    fun {Aux2 A B}
      fun {Aux A B}
        case A#B of
          (H|T)#(J|L) then {F H J}|{Aux T L}
        end
      end
      thread {Aux A B} end
    end
    Aux2
  end
end



A = thread {ProduceTF} end
B = thread {ProduceTF} end
O =  {{MakeBinaryGate Xor} A B}
O1 =  {{MakeBinaryGate AndG} A B}
O2 =  {{MakeBinaryGate OrG} A B}
O3 =  {{MakeBinaryGate NorG} A B}
{Browse O}
{Browse O1}
{Browse O2}
{Browse O3}
%local R=1|1|1|0|_ S=0|1|0|0_ Q NotQ
%proc {Bascule Rs Ss Qs NotQs}
%{NorG Rs NotQs Qs}
%{NorG Ss Qs NotQs}
%end
%in
%{Bascule R S Q NotQ}
%{Browse Q#NotQ}
%end
