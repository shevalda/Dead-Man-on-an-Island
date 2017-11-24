:- dynamic at/3.

at(radar, 6, 8).
at(spear, 6, 13).
at(sarden, 5, 7).
at(kornet, 7, 3).
at(yogurt, 9, 5).
at(kornet, 12, 7).
at(nasgor, 5, 13).
at(popmie, 3, 9).
at(popmie, 13, 4).
at(nasgor, 10, 9).
at(sprite, 5, 4).
at(sprite, 10, 3).
at(water, 11, 6).
at(water, 11, 11).
at(water, 5, 9).
at(water, 3, 11).
at(betadine, 7, 4).
at(diapet, 9, 4).

:- dynamic i_am_at/2.

i_am_at(3, 6).

:- dynamic alive/4.

alive(enemy, 2, 13, 'chopped wood').
alive(enemy, 6, 10, rope).
alive(enemy, 11, 11, compass).
alive(enemy, 12, 9, 'used paddle').
alive(enemy, 2, 6, 'first aid kit').
alive(enemy, 11, 6, 'torch light').
alive(enemy, 12, 8, whistle).
alive(enemy, 10, 7, flares).
alive(enemy, 7, 3, suncream).
alive(enemy, 9, 2, bagpack).
alive(enemy, 12, 6, 'extra clothes').

:- dynamic player/3.

player(100, 76, 76).

:- dynamic playerInventory/1.

playerInventory([panadol]).

:- dynamic playerWeapon/1.

playerWeapon(knife).

