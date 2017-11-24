/***** PLAYER'S MOVE *****/
/* Moving to north */
n :-
    checkStart(0),
    write('You have not started the game.'), !.

n :- i_am_at(X,Y),
	edge(_,[_,YMax]),
	Y =:= YMax,
	write('You see a vast sea..'), nl,
   	write('You cannot go there!'), nl, !.

n :- i_am_at(X,Y),
    retract(i_am_at(X,Y)),
    Ynew is Y + 1,
    asserta(i_am_at(X,Ynew)),
    \+moved, describe(X,Ynew), tab(1),
    movedesc(X,Ynew), nl, nl,
	notice_objects_at(X,Ynew),
    notice_enemy_at(X,Ynew), !.

/* Moving to south */
s :-
    checkStart(0),
    write('You have not started the game.'), !.

s :- i_am_at(X,Y),
	edge(_,[YMin,_]),
	Y =:= YMin,
	write('You see a vast sea..'), nl,
    	write('You cannot go there!'), nl, !.

s :- i_am_at(X,Y),
    retract(i_am_at(X,Y)),
    Ynew is Y - 1,
    asserta(i_am_at(X,Ynew)),
    \+moved, describe(X,Ynew), tab(1),
    movedesc(X,Ynew), nl, nl,
	notice_objects_at(X,Ynew),
    notice_enemy_at(X,Ynew), !.

/* Moving to east */
e :-
    checkStart(0),
    write('You have not started the game.'), !.

e :- i_am_at(X,Y),
	edge([_,XMax],_),
	X =:= XMax,
	write('You see a vast sea..'), nl,
    	write('You cannot go there!'), nl, !.

e :- i_am_at(X,Y),
    retract(i_am_at(X,Y)),
    Xnew is X + 1,
    asserta(i_am_at(Xnew,Y)),
    \+moved, describe(X,Ynew), tab(1),
    movedesc(X,Ynew), nl, nl,
	notice_objects_at(Xnew,Y),
    notice_enemy_at(Xnew,Y), !.

/* Moving to west */
w :-
    checkStart(0),
    write('You have not started the game.'), !.

w :- i_am_at(X,Y),
	edge([XMin,_],_),
	X =:= XMin,
	write('You see a vast sea..'), nl,
    	write('You cannot go there!'), nl, !.

w :- i_am_at(X,Y),
    retract(i_am_at(X,Y)),
    Xnew is X - 1,
    asserta(i_am_at(Xnew,Y)),
    \+moved, describe(X,Ynew), tab(1),
    movedesc(X,Ynew), nl, nl,
	notice_objects_at(Xnew,Y),
    notice_enemy_at(Xnew,Y), !.
	
/* Changing the player's stats with changing position */
moved :- player(Ht,Hg,Th),
    Hgnew is Hg - 3, Thnew is Th - 3,
    retract(player(Ht,Hg,Th)),
    asserta(player(Ht,Hgnew,Thnew)),
    \+randomEnemyMove, playerchk.
