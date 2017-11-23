:- dynamic(at/3, i_am_at/2, alive/4, player/3, playerInventory/1, playerWeapon/1, checkStart/1).

/*** IMPORTING OTHER FILES ***/
:- include(attack).
:- include(drop).
:- include(enemy).
:- include(inventory).
:- include(look).
:- include(map).
:- include(move).
:- include(saveload).
:- include(start).
:- include(status).
:- include(take).
:- include(use).

/* Check the game has started or not */
checkStart(0).

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
        Thrist = 100
        Weapon = none */
player(100,100,100).
playerWeapon(none).

/* SPECIAL ITEMS */
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
at(sprite,5,4).
at(sprite,10,3).

/*clean water +thirst*/
at(water,11,6).
at(water,11,11).
at(water,5,9).
at(water,3,11).

/* medicine */
at(panadol,3,8).
at(betadine,7,4).
at(diapet,9,4).

expired(sarden).
expired(kornet).
expired(yogurt).
expired(sprite).

food(nasgor).
food(popmie).
food(sarden).
food(kornet).
food(yogurt).

drink(water).
drink(coca_cola).

medicine(panadol).
medicine(betadine).
medicine(diapet).

weapon(spear).
weapon(knife).

alive(enemy,3,13,'chopped wood').
alive(enemy,5,11, 'rope').
alive(enemy,8,12, 'compass').
alive(enemy,13,9, 'used paddle').
alive(enemy,3,8, 'first aid kit').
alive(enemy,10,7, 'torch light').
alive(enemy,12,7, 'whistle').
alive(enemy,12,6, 'flares').
alive(enemy,7,4, 'suncream').
alive(enemy,9,4, 'bagpack').
alive(enemy,13,3, 'extra clothes').

/* Player's list of inventory */
playerInventory([]).

/** For printing LOOK's map and MAP **/
printOneTile(X,Y) :-    % enemy
    alive(enemy,X,Y,RaftItem),
    write('E'), !.

printOneTile(X,Y) :-    % medicine
    at(Item,X,Y),
    medicine(Item),
    write('M'), !.

printOneTile(X,Y) :-    % food
    at(Item,X,Y),
    food(Item),
    write('F'), !.

printOneTile(X,Y) :-    % water
    at(Item,X,Y),
    drink(Item),
    write('D'), !.

printOneTile(X,Y) :-    % weapon
    (at(knife,X,Y) ; at(spear,X,Y)),
    write('W'), !.

printOneTile(X,Y) :-    % player
    i_am_at(X,Y),
    write('P'), !.

printOneTile(X,Y) :-	%accessible
	edge([XMin,XMax],[YMin,YMax]),
    X >=XMin, X=<XMax, Y>=YMin, Y=<YMax,
    write('-'), !.

printOneTile(X,Y) :-	%inaccessible
    write('X').

/** Describe for START and LOOK **/
describe(X,Y) :-
    forestLoc([XStart,YStart],[XEnd,YEnd]),
    X>=XStart, X=<XEnd,
    Y>=YStart, Y=<YEnd, 
    write('You\'re in the highland.'), !.

describe(X,Y) :-
    write('You\'re in the lowland.').
    
descmov(X,Y) :-
    forestLoc([XStart,YStart],[XEnd,YEnd]),
    X>=XStart, X=<XEnd,
    Y>=YStart, Y=<YEnd, 
    write('a highland area'), !.

descmov(X,Y) :-
    X >= 1, X =< 14,
    Y >= 1, Y =< 15,
    write('a lowland area'), !.

descmov(_,_) :-
    write('the sea').

movedesc(X,Y) :-
    Yn is Y+1,
    Ym is Y-1,
    Xn is X+1,
    Xm is X-1,
    write('To the north is '),descmov(X,Yn),
    write(', to the east is '),descmov(Xn,Y),
    write(', to the south is '),descmov(X,Ym),
    write(', to the west is '),descmov(Xm,Y), write('.').

/***** PLAYER'S ALIVE/DEATH STATE *****/
/* check alive */
playerchk :- player(Ht,Hg,Th),
	Ht =< 0, die, !.

playerchk :- player(Ht,Hg,Th),
	Hg =< 0, die, !.

playerchk :- player(Ht,Hg,Th),
	Th =< 0, die, !.

playerchk :-
    \+ alive(enemy,_,_,_),
    win, !.

/* Game over */
die :- 
	write('Your vision slowly fade while you'),nl,
	write('took your last breath'),nl,
	write('You Died - GAME OVER'), nl,
    retract(checkStart(1)),
    asserta(checkStart(0)).

/***** Player wins *****/
win :- 
    nl,
    write('You have finally gather the last part for the raft.'), nl,
    write('The thought of finally coming home makes you smile.'),
    nl,nl,
    write('After two days of endless struggle to build the raft, it is finally done.'), nl,
    write('You hop to raft and looked one more to time to the island you might never see again.'), nl, nl,
    write('THE END'),
    retract(checkStart(1)),
    asserta(checkStart(0)).

/* QUIT */
quit :-
    checkStart(1),
    retract(checkStart(1)),
    asserta(checkStart(0)),
    write('You have quitted the game.'), !.

quit :-
    write('You have not started the game.').