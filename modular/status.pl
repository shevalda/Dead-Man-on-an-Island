/*** PLAYER'S STATS ***/
status :-
    checkStart(0),
    write('You have not started the game.'), !.

status :-
	player(Ht,Hg,Th),
	write('Health : '), write(Ht), nl,
	write('Hunger : '), write(Hg), nl,
	write('Thirst : '), write(Th), nl,
	write('Weapon : '), playerWeapon(Weapon), write(Weapon), nl,
	write('Inventory:'), nl,
	inventory,nl, !.