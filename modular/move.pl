/***** PLAYER'S MOVE *****/
/* Moving to north */
n :- i_am_at(X,Y),
	edge(_,[_,YMax]),
	Y =:= YMax,
    write('You cannot go there!'), nl, !.

n :- i_am_at(X,Y),
    retract(i_am_at(X,Y)),
    Ynew is Y + 1,
    asserta(i_am_at(X,Ynew)),
    \+moved, look, !.

/* Moving to south */
s :- i_am_at(X,Y),
	edge(_,[YMin,_]),
	Y =:= YMin,
    write('You cannot go there!'), nl, !.

s :- i_am_at(X,Y),
    retract(i_am_at(X,Y)),
    Ynew is Y - 1,
    asserta(i_am_at(X,Ynew)),
    \+moved, look, !.

/* Moving to east */
e :- i_am_at(X,Y),
	edge([_,XMax],_),
	X =:= XMax,
    write('You cannot go there!'), nl, !.

e :- i_am_at(X,Y),
    retract(i_am_at(X,Y)),
    Xnew is X + 1,
    asserta(i_am_at(Xnew,Y)),
    \+moved, look, !.

/* Moving to west */
w :- i_am_at(X,Y),
	edge([XMin,_],_),
	X =:= XMin,
    write('You cannot go there!'), nl, !.

w :- i_am_at(X,Y),
    retract(i_am_at(X,Y)),
    Xnew is X - 1,
    asserta(i_am_at(Xnew,Y)),
    \+moved, look, !.
	
/* Changing the player's stats with changing position */
moved :- player(Ht,Hg,Th),
    Hgnew is Hg - 3, Thnew is Th - 3,
    retract(player(Ht,Hg,Th)),
    asserta(player(Ht,Hgnew,Thnew)),
    \+randomEnemyMove, playerchk.