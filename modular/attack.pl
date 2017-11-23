/*** ATTACK - Attacking an enemy ***/
attack :-
	i_am_at(X,Y),
    alive(enemy,X,Y,RaftItem),
    playerWeapon(spear),
    retract(alive(enemy,X,Y,RaftItem)),
    retract(player(Pts,Hgr,Thr)),
    NewPts is Pts - 9,              % damage yang kena ketika pakai spear = 9
    asserta(player(NewPts,Hgr,Thr)),
    write('You took 9 damage and the enemy died'),nl,
    addInven(RaftItem),
    write('You obtained '), write(RaftItem), nl,
    playerchk,
    write('Your health is '), write(NewPts),nl,
    finish, !.

attack :-
    i_am_at(X,Y),
    alive(enemy,X,Y,RaftItem),
    playerWeapon(knife),
    retract(alive(enemy,X,Y,RaftItem)),
    retract(player(Pts,Hgr,Thr)),
    NewPts is Pts - 21,             % damage yang diterima ketika pakai knife = 21
    asserta(player(NewPts,Hgr,Thr)),
    write('You took 21 damage and the enemy died'),nl,
    addInven(RaftItem),
    write('You obtained '), write(RaftItem), nl,
    playerchk,
    write('Your health is '), write(NewPts), nl,
    finish, !.

attack :-
    i_am_at(X,Y),
    alive(enemy,X,Y),
    playerWeapon(none),
    retract(player(Pts,Hgr,Thr)),
    NewPts is Pts-21,               % damage yang diterima ketika tidak memegang weapon = 21
    asserta(player(NewPts,Hgr,Thr)),
    write('You can''t attack and took 21 damage'), nl,
    playerchk,
    write('Your health is '), write(NewPts), !.

attack :-
    i_am_at(X,Y),
    write('There is nothing to attack'), nl.