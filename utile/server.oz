declare
fun {NewPortObject Behaviour Init}
proc {MsgLoop S1 State}
case S1 of Msg|S2 then
{Behaviour Msg}
{MsgLoop S2 nil}
[] nil then skip
end
end
Sin
in
thread {MsgLoop Sin Init} end
{NewPort Sin}
end

proc {ServerProc Msg}
case Msg of calc(X Y Client) then D in
{Send Client delta(D)}
Y=X*X+2.0*D*X+D*D+23.0
end
end
Server={NewPortObject ServerProc nil}
Sout
Prout = {NewPort Sout}
proc {ClientProc Msg}
case Msg of work(Z) then Y in
{Send Server calc(10.0 Y Client)}

thread
Z=Y+10.0
{Send Prout trouve(Z)}
end
[] delta(D) then
D=0.1
{Send Prout envoye(delta)}

end
end

Client={NewPortObject ClientProc nil}
Z
{Send Client work(Z)}
{Browse Sout}
