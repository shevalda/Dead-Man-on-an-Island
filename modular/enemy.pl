/*** ENEMY ***/
randomEnemyMove :-
    alive(enemy,X,Y,RaftItem),
	edge([XMin,XMax],[YMin,YMax]),
    random(-1,2,Val),
	random(0,2,Dir),			% 0 untuk gerak ke atas/bawah, 1 untuk gerak ke kanan/kiri
    Xnew is X + Val*Dir, Ynew is Y + Val*abs((Dir-1)),
	Xnew >= XMin, Xnew =< XMax, Ynew >= YMin, Ynew =< YMax,
    retract(alive(enemy,X,Y,RaftItem)),
    asserta(alive(enemy,Xnew,Ynew,RaftItem)),
	i_am_at(Xnew,Ynew),
	enemyAttack,
    fail.
	
enemyAttack :-
    retract(player(Pts,Hgr,Thr)),
    NewPts is Pts-10, % dmgnya diganti konstanta aja
    asserta(player(NewPts,Hgr,Thr)),
    write('There is an enemy here. '),
    write('You were attacked and took 10 damage'),nl,
	playerchk, !.
