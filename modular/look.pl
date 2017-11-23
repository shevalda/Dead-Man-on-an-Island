/*** LOOK - Looking at nearby enviornment  ***/
notice(X,Y) :-
    notice_objects_at(X,Y),
    notice_enemy_at(X,Y).

look :-                 % tanpa radar
    i_am_at(X,Y),
    describe(X,Y),
    nl,
    printLookMap,
    notice_objects_at(X,Y),
    notice_enemy_at(X,Y).

notice_objects_at(X,Y) :-
    at(Item, X,Y),
    write('There is a '), write(Item), write(' here.'), nl,
    fail.

notice_objects_at(_,_).

notice_enemy_at(X,Y) :-
    alive(enemy,X,Y),
    write('There is an enemy here.'), nl,
    fail.

notice_enemy_at(_,_).

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