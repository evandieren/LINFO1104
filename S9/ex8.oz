declare
class Collection
  attr elements
  meth init() % initialise la collection
    elements:=nil
  end
  meth put(X) % insere X
    elements:=X|@elements
  end
  meth get($) % extrait un element et le renvoie
  case @elements of
  X|Xr then elements:=Xr X end
  end
  meth isEmpty($) % renvoie true ssi la collection est vide
    @elements==nil
  end
  meth union(C)
  {C makeUnion(self)}
  end
  meth exist(E C_E)
    local R in
    R = {NewCell false}
    for L in @elements do
      if L==E then
        R := true
      end
    end
    C_E = @R
    end
  end
  meth makeUnion(C)
    for E in @elements do
      local C_E in
        {C exist(E C_E)}
        if C_E==false then
          {C put(E)}
        end
      end
    elements := nil
    end
  end

  meth showList()
    for E in @elements do
      {Browse E}
    end
  end
end

class SortedCollection from Collection

  meth get($)
    local Sorted in
      {List.sort @elements Value.'<' Sorted}
      elements := Sorted
      Sorted.1
    end
  end
end

C1 = {New SortedCollection init()}
{C1 put(1)}
{C1 put(2)}
{C1 put(3)}
C2 = {New SortedCollection init()}
{C2 put(2)}
{C2 put(3)}
{C2 put(9)}
{C2 put(10)}
{C2 put(4)}
{C1 union(C2)}
{Browse c1}

{Browse {C1 get($)}}
{C1 showList()}
%{Browse c2}

%{C2 showList()}
