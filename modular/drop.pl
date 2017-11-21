/*** DROP - Dropping an item ***/
drop(Item) :-
    playerInventory(Inven),
    searchInven(Item, Inven, Bool),
    Bool = yes,
    i_am_at(X,Y),
    delInven(Item),
    asserta(at(Item,X,Y)),
    format('You dropped ~a.', [Item]),
    nl, !.

drop(_) :-
    write('You don\'t have it!'),
    nl.