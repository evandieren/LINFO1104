declare

fun {PromenadeAux B Acc}
  case B of btree(A left: L right: R) then
    if L==empty then
      if R==empty then
        A
      else
        A|{PromenadeAux R Acc}
      end
    else
      if R==empty then
        A|{PromenadeAux L Acc}
      else
        A|{PromenadeAux L {PromenadeAux R Acc}}
      end
    end
    end
  end
end

fun {Promenade A}
  {Promenade A nil}
end
{Browse
{Promenade
btree(42
left: btree(26
left: btree(54
left: empty
right: btree(18
left: empty
right: empty))
right: empty)
right: btree(37
left: btree(11
left: empty
right: empty)
right: empty))}}
