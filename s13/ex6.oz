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

fun {Queue}
  local P HandleMessage in
    fun {HandleMessage Msg State}
      case Msg of
      push(X) then
        {List.append X|nil State}
      [] isEmpty(A) then
        if State==nil then
          A = true
        else
          A = false
        end
        State
      [] get(A) then
          A = State
          State
      [] pop(A) then
          if State == nil then
            A =nil
            nil
          else
            A = State.1
            State.2
          end
      end
    end
    P = {NewPortObject HandleMessage nil}
    P
  end
end

proc {Enqueue S X}
  {Send S push(X)}
end
fun {Dequeue S}
  local A in
    {Send S pop(A)}
    A
  end
end
fun {IsEmpty S}
  local A in
    {Send S isEmpty(A)}
    A
  end
end
fun {GetElements S}
  local A in
    {Send S get(A)}
    A
  end
end
S = {Queue}
{Enqueue S 10}
{Enqueue S 20}
{Enqueue S 30}
{Enqueue S 40}
{Browse {Dequeue S}}
{Browse {Dequeue S}}
{Browse {GetElements S}}
{Browse {IsEmpty S}}
{Browse {Dequeue S}}
{Browse {Dequeue S}}
{Browse {Dequeue S}}
{Browse {Dequeue S}}
{Browse {IsEmpty S}}
