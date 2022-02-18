declare
fun {NewPortObject Behaviour Init}
proc {MsgLoop S1 State}
case S1 of Msg|S2 then
{MsgLoop S2 {Behaviour Msg State}}
[] nil then skip
end
end
Sin
in
thread {MsgLoop Sin Init} end
{NewPort Sin}
end

fun {Counter Output}
  local P HandleMessage Pout in
    {NewPort Output Pout}
    fun {HandleMessage Msg State}
      case Msg of
      push(A) then
        local NewS in
        if {Value.hasFeature State A} then
            NewS = {Record.adjoinList State [A#(State.A+1)]}
        else
            NewS = {Record.adjoinList State [A#1]}
        end
        {Send Pout {Record.toListInd NewS}}
        NewS
        end
      end
    end
    P = {NewPortObject HandleMessage state()}
    P
  end
end

proc {Add P X}
  {Send P push(X)}
end

S
P = {Counter S}
{Add P a}
{Add P a}
{Add P c}
{Add P a}
{Add P c}
{Browse S}
