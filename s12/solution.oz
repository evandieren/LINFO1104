local R=1|1|1|0|_ S=0|1|0|0|_ Q NotQ
   proc {Bascule Rs Ss Qs NotQs}
      {NorG Rs NotQs Qs}
      {NorG Ss 0|Qs NotQs}
   end
in
   {Bascule R S Q NotQ}
   {Browse Q#NotQ}
end
```

## ex 5 "list comprehension":

```
declare
proc {ForCollectDecl Xs P Ys}
   proc {Loop Xs P Ys}
      case Xs of _|_ then
        {P proc {$ X} Ys=X|_ end Xs.1}
        {Loop Xs.2 P Ys.2}
      else Ys = nil end
   end
in
   {Loop Xs P Ys}
end
```

Note: il existe une syntaxe pour cela:

```
{Browse [X div 2 suchthat X in [0 2 4 6 8]]}
```

Exercice en plus:
1. Faire la même chose avec List.map
2. Le faire avec un agent (avec un stream en argument)

## An introduction to message passing

On a une function `MakeServer` qui prend en arg `Callback` et un state initial. La fonction callback prend deux args: un message et le state et renvoie un nouveau state.
La fonction `MakeServer` renvoie une proc `Send`.

```
declare
fun {MakeServer CallBack InitState} ??? end

declare
Send = {MakeServer fun{$ Msg State} {Browse Msg} State end undefined}
{Send hello} % browse hello

declare
Send = {MakeServer proc{$ M S NewS} NewS = S+M {Browse NewS} end 0}
{Send 1} % browse 1
{Send 2} % browse 3

declare
Send = {MakeServer proc{$ M S NewS} NewS = S+M {Browse NewS} end 0}
thread
   for X in 1..50 do
      {Send X}
   end
end
thread
   for X in 51..100 do
      {Send X}
   end
end

```

First hint:
- For the Server, think about an "agent"

```
declare
fun {MakeServer CallBack InitState}
   proc {Server Messages State}
      ???
   end
   proc {Send Message}
      ???
   end
in
   % How can we launch the Server ?
   Send % return value
end
```


Second hint:

Second hint:
- Think about Cells
- Think about Streams
- If I want to use Send from different threads, what should you do ?

```
declare
fun {MakeServer CallBack InitState}
   proc {Server Messages State}
      case Messages
      of Message|T then NewState in
        NewState = {CallBack Message State}
        {Server T NewState}
      end
   end
   proc {Send Message}
      ???
   end
in
   thread {Server ??? InitState} end
   Send % return value
end

```

Solution:

```
fun {MakeServer CallBack InitState}
   Head
   MailBox = {NewCell Head}
   proc {Server Messages State}
      case Messages
      of Message|T then NewState in
        NewState = {CallBack Message State}
        {Server T NewState}
      end
   end
   proc {Send Message} Prev Next in
      {Exchange MailBox Prev Next}
      Prev = Message|Next
   end
in
   thread {Server Head InitState} end
   Send
end
```
