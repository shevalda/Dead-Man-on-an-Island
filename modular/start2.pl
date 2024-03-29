:- dynamic started/1.

inst(start).
inst(help).
inst(look).
inst(n).
inst(s).
inst(w).
inst(e).
inst(map).
inst(take/1).
inst(drop/1).
inst(use/1).
inst(attack).
inst(status).
inst(save_game).

/*** START - Initializing game ***/
start :-
	write('You have started the game. type quit to end the game.'),nl,
	starting,
	repeat,
	read(X),
	user_in(X),
	nl,X = quit.

user_in(X) :-
	\+inst(X),
	write('incorrect command').

user_in(X) :-
	inst(X),X.

starting :-
	retract(started(_)),
	assert(started(1)),
    instructions,nl,
    help,nl,nl,
	i_am_at(X,Y),
	describe(X,Y), tab(1),
	movedesc(X,Y).

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
		write(' take(object).               : to take an object'),nl,
		write(' drop(object).               : to drop an item'),nl,
		write(' use(object).                : to use an item in inventory'),nl,
		write(' attack.                     : to attack  an enemy in same square'),nl,
		write(' status.                     : to show the player status(health, hunger, thirst, weapon)'),nl,
		write(' save_game(''filename.pl'').   : to save a game'),nl,
		write(' load_game(filename).        : to load saved game'),
		nl,nl,
		write('Legends:'), nl,
        write('Player   : P'), nl,
		write('Enemy    : E'), nl,
        write('Medicine : M'), nl,
        write('Food     : F'), nl,
        write('Water    : D'), nl,
        write('Weapon   : W'), nl,
        write('Land     : -'), nl,
        write('Sea      : X').