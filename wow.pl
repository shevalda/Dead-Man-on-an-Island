:- dynamic(at/3, i_am_at/2, alive/3, player/3, playerInventory/1).

/* player's current position
   initial position : (3,4) */
i_am_at(3,4).

/* map size */
edge([1,14],[1,14]).
edgeOffset([X1,X2],[Y1,Y2]) :- 
	edge([XEdge1,XEdge2],[YEdge1,YEdge2]),
	X1 is XEdge1-2, X2 is XEdge2+2,
	Y1 is YEdge1-2, Y2 is YEdge2+2.

/* terrain location */
forestLoc([3,6],[6,13]).
forestLoc([3,3],[4,7]).
forestLoc([3,9],[13,12]).

/* Player's stats
   Initial stats:
        Health = 100
        Hunger = 100
        Thrist = 100 */
player(100,100,100).


at(radar,6,8).
at(knife,3,3).
at(spear,6,13).

/*expired foods -health +hunger*/
at(sarden,5,7). %expired
at(kornet,7,3). %expired
at(yogurt,9,5). %expired
at(kornet,12,7).

/*healthy foods +health ++hunger*/
at(nasgor,5,13).
at(popmie,3,9).
at(popmie,13,4).
at(nasgor,10,9).

/*dirty water -health +thirst*/
at(coca_cola,5,4).
at(coca_cola,10,3).

/*clean water +thirst*/
at(water,11,6).
at(water,11,11).
at(water,5,9).
at(water,3,11).

expired(sarden).
expired(kornet).
expired(yogurt).
expired(coca_cola).

food(nasgor).
food(popmie).
food(sarden).
food(kornet).
food(yogurt).

drink(water).
drink(coca_cola).

weapon(spear).
weapon(knife).

alive(enemy,3,13).
alive(enemy,5,11).
alive(enemy,8,12).
alive(enemy,13,9).
alive(enemy,3,8).
alive(enemy,10,7).
alive(enemy,12,7).
alive(enemy,12,6).
alive(enemy,7,4).
alive(enemy,9,4).
alive(enemy,13,3).

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
    ,randomEnemy,playerchk.

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
	edgeOffset([XMin,_],[_,YMax]),
    recPrintRadar(XMin,YMax), !.	
	
map :-
	playerInventory(L),
	searchInven('radar', L, no),
    write('Get a radar first!'), !.

recPrintRadar(X,Y) :-
	edgeOffset([_,X],[Y,_]),
	printOneTile(X,Y), tab(1), !.
	
recPrintRadar(X,Y) :-
	\+edgeOffset([_,X],_),
	XPlus is X+1,
	printOneTile(X,Y), tab(1),
	recPrintRadar(XPlus,Y), !.
	
recPrintRadar(X,Y) :-
	edgeOffset([_,X],_),
	edgeOffset([XMin,_],_),
	YMin is Y-1,
	printOneTile(X,Y), tab(1),
	nl,
	recPrintRadar(XMin,YMin).	
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

printOneTile(X,Y) :-	%accessible
	edge([XMin,XMax],[YMin,YMax]),
    X >=XMin, X=<XMax, Y>=YMin, Y=<YMax,
    write('-'), !.

printOneTile(X,Y) :-		%inaccessible
    write('#').

/***** GAME INITIALIZATION *****/
start :-
    instructions,
    look.

describe(X,Y) :-
    forestLoc([XStart,YStart],[XEnd,YEnd]),
    X>=XStart, X=<XEnd,
    Y>=YStart, Y=<YEnd, 
    write('You \'re in the forest!'), nl, !.

describe(_,_) :-
    write('You\'re on an open field!'), nl.

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

randomEnemy :-
    alive(enemy,X,Y),
    random(-1,1,Dx),random(-1,1,Dy),
    retract(alive(enemy,X,Y)),
    Xnew is X + Dx, Ynew is Y + Dy,
    asserta(alive(enemy,Xnew,Ynew)),
    fail.

/* Command SAVE */
save(FileName) :-		% contoh perintah: save('filename.pl')
    tell(FileName),
    listing(at),
    listing(i_am_at),
    listing(alive),
    listing(player),
    listing(playerInventory),
    told.

/* Command LOAD */
loadlocal(FileName) :-		% contoh perintah: loadlocal(filename)
    [FileName].

start :-
    instructions,nl,
    help,nl,nl,
	i_am_at(X,Y),
	describe(X,Y).

instructions:- 
				write(' __                       _       _                                 _'),nl,
 				write('|  |                  _  | |     | |                 ___           | |                            _'),nl,
 				write('|   |  ___  _____  __| | |  |   |  | _____  _____   |   |   _____  | | ____  _  _____  _____  ___| |'),nl,
 				write('| |) || _ |(  _  |(  _ | | | |_| | |(  _  ||  _  | |  _  | |  _  | | |/  __|| |(  _  ||  _  |(  _  |'),nl,
 				write('| |) | ___|| (_| |( (_|| | |  _  | || (_| || | | | | |_| | | | | | | | __   | || (_| || | | |( (_| |'),nl,
 				write('|   | |___|(_____|(__,_| | |     | |(_____||_| |_| |     | |_| |_| | ||____/|_|(_____||_| |_|(___,_|'),nl,
 				write('|__|                     |_|     |_|                |___|          |_|                '),nl,
 				write('Welcome to Dead Man on an Island!'),nl,
 				write('This is an adventure game, writen in prolog programming languange.'),nl,
 				write('The purpose of this game is to find the parts needed to escape the island.').


help :- 
		write('Enter commands using standard prolog syntax.'),nl,
		write('Available commands are '),nl,
		write(' start.                      : to start a game'),nl,
		write(' help.                       : to see game commands'),nl,
		write(' quit.                       : to end the game'),nl,
		write(' look.                       : to describe and print the position of the player'),nl,
		write(' n., s. , w. , e.            : to move the player based on wind direction'),nl,
		write(' map.                        : to print map of the game and show the location of enemies. You must have radar item before using this command'),nl,
		write(' take(object).               : to take an object and put into inventory'),nl,
		write(' drop(object).               : to drop an item in one square'),nl,
		write(' use(object).                : to use an item in inventory'),nl,
		write(' attack.                     : to attack  an enemy in same square'),nl,
		write(' status.                     : to show the player status(health, hunger, thirst, weapon)'),nl,
		write(' save(''filename.pl'').        : to save a game'),nl,
		write(' load(filename).             : to load saved game').
