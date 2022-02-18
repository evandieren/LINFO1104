declare

fun {Pow X N A}
  if N==0 then A else
    {Pow X N-1 A*X}
  end
end
proc {Dispatch S}
    local Aux in
      proc {Aux S}
        case S of
        H|T then
          case H of
          add(...) then
            thread
            H.3 = H.1 + H.2
            end
          [] 'div'(...) then
          thread
            H.3 = H.1 div H.2
            end
          [] pow(...) then
          thread
            H.3 = {Pow H.1 H.2 1}
            end
          else
            {Browse 'je ne comprend pas (petite voix de siri)'}
          end
          {Aux T}
        end
      end
      thread
        {Aux S}
      end
    end
end

fun {LaunchServer}
  local S P in
    {NewPort S P}
    {Dispatch S}
    P
  end
end

S = {LaunchServer}
Res1
Res2
Res3
{Browse salut}
{Send S 'div'(20 0 Res1)}
{Send S pow(20 2 Res2)}
{Browse Res2}
