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

fun {Portier}
  local P HandleMessage in
    fun {HandleMessage Msg State}
      case Msg of
      getIn(N) then (State+N)
      [] getOut(N) then (State-N)
      [] getCount(N) then
        N = State
        State
      else
        {Browse 'mauvais_message'}
        'mauvais_message'
      end
    end
    P = {NewPortObject HandleMessage 0}
    P
  end
end

P = {Portier}
{Browse {Send P getCount($)}}
{Send P getIn(10)}
{Send P getIn(10)}
{Browse {Send P getCount($)}}


