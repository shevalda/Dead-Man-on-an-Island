/*** TAKE - Taking an item ***/
take(Item) :- 
	i_am_at(X,Y),
    at(Item,X,Y),
    at(Weapon,in,hand),
    weapon(Item),weapon(Weapon),
    write('You cannot hold 2 weapon at once!'),nl,!.

take(Item) :-
	i_am_at(X,Y),
    at(Item,X,Y),
    weapon(Item),
    retract(at(Item,X,Y)),
    asserta(at(Item,in,hand)),nl, !.

take(Item) :-
    i_am_at(X,Y),
    at(Item,X,Y),
    retract(at(Item,X,Y)),
    addInven(Item),
    format('You took ~a.', [Item]), nl, !.

take(Item) :-
    playerInventory(Inven),
    searchInven(Item, Inven, Bool),
    Bool = yes,
    write('You already took ~a!', [Item]),
    nl, !.

take(_) :-
    write('I don''t see anything here.'),
    nl.