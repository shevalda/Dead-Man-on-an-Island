/*** USE - Using an item ***/
use(Item) :-
    food(Item),expired(Item),
    playerInventory(L),
    searchInven(Item,L,yes),delInven(Item),
    retract(player(Pts,Hgr,Thr)),
    NewPts is Pts-7,NewHgr is Hgr + 10,
    asserta(player(NewPts,NewHgr,Thr)),
    write('You ate an EXPIRED '),write(Item),nl,
    write('you don''t feel healthy'),nl,!.

use(Item) :-
    food(Item),
    playerInventory(L),
    searchInven(Item,L,yes),delInven(Item),
    retract(player(Pts,Hgr,Thr)),
    NewPts is Pts+3,NewHgr is Hgr + 20,
    asserta(player(NewPts,NewHgr,Thr)),
    write('You ate '),write(Item),nl,
    write('you feel satisfied'),nl,!.

use(Item) :-
    drink(Item),expired(Item),
    playerInventory(L),
    searchInven(Item,L,yes),delInven(Item),
    retract(player(Pts,Hgr,Thr)),
    NewPts is Pts-7,NewThr is Thr + 10,
    asserta(player(NewPts,Hgr,NewThr)),
    write('You drank an EXPIRED '),write(Item),nl,
    write('you don''t feel healthy'),nl,!.

use(Item) :-
    drink(Item),
    playerInventory(L),
    searchInven(Item,L,yes),delInven(Item),
    retract(player(Pts,Hgr,Thr)),
    NewPts is Pts+3,NewThr is Thr + 20,
    asserta(player(NewPts,Hgr,NewThr)),
    write('You drank '),write(Item),nl,
    write('you feel satisfied'),nl,!.

use(Item) :-
    playerInventory(L),
    searchInven(Item,L,no),
    write('you don''t have it!'),nl.