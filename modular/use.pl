/*** USE - Using an item ***/
use(_) :-
    checkStart(0),
    write('You have not started the game.'), !.

/* MEDICINE */
use(Item) :-
    medicine(Item),
    playerInventory(L),
    searchInven(Item,L,yes),
    player(Pts,Hgr,Thr),
    NewPts is Pts+20,
    NewPts > 100,
    R is NewPts mod 100,
    delInven(Item),
    NewPts2 is NewPts - R,
    retract(player(Pts,Hgr,Thr)),
    asserta(player(NewPts2,Hgr,Thr)),
    write('You used '), write(Item),  write('.'),nl,
    write('You feel healthy'),nl,
    \+ randomEnemyMove,!.

use(Item) :-
    medicine(Item),
    playerInventory(L),
    searchInven(Item,L,yes),
    player(Pts,Hgr,Thr),
    NewPts is Pts+20,
    delInven(Item),
    retract(player(Pts,Hgr,Thr)),
    asserta(player(NewPts,Hgr,Thr)),
    write('You used '), write(Item),  write('.'),nl,
    write('You feel healthy'),nl,
    \+ randomEnemyMove,!.

/* EXPIRED FOOD */
use(Item) :-
    food(Item), expired(Item),
    playerInventory(L),
    searchInven(Item,L,yes),
    player(Pts,Hgr,Thr),
    NewPts is Pts-7, NewHgr is Hgr + 10,
    NewHgr > 100,
    R is NewHgr mod 100,
    delInven(Item),
    NewHgr2 is NewHgr - R,
    retract(player(Pts,Hgr,Thr)),
    asserta(player(NewPts,NewHgr2,Thr)),
    write('You ate an EXPIRED '), write(Item), write('.'), nl,
    write('You don''t feel healthy'),nl,
    \+ randomEnemyMove,!.

use(Item) :-
    food(Item), expired(Item),
    playerInventory(L),
    searchInven(Item,L,yes),
    player(Pts,Hgr,Thr),
    NewPts is Pts-7, NewHgr is Hgr + 10,
    delInven(Item),
    retract(player(Pts,Hgr,Thr)),
    asserta(player(NewPts,NewHgr,Thr)),
    write('You ate an EXPIRED '), write(Item), write('.'), nl,
    write('You don''t feel healthy'),nl,
    \+ randomEnemyMove,!.

/* GOOD FOOD */
use(Item) :-
    food(Item),
    playerInventory(L),
    searchInven(Item,L,yes),
    player(Pts,Hgr,Thr),
    NewPts is Pts+3, NewHgr is Hgr + 20,
    NewPts > 100, R1 is NewPts mod 100,
    NewPts2 is NewPts - R1,
    NewHgr > 100, R2 is NewHgr mod 100,
    NewHgr2 is NewHgr - R2,
    delInven(Item),
    retract(player(Pts,Hgr,Thr)),
    asserta(player(NewPts2,NewHgr2,Thr)),
    write('You ate '),write(Item), write('.'),nl,
    write('You feel satisfied'),nl,
    \+ randomEnemyMove,!.

use(Item) :-
    food(Item),
    playerInventory(L),
    searchInven(Item,L,yes),
    player(Pts,Hgr,Thr),
    NewPts is Pts+3, NewHgr is Hgr + 20,
    NewPts > 100, R is NewPts mod 100,
    NewPts2 is NewPts - R,
    delInven(Item),
    retract(player(Pts,Hgr,Thr)),
    asserta(player(NewPts2,NewHgr,Thr)),
    write('You ate '),write(Item), write('.'),nl,
    write('You feel satisfied'),nl,
    \+ randomEnemyMove,!.

use(Item) :-
    food(Item),
    playerInventory(L),
    searchInven(Item,L,yes),
    player(Pts,Hgr,Thr),
    NewPts is Pts+3, NewHgr is Hgr + 20,
    NewHgr > 100, R is NewHgr mod 100,
    NewHgr2 is NewHgr - R,
    delInven(Item),
    retract(player(Pts,Hgr,Thr)),
    asserta(player(NewPts,NewHgr2,Thr)),
    write('You ate '),write(Item), write('.'),nl,
    write('You feel satisfied'),nl,
    \+ randomEnemyMove,!.

use(Item) :-
    food(Item),
    playerInventory(L),
    searchInven(Item,L,yes),
    player(Pts,Hgr,Thr),
    NewPts is Pts+3, NewHgr is Hgr + 20,
    delInven(Item),
    retract(player(Pts,Hgr,Thr)),
    asserta(player(NewPts,NewHgr,Thr)),
    write('You ate '),write(Item), write('.'),nl,
    write('You feel satisfied'),nl,
    \+ randomEnemyMove,!.

/* EXPIRED DRINK */
use(Item) :-
    drink(Item), expired(Item),
    playerInventory(L),
    searchInven(Item,L,yes),
    player(Pts,Hgr,Thr),
    NewPts is Pts-7, NewThr is Thr + 10,
    NewThr > 100,
    R is NewThr mod 100,
    delInven(Item),
    NewThr2 is NewThr - R,
    retract(player(Pts,Hgr,Thr)),
    asserta(player(NewPts,Hgr,NewThr2)),
    write('You drank an EXPIRED '), write(Item), write('.'),nl,
    write('You don''t feel healthy'),nl,
    \+ randomEnemyMove,!.

use(Item) :-
    drink(Item), expired(Item),
    playerInventory(L),
    searchInven(Item,L,yes),
    player(Pts,Hgr,Thr),
    NewPts is Pts-7, NewThr is Hgr + 10,
    delInven(Item),
    retract(player(Pts,Hgr,Thr)),
    asserta(player(NewPts,Hgr,NewThr)),
    write('You drank an EXPIRED '), write(Item), write('.'),nl,
    write('You don''t feel healthy'),nl,
    \+ randomEnemyMove,!.

/* GOOD DRINK */
use(Item) :-
    drink(Item),
    playerInventory(L),
    searchInven(Item,L,yes),
    player(Pts,Hgr,Thr),
    NewPts is Pts+3, NewThr is Thr + 20,
    NewPts > 100, R1 is NewPts mod 100,
    NewPts2 is NewPts - R1,
    NewThr > 100, R2 is NewThr mod 100,
    NewThr2 is NewThr - R2,
    delInven(Item),
    retract(player(Pts,Hgr,Thr)),
    asserta(player(NewPts2,Hgr,NewThr2)),
    write('You drank '),write(Item), write('.'),nl,
    write('You feel satisfied'),nl,
    \+ randomEnemyMove,!.

use(Item) :-
    drink(Item),
    playerInventory(L),
    searchInven(Item,L,yes),
    player(Pts,Hgr,Thr),
    NewPts is Pts+3, NewThr is Thr + 20,
    NewPts > 100, R is NewPts mod 100,
    NewPts2 is NewPts - R,
    delInven(Item),
    retract(player(Pts,Hgr,Thr)),
    asserta(player(NewPts2,Hgr,NewThr)),
    write('You drank '),write(Item), write('.'),nl,
    write('You feel satisfied'),nl,
    \+ randomEnemyMove,!.

use(Item) :-
    drink(Item),
    playerInventory(L),
    searchInven(Item,L,yes),
    player(Pts,Hgr,Thr),
    NewPts is Pts+3, NewThr is Thr + 20,
    NewThr > 100, R is NewThr mod 100,
    NewThr2 is NewThr - R,
    delInven(Item),
    retract(player(Pts,Hgr,Thr)),
    asserta(player(NewPts,Hgr,NewThr2)),
    write('You drank '),write(Item), write('.'),nl,
    write('You feel satisfied.'),nl,
    \+ randomEnemyMove,!.

use(Item) :-
    drink(Item),
    playerInventory(L),
    searchInven(Item,L,yes),
    player(Pts,Hgr,Thr),
    NewPts is Pts+3, NewThr is Thr + 20,
    delInven(Item),
    retract(player(Pts,Hgr,Thr)),
    asserta(player(NewPts,Hgr,NewThr)),
    write('You drank '),write(Item), write('.'), nl,
    write('You feel satisfied.'),nl,
    \+ randomEnemyMove,!.

/* ITEMS FROM ENEMY */
use(Item) :-
    playerInventory(L),
    searchInven(Item,L,yes),
    write(Item), write(' cannot be used.'), nl,
    write('But it might be useful in the future...'),
    \+ randomEnemyMove,!.

/* NO ITEM TO BE USED */
use(Item) :-
    playerInventory(L),
    searchInven(Item,L,no),
    write('You don''t have it!'),nl,
    \+ randomEnemyMove.