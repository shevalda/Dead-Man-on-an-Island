/*** ATTACK - Attacking an enemy ***/
attack :- 
    checkStart(0),
    write('You have not started the game.'), !.

attack :-
	i_am_at(X,Y),
    alive(enemy,X,Y,_),
    playerWeapon(spear),
    retract(alive(enemy,X,Y,_)),
    retract(player(Pts,Hgr,Thr)),
    NewPts is Pts - 9,              % damage yang kena ketika pakai spear = 9
    asserta(player(NewPts,Hgr,Thr)),
    write('You took 9 damage and the enemy died'),nl,
    addInven(_),
    write('You obtained '), write(_), nl,
    !, playerchk, !.

attack :-
    i_am_at(X,Y),
    alive(enemy,X,Y,_),
    playerWeapon(knife),
    retract(alive(enemy,X,Y,_)),
    retract(player(Pts,Hgr,Thr)),
    NewPts is Pts - 21,             % damage yang diterima ketika pakai knife = 21
    asserta(player(NewPts,Hgr,Thr)),
    write('You took 21 damage and the enemy died'),nl,
    addInven(_),
    write('You obtained '), write(_), nl,
    !, playerchk, !.

attack :-
    i_am_at(X,Y),
    alive(enemy,X,Y,_),
    playerWeapon(none),
    retract(player(Pts,Hgr,Thr)),
    NewPts is Pts-21,               % damage yang diterima ketika tidak memegang weapon = 21
    asserta(player(NewPts,Hgr,Thr)),
    write('You can''t attack and took 21 damage'), nl,
    !, playerchk, !.

attack :-
    write('There is nothing to attack.'), nl.