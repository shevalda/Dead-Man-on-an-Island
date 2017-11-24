/*** SAVE - Saving game to a chosen file name ***/
save_game(_) :-
    checkStart(0),
    write('You have not started the game.'), !.

save_game(FileName) :-		% contoh perintah: save_game('filename.pl')
    tell(FileName),
    listing(at),
    listing(i_am_at),
    listing(alive),
    listing(player),
    listing(playerInventory),
    listing(playerWeapon),
    told,
    write('Your gameplay has been saved to '), write(FileName), write('.').

/*** LOADLOCAL - Loading game state from a chosen file ***/
load_game(_) :-
    checkStart(1),
    write('The game has started. Quit first to load previous game.').

load_game(FileName) :-		% contoh perintah: load_game(filename)
    % retract semua fakta
    retractall(at(_, _, _)),
    retractall(i_am_at(_,_)),
    retract(player(_,_,_)),
    retractall(alive(_,_,_,_)),
    [FileName], nl,
    write('Your gameplay from '), write(FileName), write('.pl has been loaded.').
