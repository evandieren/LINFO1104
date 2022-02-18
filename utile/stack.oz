local
fun {StackObject S}
fun {Push E} {StackObject E|S} end
fun {Pop S1}
case S of X|T then S1={StackObject T} X end end
fun {IsEmpty} S==nil end
in
stack(push:Push pop:Pop isEmpty:IsEmpty)
end
in
fun {NewStack} {StackObject nil} end
end
