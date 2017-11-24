/*** DROP - Dropping an item ***/
drop(_) :-
    checkStart(0),
    write('You have not started the game.'), !.

drop(Item) :-           %droping a weapon
    weapon(Item),
    retract(playerWeapon(Item)),
    asserta(playerWeapon(none)),
    i_am_at(X,Y),
    asserta(at(knife,X,Y)),
    format('You dropped ~a.', [Item]),
    nl, \+ randomEnemyMove, !.

drop(Item) :-           %droping item from inventory
    playerInventory(Inven),
    searchInven(Item, Inven, yes),
    i_am_at(X,Y),
    delInven(Item),
    asserta(at(Item,X,Y)),
    format('You dropped ~a.', [Item]),
    nl, \+ randomEnemyMove, !.

drop(_) :-
    write('You don\'t have it!'),
    nl, \+ randomEnemyMove.