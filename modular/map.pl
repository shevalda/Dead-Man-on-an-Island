/*** MAP - Printing map with radar ***/	
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
