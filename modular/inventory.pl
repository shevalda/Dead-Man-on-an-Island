/***** INVENTORY *****/
/** Search in Inventory **/
searchInven(_, [], Bool) :-
    Bool = no, !.

searchInven(Item, [H|_], Bool) :-
    H = Item,
    Bool = yes, !.

searchInven(Item, [H|T], Bool) :-
    H \= Item,
    searchInven(Item, T, Btemp),
    Bool = Btemp.

/* Add an item to inventory */
addInven(Item) :-
    playerInventory(L),
    append([Item], L, LNew),
    retract(playerInventory(L)),
    asserta(playerInventory(LNew)).

/** Take an item from inventory **/
delInven(Item) :-
    playerInventory(L),
    delFromInven(Item, L, LNew),
    retract(playerInventory(L)),
    asserta(playerInventory(LNew)).

delFromInven(_, [], NewInven) :-
    NewInven = [].

delFromInven(Item, [H|T], NewInven) :-
    H = Item, NewInven = T, !.

delFromInven(Item, [H|T], NewInven) :-
    H \= Item,
    delFromInven(Item, T, LTail),
    append([H], LTail, NewInven).

/** Print player's inventory **/
inventory :-
    playerInventory(L),
    printInven(L).

printInven([]) :-
    tab(3), write('You have no item in your inventory.'), !.

printInven([X]) :-
    tab(3), write(X), !.

printInven([H|T]) :-
    tab(3), write(H), nl,
    printInven(T).