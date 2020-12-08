; This program checks if the input string is in the form of 1^{m}x1^{n}=1^{mn}, m, n is positive integers
; Input: a string of 1's, x, and =, e.g., '11x111=111111'

; the finite set of states
#Q = {s0,mv,clean2_rej,clean3_rej,product0,product1,product2,cmp,accept,accept2,accept3,accept4,halt_accept,reject,reject2,reject3,reject4,reject5,halt_reject}

; the finite set of input symbols
#S = {1,x,=}

; the complete set of tape symbols
#G = {1,x,=,_,t,r,u,e,f,a,l,s}

; the start state
#q0 = s0

; the blank symbol
#B = _

; the set of final states
#F = {halt_accept}

; the number of tapes
#N = 3

; the transition functions

; State s0: start state
s0 x__ x__ *** reject ; the string starts with x
s0 =__ =__ *** reject ; the string starts with =
s0 1__ 1__ *** mv

; State mv
mv 1__ _1_ rr* mv         ; continue moving
mv x__ ___ r** product0   ; start product
mv =__ =__ *** clean2_rej ; there's no 'x'

; State clean2_rej
clean2_rej =1_ =__ *l* clean2_rej
clean2_rej _1_ ___ *l* clean2_rej
clean2_rej =__ =__ *** reject
clean2_rej ___ ___ *** reject

; State clean3_rej
clean3_rej __1 ___ **l clean3_rej
clean3_rej ___ ___ *** reject

; State product0
product0 x__ ___ rl* product1
product0 1__ 1__ *l* product1
product0 =__ ___ rll cmp

; State product1: add several 1's to the 3rd tape
product1 ___ ___ *l* clean2_rej ; there is no '='
product1 _1_ _1_ *** clean2_rej ; there is no '='
product1 =__ =__ *l* clean2_rej ; there is no 1's after '='
product1 =1_ =1_ *** clean2_rej
product1 1__ 1__ *r* product2
product1 11_ 111 *lr product1

; State product2: turn the head in the 2nd tape to the right end
product2 11_ 11_ *r* product2
product2 1__ ___ r** product0 ; arrived at the right end

; State cmp
cmp ___ ___ *** accept
cmp _1_ ___ *l* cmp
cmp 11_ 1__ *l* cmp
cmp _11 __1 *l* cmp
cmp 111 1_1 *l* cmp
cmp 1__ 1__ *** reject
cmp __1 ___ **l clean3_rej
cmp 1_1 ___ r*l cmp

; State accept*: write 'true' on 1st tape

accept ___ t__ r* accept2
accept2 ___ r__ r* accept3
accept3 ___ u_ r* accept4
accept4 __ e_ ** halt_accept

; State reject*: write 'false' on 1st tape
reject =__ ___ r** reject  ; clean the 1st tape
reject 1__ ___ r** reject
reject __1 ___ **r reject
reject ___ f__ r** reject2
reject2 ___ a__ r** reject3
reject3 ___ l__ r** reject4
reject4 ___ s__ r** reject5
reject5 ___ e__ *** halt_reject