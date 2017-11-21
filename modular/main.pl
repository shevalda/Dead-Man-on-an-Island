:- dynamic(at/3, i_am_at/2, alive/3, player/3, playerInventory/1).

/*** IMPORTING OTHER FILES ***/
:- include(attack).
:- include(drop).
:- include(inventory).
:- include(look).
:- include(map).
:- include(move).
:- include(saveload).
:- include(start).
:- include(take).
:- include(use).

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

/** For printing LOOK's map and MAP **/
printOneTile(X,Y) :-        % enemy E
    alive(enemy,X,Y),
    write('E'), !.

printOneTile(X,Y) :-        % medicine M
    at(medicine,X,Y),
    write('M'), !.

printOneTile(X,Y) :-        % food F
    at(food,X,Y),
    write('F'), !.

printOneTile(X,Y) :-        % water W
    at(water,X,Y),
    write('W'), !.

printOneTile(X,Y) :-        % weapon #
    (at(knife,X,Y) ; at(arrow,X,Y)),
    write('#'), !.

printOneTile(X,Y) :-        % player
    i_am_at(X,Y),
    write('P'), !.

printOneTile(X,Y) :-	    % accessible
	edge([XMin,XMax],[YMin,YMax]),
    X >=XMin, X=<XMax, Y>=YMin, Y=<YMax,
    write('-'), !.

printOneTile(X,Y) :-		% inaccessible
    write('#').

/** Describe for START and LOOK **/
describe(X,Y) :-
    forestLoc([XStart,YStart],[XEnd,YEnd]),
    X>=XStart, X=<XEnd,
    Y>=YStart, Y=<YEnd, 
    write('You \'re in the forest!'), nl, !.

describe(_,_) :-
    write('You\'re on an open field!'), nl.

/***** PLAYER'S ALIVE/DEATH STATE *****/
/* check alive */
playerchk :- player(Ht,Hg,Th),
	Ht < 0,Hg < 0, Th < 0, !, die.

/* Game over */
die :- 
	write('Your vision slowly fade while you'),nl,
	write('took your last breath'),nl,
	write('You Died - GAMEOVER'), nl, halt.

/***** NOT SURE hehe *****/
finish :- 
        \+alive(_,_,_), write('The game ends'), nl, halt.

/***** ENEMY *****/
randomEnemy :-
    alive(enemy,X,Y),
    random(-1,1,Dx),random(-1,1,Dy),
    retract(alive(enemy,X,Y)),
    Xnew is X + Dx, Ynew is Y + Dy,
    asserta(alive(enemy,Xnew,Ynew)),
    fail.
