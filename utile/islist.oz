declare
fun {WhatsThis R}
  if {IsList R} then list else
if {IsTuple R} then tuple else
  record
end
  end
end

{Browse {WhatsThis a(1:a 2:b 3:c)}}
{Browse {WhatsThis a(1:a 2:b 4:c)}}
{Browse {WhatsThis a(0:a 1:b 2:c)}}
{Browse {WhatsThis a(1:a 2:b 3:c d)}}
{Browse {WhatsThis a(a 2:b 3:c 4:d)}}
{Browse {WhatsThis a(2:b 3:c 4:d a)}}
{Browse {WhatsThis a(1:a 2:b 3:c foo:d)}}
{Browse {WhatsThis '|'(1:a 2:'|'(1:b 2:nil))}}
{Browse {WhatsThis '|'(1:a 2:'|'(1:b 3:nil))}}
