/*** ATTACK - Attacking an enemy ***/
attack :-
	i_am_at(X,Y),
    alive(enemy,X,Y),
    at(spear,in,hand),
    retract(alive(enemy,X,Y)),
    retract(player(Pts,Hgr,Thr)),
    NewPts is Pts - 9,              % damage yang kena ketika pakai spear = 9
    asserta(player(NewPts,Hgr,Thr)),
    write('You took 21 damage and the enemy died'),nl,
    write('Your health is '), write(NewPts),nl,
    finish.

attack :-
    i_am_at(X,Y),
    alive(enemy,X,Y),
    at(knife,in,hand),
    retract(alive(enemy,X,Y)),
    retract(player(Pts,Hgr,Thr)),
    NewPts is Pts - 21,             % damage yang diterima ketika pakai knife = 21
    asserta(player(NewPts,Hgr,Thr)),
    write('You took 21 damage and the enemy died'),nl,
    write('Your health is '), write(NewPts), nl,
    finish.

attack :-
    i_am_at(X,Y),
    alive(enemy,X,Y),
    retract(player(Pts,Hgr,Thr)),
    NewPts is Pts-21,               % damage yang diterima ketika tidak memegang weapon = 21
    asserta(player(NewPts,Hgr,Thr)),
    write('You can''t attack and took 21 damage'), nl,
    write('Your health is '), write(NewPts).

attack :-
    write('There is nothing to attack'), nl.