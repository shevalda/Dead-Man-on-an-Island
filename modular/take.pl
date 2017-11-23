/*** TAKE - Taking an item ***/
take(Item) :- 					% weapon unable to take
	i_am_at(X,Y),
    at(Item,X,Y),
    weapon(Item),
    \+ playerWeapon(none),
    write('You cannot hold 2 weapon at once!'),nl,!.

take(Item) :-					% weapon able to take
	i_am_at(X,Y),
    at(Item,X,Y),
    weapon(Item),
	playerWeapon(none),
    retract(at(Item,X,Y)),
    retract(playerWeapon(none)),
    asserta(playerWeapon(Item)),nl, !.

take(Item) :-					% item able to take
    i_am_at(X,Y),
    at(Item,X,Y),
    retract(at(Item,X,Y)),
    addInven(Item),
    format('You took ~a.', [Item]), nl, !.

take(Item) :-					% item unable to take
    playerInventory(Inven),
    searchInven(Item, Inven, Bool),
    Bool = yes,
    write('You already took ~a!', [Item]),
    nl, !.

take(_) :-						% taking empty space
    write('I don''t see anything here.'),
    nl.