/*** PLAYER'S STATS ***/

status :-
	player(Ht,Hg,Th),
	write('Health : '), write(Ht), nl,
	write('Hunger : '), write(Hg), nl,
	write('Thirst : '), write(Th), nl,
	write('Weapon : '), playerWeapon(Weapon), write(Weapon), nl,
	write('Inventory:'), nl,
	inventory, !.