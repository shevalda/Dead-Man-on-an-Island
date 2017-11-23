/***** PLAYER'S MOVE *****/
/* Moving to north */
n :- i_am_at(X,Y),
	edge(_,[_,YMax]),
	Y =:= YMax,
	write('You see a vast sea..'), nl,
   	write('You cannot go there!'), nl, !.

n :- i_am_at(X,Y),
    retract(i_am_at(X,Y)),
    Ynew is Y + 1,
    asserta(i_am_at(X,Ynew)),
    \+moved,notice(X,Ynew), movdesc(X,Ynew), !.

/* Moving to south */
s :- i_am_at(X,Y),
	edge(_,[YMin,_]),
	Y =:= YMin,
	write('You see a vast sea..'), nl,
    write('You cannot go there!'), nl, !.

s :- i_am_at(X,Y),
    retract(i_am_at(X,Y)),
    Ynew is Y - 1,
    asserta(i_am_at(X,Ynew)),
    \+moved,notice(X,Ynew), movdesc(X,Ynew), !.

/* Moving to east */
e :- i_am_at(X,Y),
	edge([_,XMax],_),
	X =:= XMax,
	write('You see a vast sea..'), nl,
    	write('You cannot go there!'), nl, !.

e :- i_am_at(X,Y),
    retract(i_am_at(X,Y)),
    Xnew is X + 1,
    asserta(i_am_at(Xnew,Y)),
    \+moved,notice(Xnew,Y), movdesc(Xnew,Y), !.

/* Moving to west */
w :- i_am_at(X,Y),
	edge([XMin,_],_),
	X =:= XMin,
	write('You see a vast sea..'), nl,
    	write('You cannot go there!'), nl, !.

w :- i_am_at(X,Y),
    retract(i_am_at(X,Y)),
    Xnew is X - 1,
    asserta(i_am_at(Xnew,Y)),
    \+moved,notice(Xnew,Y), movdesc(Xnew,Y), !.
	
/* Changing the player's stats with changing position */
moved :- player(Ht,Hg,Th),
    Hgnew is Hg - 3, Thnew is Th - 3,
    retract(player(Ht,Hg,Th)),
    asserta(player(Ht,Hgnew,Thnew)),
    \+randomEnemyMove, playerchk.

descmov(X,Y) :-
    forestLoc([XStart,YStart],[XEnd,YEnd]),
    X>=XStart, X=<XEnd,
    Y>=YStart, Y=<YEnd, 
    write('highland'),!.

descmov(_,_) :-
write('lowland').

movdesc(X,Y) :-
    Yn is Y+1,
    Ym is Y-1,
    Xn is X+1,
    Xm is X-1,
    write('To the north is a '),descmov(X,Yn),
    write(', to the east is a '),descmov(Xn,Y),
    write(', to the south is a '),descmov(X,Ym),
    write(', to the west is a '),descmov(Xm,Y),write('.'), nl.
