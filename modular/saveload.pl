/*** SAVE - Saving game to a chosen file name ***/
save_game(_) :-
    checkStart(0),
    write('You have not started the game.'), !.

save_game(FileName) :-
    open(FileName, write, Stream),
    \+ loop_write(Stream),
    close(Stream),
    format('Your game has been saved to ~a', [FileName]), nl.

loop_write(Stream) :-
    at(I,X,Y),
    write(Stream, at(I,X,Y)), write(Stream,'.'),
    nl(Stream),
    fail.

loop_write(Stream) :-
    i_am_at(X,Y),
    write(Stream, i_am_at(X,Y)), write(Stream,'.'),
    nl(Stream),
    fail.

loop_write(Stream) :-
    alive(E,X,Y,I),
    write(Stream, alive(E,X,Y,I)), write(Stream,'.'),
    nl(Stream),
    fail.

loop_write(Stream) :-
    player(HP,Hgr,Thr),
    write(Stream, player(HP,Hgr,Thr)), write(Stream,'.'),
    nl(Stream),
    fail.

loop_write(Stream) :-
    playerInventory(L),
    write(Stream, playerInventory(L)), write(Stream,'.'),
    nl(Stream),
    fail.

loop_write(Stream) :-
    playerWeapon(W),
    write(Stream, playerWeapon(W)), write(Stream,'.'),
    nl(Stream),
    fail.

/*** LOADLOCAL - Loading game state from a chosen file ***/
load_game(_) :-
    checkStart(1),
    write('The game has started. Quit first to load previous game.').

load_game(FileName) :-
    load_internal(FileName),
    format('Your game from ~a has been loaded.', [FileName]), nl.

load_internal(FileName) :-
    retractall(at(I,X,Y)),
    retract(i_am_at(X,Y)),
    open(FileName, read, Stream),
    readfile(Stream, What),
    close(Stream).

readfile(Stream, []) :-
    at_end_of_stream(Stream), !.

readfile(Stream, [H|T]) :-
    \+ at_end_of_stream(Stream), !,
    read(Stream, H),
    asserta(H),
    readfile(Stream, T).