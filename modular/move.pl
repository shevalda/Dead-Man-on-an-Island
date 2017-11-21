/***** PLAYER'S MOVEMENT *****/

/* Moving to north */
n :- i_am_at(X,Y),Y =:= 14,
    write('You cannot go there!'), !, nl.

n :- i_am_at(X,Y),
    retract(i_am_at(X,Y)),
    Ynew is Y + 1,
    asserta(i_am_at(X,Ynew)),
    moved, !.

/* Moving to south */
s :- i_am_at(X,Y),Y =:= 1,
    write('You cannot go there!'), !, nl.

s :- i_am_at(X,Y),
    retract(i_am_at(X,Y)),
    Ynew is Y - 1,
    asserta(i_am_at(X,Ynew)),
    moved, !.

/* Moving to east */
e :- i_am_at(X,Y),X =:= 15,
    write('You cannot go there!'), !, nl.

e :- i_am_at(X,Y),
    retract(i_am_at(X,Y)),
    Xnew is X + 1,
    asserta(i_am_at(Xnew,Y)),
    moved,!.

/* Moving to west */
w :- i_am_at(X,Y),X =:= 11,
    write('You cannot go there!'), !, nl.

w :- i_am_at(X,Y),
    retract(i_am_at(X,Y)),
    Xnew is X - 1,
    asserta(i_am_at(Xnew,Y)),
    moved, !.
    
/* Changing the player's stats with changing position */
moved :- player(Ht,Hg,Th),
    Hgnew is Hg - 3, Thnew is Th - 3,
    retract(player(Ht,Hg,Th)),
    asserta(player(Ht,Hgnew,Thnew)),
    randomEnemy,
    playerchk.
