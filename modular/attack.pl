/*** ATTACK - Attacking an enemy ***/
attack :- 
    checkStart(0),
    write('You have not started the game.'), !.

/*ketika player tidak memegang weapon*/
attack :-
    i_am_at(X,Y),
    alive(enemy,X,Y,_),
    playerWeapon(none),
	weaponDamageTaken(none,Dmg),
    retract(player(Pts,Hgr,Thr)),
    NewPts is Pts-Dmg,         
    asserta(player(NewPts,Hgr,Thr)),
    write('You can''t attack and took '), write(Dmg), write(' damage'), nl,
    !, playerchk, !.
	
/*ketika player memegang weapon*/
attack :-
	i_am_at(X,Y),
    alive(enemy,X,Y,R),
    playerWeapon(Weapon),
	weaponDamageTaken(Weapon,Dmg),
    retract(alive(enemy,X,Y,_)),
    retract(player(Pts,Hgr,Thr)),
    NewPts is Pts - Dmg,
    asserta(player(NewPts,Hgr,Thr)),
    write('You took '), write(Dmg), write(' damage and the enemy died'),nl,
    addInven(R),
    write('You obtained '), write(R), nl,
    !, playerchk, !.


attack :-
    write('There is nothing to attack.'), nl.
