declare
P S
{NewPort S P}

proc {CatchAndBrowse S}
    local Aux in
      proc {Aux S}
        case S of
        H|T then
          {Browse H}
          {Aux T}
        end
      end
      thread
        {Aux S}
      end
    end
end

{Send P foo}
{Send P ba}
{CatchAndBrowse S}
{Send P bar}
{Send P bou}

% 1:foo|bar|_<future>
