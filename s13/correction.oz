
declare
proc {PrintAllMsg S}
   proc {Loop S}
      {Browse S.1}
      {Loop S.2}
   end in
   thread {Loop S} end
end
P S
P = {NewPort S}
{PrintAllMsg S}
{Send P foo}
{Send P bar}
{Browse S} % foo|bar|_

%2.

% proposition de solution
declare

fun {Pow X N A}
  if N==0 then A else
    {Pow X N-1 A*X}
  end
end
proc {Dispatch S}
    local Aux in
      proc {Aux S} % Quid si H.1 ou H.2 ne sont pas bound ? Quid s'il y a un crash ?
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
            {Browse 'je ne comprend pas'}
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
{Send S 'div'(20 2 Res1)}
{Send S pow(20 2 Res2)}
{Browse Res2}


% solution avec threads pour rendre le serveur plus solide ;)
declare
fun {LaunchServer} S HandleMessage in
   proc {HandleMessage M}
      thread
         case M
        of add(X Y R) then R = X+Y
        [] pow(X Y R) then R = {Pow X Y}
        [] 'div'(X Y R) then R = X div Y
        else {Show 'unknow message'} end
      end
   end
   thread for M in S do {HandleMessage M} end end
   {NewPort S}
end

declare A B N P Res1 Res2 Res3 Res4 Res5 Res6
P = {LaunchServer}
{Send P add(321 345 Res1)}
{Browse Res1} % 666
{Send P pow(2 N Res2)}
N = 8
{Browse Res2} % 256
{Send P add(A B Res3)}
{Send P add(10 20 Res4)}
{Send P foo} % show error
{Browse Res4} % 30
A = 3
B = 0-A
{Send P 'div'(90 Res3 Res5)}
{Send P 'div'(90 Res4 Res6)}
{Browse Res3} % 0
{Browse Res5} % _
{Browse Res6} % 3


% 3. (pas complet)
declare
fun {StudentRMI} S in
   thread
      for ask(howmany:Beers) in S do
        Beers={OS.rand} mod 24
      end
   end
   {NewPort S}
end
fun {StudentCallBack} S in
   thread
      for ask(howmany:P) in S do
        {Send P {OS.rand} mod 24}
      end
   end
   {NewPort S}
end

declare
fun {CreateUniversity Size}
   fun {CreateLoop I}
      if I=< Size then
         % pour {Student} choisissez soit StudentRMI ou StudentCallBack,
         % défini plus haut, selon l'humeur de Charlotte
        {StudentCallBack}|{CreateLoop I+1}
      else nil end
   end
in
   {CreateLoop 1}
end

declare
proc {Ask University Charlotte RMI}
   if RMI then
      for Student in University do N in
         {Send Student ask(howmany:N)}
         {Send Charlotte N}
      end
   else
      for Student in University do
         {Send Student ask(howmany:Charlotte)}
      end
      {Delay 2000} % wait until everyone reply
   end
   {Send Charlotte nil}
end

fun {Charlotte Msgs Stats}
   case Msgs.1
   of nil then Stats
   [] N then
      case Stats
      of stats(tot:T min:Low max:Up) then R M in
        M = if Low < 0 then N else {Min Low N} end
        R = stats(tot:(T+N) min:M max:{Max Up N})
        {Charlotte Msgs.2 R}
      end
   end
end

declare Msgs
Size = 5
University = {CreateUniversity Size}
CharlotteP = {NewPort Msgs}
{Ask University CharlotteP false}
Stats = {Charlotte Msgs stats(tot:0 min:~1 max:0)}
{Browse mean((Stats.tot div Size))}
{Browse Stats}

%exo4
% proposition de solutuion
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

%exo5
% proposition stack
fun {Stack}
  local P HandleMessage in
    fun {HandleMessage Msg State}
      case Msg of
      push(X) then (X|State)
      [] isEmpty(A) then
      if State==nil then
          A = true
          true else
          A = false
          false
        end
      [] pop(A) then
      if State==nil then
          A = 'impossible'
          State
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

proc {Push S X}
  {Send S push(X)}
end
fun {Pop S}
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
S = {Stack}
{Push S 10}
{Push S 20}
{Browse {Pop S}}
