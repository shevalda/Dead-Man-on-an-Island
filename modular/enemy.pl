/*** ENEMY ***/
randomEnemyMove :-
    alive(enemy,X,Y,RaftItem),
	\+enemyAttack(X,Y),		%jika musuh menyerang, maka tidak akan bergerak, dan sebaliknya
	enemyMove(X,Y,RaftItem),
    fail.
	
enemyAttack(X,Y) :-
	i_am_at(XP,YP),
	X=:=XP, Y=:=YP,
	weaponDamageTaken(none,Dmg),
    retract(player(Pts,Hgr,Thr)),
    NewPts is Pts-Dmg,
    asserta(player(NewPts,Hgr,Thr)),
    write('You were attacked and took '), write(Dmg), write(' damage'),nl,
	playerchk, !.
	
enemyMove(X,Y,RaftItem) :-
	i_am_at(XP,_),
	X=\=XP,
	edge([XMin,XMax],[YMin,YMax]),
    random(-1,2,Val),
	random(0,2,Dir),			% 0 untuk gerak ke atas/bawah, 1 untuk gerak ke kanan/kiri
    Xnew is (X + (Val*Dir)), Ynew is (Y + (Val*abs((Dir-1)))),
	Xnew >= XMin, Xnew =< XMax, Ynew >= YMin, Ynew =< YMax,
    retract(alive(enemy,X,Y,RaftItem)),
    asserta(alive(enemy,Xnew,Ynew,RaftItem)), !.
		
enemyMove(X,Y,RaftItem) :-
	i_am_at(_,YP),
	Y=\=YP,
	edge([XMin,XMax],[YMin,YMax]),
    random(-1,2,Val),
	random(0,2,Dir),			% 0 untuk gerak ke atas/bawah, 1 untuk gerak ke kanan/kiri
    Xnew is (X + (Val*Dir)), Ynew is (Y + (Val*abs((Dir-1)))),
	Xnew >= XMin, Xnew =< XMax, Ynew >= YMin, Ynew =< YMax,
    retract(alive(enemy,X,Y,RaftItem)),
    asserta(alive(enemy,Xnew,Ynew,RaftItem)), !.
