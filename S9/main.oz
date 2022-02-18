declare

%fun {Reverse Xs}
%    local A in
%        A = {NewCell nil}
%        for X in Xs do
%          A := X|@A
%        end
%        A := @A|nil
%        @A
%    end

%end

class Pile
  attr data
  meth newStack() % pas d'argument donc pas besoin de $
    data := {NewCell nil}
  end
  meth isEmpty($)
    @data==nil % pourquoi des {} ? desespoir comme les $ , j avais des erreurs inconnues donc j ai essaye de faire un petit peut tout
  end
  meth push(Elem)
    data := Elem|@data
  end
  meth pop($)
    local A in
      A = @data.1
      data := @data.2
      A
    end
  end
end

Stack = {New Pile newStack()}
{Browse {Stack isEmpty($)}} %% manque un $ pour que l'expression renvoie une valeur

{Stack push(1)}
{Stack push(2)}
{Stack push(3)}
{Browse {Stack pop($)}}
