declare
proc {NewThread P SubThread}
proc {ZeroExit N S}
case S of X|S2 then
if N+X\=0 then
{ZeroExit N+X S2}
end
end
end
S Pt={NewPort S}
in
proc {SubThread P}
thread
{Send Pt 1} % This should be done before the thread creation
 {P}
 {Send Pt ~1}
end
end
{SubThread P}
 {ZeroExit 0 S}
end
P=2
SubThread
{Browse P}
{NewThread P SubThread}
