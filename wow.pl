:- dynamic(at/3, i_am_at/2, alive/3, player/3, playerInventory/1).

/* player's current position
   initial position : (7,6) */
i_am_at(7,6).

/* Player's stats
   Initial stats:
        Health = 100
        Hunger = 100
        Thrist = 100 */
player(100,100,100).

at(radar,7,7).
at(knife,7,6).
at(spear,7,6).

weapon(spear).
weapon(knife).

alive(enemy,7,7).

/* Player's list of inventory */
playerInventory([]).

/***** PLAYER'S MOVE *****/
/* Moving to north */
n :- i_am_at(X,Y),
    retract(i_am_at(X,Y)),
    Ynew is Y + 1,
    asserta(i_am_at(X,Ynew)),
    moved, look, !.

/* Moving to south */
s :- i_am_at(X,Y),
    retract(i_am_at(X,Y)),
    Ynew is Y - 1,
    asserta(i_am_at(X,Ynew)),
    moved, !.

/* Moving to east */
e :- i_am_at(X,Y),
    retract(i_am_at(X,Y)),
    Xnew is X + 1,
    asserta(i_am_at(Xnew,Y)),
    moved,!.

/* Moving to west */
w :- i_am_at(X,Y),
    retract(i_am_at(X,Y)),
    Xnew is X - 1,
    asserta(i_am_at(Xnew,Y)),
    moved, !.

/* Changing the player's stats with changing position */
moved :- player(Ht,Hg,Th),
    Hgnew is Hg - 3, Thnew is Th - 3,
    retract(player(Ht,Hg,Th)),
    asserta(player(Ht,Hgnew,Thnew))
    ,playerchk.

/* check alive */
playerchk :- player(Ht,Hg,Th),
	Ht < 0,Hg < 0, Th < 0, !, die.

die :- 
	write('Your vision slowly fade while you'),nl,
	write('took your last breath'),nl,
	write('You Died - GAMEOVER'),nl,halt.
	
/***** LOOK COMMAND *****/
look :-                 % tanpa radar
    i_am_at(X,Y),
    describe(X,Y),
    nl,
    printLookMap,
    notice_objects_at(X,Y),
    notice_enemy_at(X,Y),
    nl.

notice_objects_at(X,Y) :-
    at(Item, X,Y),
    write('There is a '), write(Item), write(' here.'), nl,
    fail.

notice_objects_at(X,Y) :-
    alive(enemy,X,Y),
    write('There is an enemy here.'), nl,
    fail.

notice_objects_at(_).

printLookMap :-
    i_am_at(X,Y),
    XPlus is X+1, YPlus is Y+1,
    XMin is X-1, YMin is Y-1,
    % baris pertama
    printOneTile(XMin,YPlus), tab(1),
    printOneTile(X,YPlus), tab(1),
    printOneTile(XPlus,YPlus), nl,
    % baris kedua
    printOneTile(XMin,Y), tab(1),
    printOneTile(X,Y), tab(1),
    printOneTile(XPlus,Y), nl,
    % baris ketiga
    printOneTile(XMin,YMin), tab(1),
    printOneTile(X,YMin), tab(1),
    printOneTile(XPlus,YMin), nl, !.

/***** RADAR COMMAND *****/	
map :-
	playerInventory(L),
	searchInven('radar', L, yes),
	edgeY(MaxY),
    recPrintRadar(1,MaxY), !.	
	
map :-
	playerInventory(L),
	searchInven('radar', L, no),
    write('Get a radar first!'), !.

recPrintRadar(X,1) :-
	edgeX(X), !.
	
recPrintRadar(X,Y) :-
	\+edgeX(X),
	XPlus is X+1,
	printOneTile(X,Y), tab(1),
	recPrintRadar(XPlus,Y), !.
	
recPrintRadar(X,Y) :-
	edgeX(X),
	YPlus is Y-1,
	nl,
	recPrintRadar(1,YPlus).	
/**** END OF RADAR COMMAND *****/

printOneTile(X,Y) :-    % enemy
    alive(enemy,X,Y),
    write('E'), !.

printOneTile(X,Y) :-    % medicine
    at(medicine,X,Y),
    write('M'), !.

printOneTile(X,Y) :-    % food
    at(food,X,Y),
    write('F'), !.

printOneTile(X,Y) :-    % water
    at(water,X,Y),
    write('W'), !.

printOneTile(X,Y) :-    % weapon
    (at(knife,X,Y) ; at(arrow,X,Y)),
    write('W'), !.

printOneTile(X,Y) :-    % player
    i_am_at(X,Y),
    write('P'), !.

printOneTile(X,Y) :-
    edgeX(MaxX), edgeY(MaxY),	$ accessible
    X =< MaxX, Y =< MaxY,
    write('-'), !.

printOneTile(X,Y) :-		#inaccessible
    write('#').

/***** GAME INITIALIZATION *****/
start :-
    instructions,
    look.

describe(7,7) :-
    write('you\'re in the treasure spot!'), nl, !.

describe(_,_) :-
    write('you\'re near treasure spot!'), nl.

/***** ACTION *****/

/*** Taking an item ***/
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

/*** Dropping an item ***/
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

/** Attacking an enemy **/
attack :-
	i_am_at(X,Y),
    alive(enemy,X,Y),
    at(spear,in,hand),
    retract(alive(enemy,X,Y)),
    retract(player(Pts,Hgr,Thr)),
    NewPts is Pts - 9, % dmgnya diganti konstanta aja
    asserta(player(NewPts,Hgr,Thr)),
    write('You took 21 damage and the enemy died'),nl,
    write('Your health is '), write(NewPts),nl,
    finish.

attack :-
    i_am_at(X,Y),
    alive(enemy,X,Y),
    at(knife,in,hand),
    retract(alive(enemy,X,Y)),
    retract(player(Pts,Hgr,Thr)),
    NewPts is Pts - 21, % dmgnya diganti konstanta aja
    asserta(player(NewPts,Hgr,Thr)),
    write('You took 21 damage and the enemy died'),nl,
    write('Your health is '), write(NewPts),nl,
    finish.

attack :-
    i_am_at(X,Y),
    alive(enemy,X,Y),
    retract(player(Pts,Hgr,Thr)),
    NewPts is Pts-21, %dmgnya diganti konstanta aja
    asserta(player(NewPts,Hgr,Thr)),
    write('You can''t attack and took 21 damage'),nl,
    write('Your health is '),write(NewPts).

attack :-
    write('There is nothing to attack'),nl.

/***** INVENTORY *****/
/** Search in Inventory **/
searchInven(Item, [], Bool) :-
    Bool = no, !.

searchInven(Item, [H|T], Bool) :-
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

delFromInven(Item, [], NewInven) :-
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
    write('You have no item in your inventory.'), nl, !.

printInven([X]) :-
    write(X), !.

printInven([H|T]) :-
    write(X), nl,
    printInven(T).

finish :- 
        \+alive(_,_,_),write('The game ends'),nl,halt.
	

/* Command SAVE */
save(FileName) :-		# contoh perintah: save('filename.pl')
    tell(FileName),
    listing(at),
    listing(i_am_at),
    listing(alive),
    listing(player),
    listing(playerInventory),
    told.

/* Command LOAD */
loadlocal(FileName) :-		# contoh perintah: loadlocal(filename)
    [FileName].
