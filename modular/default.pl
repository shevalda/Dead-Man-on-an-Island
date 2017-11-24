
% Lokasi item di map

at(radar, 6, 8).
at(knife, 3, 3).
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
at(panadol, 3, 8).
at(betadine, 7, 4).
at(diapet, 9, 4).

% Lokasi START player

i_am_at(3, 4).

% List enemy

alive(enemy, 3, 13, 'chopped wood').
alive(enemy, 5, 11, rope).
alive(enemy, 8, 12, compass).
alive(enemy, 13, 9, 'used paddle').
alive(enemy, 3, 8, 'first aid kit').
alive(enemy, 10, 7, 'torch light').
alive(enemy, 12, 7, whistle).
alive(enemy, 12, 6, flares).
alive(enemy, 7, 4, suncream).
alive(enemy, 9, 4, bagpack).
alive(enemy, 13, 3, 'extra clothes').

% Stats player

player(100, 100, 100).

% List inventory default player

playerInventory([]).

% Weapon default player

playerWeapon(none).
