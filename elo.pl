k(32).
fraction(400).
result(win,1).
result(draw,0.5).
result(lose,0).
delta(Result,Arating,Brating,Delta) :-
  fraction(Fraction),
  k(K),
  result(Result,ResultValue),
  Difference is Brating - Arating,
  Fractioned is Difference / Fraction,
  Scaled is 10 ** Fractioned,
  AboveOne is Scaled + 1,
  Expected is 1 / AboveOne,
  Reality is ResultValue - Expected,
  Adjusted is K * Reality,
  Rounded is round(Adjusted),
  Delta = Rounded.
score(A,B,Result,Score) :-
  delta(Result,A,B,Delta),
  Score is A + Delta.
win(A,B,NewA) :- score(A,B,win,NewA).
lose(A,B,NewA) :- score(A,B,lose,NewA).
draw(A,B,NewA) :- score(A,B,draw,NewA).

scores(Winner,Loser,NewWinner,NewLoser) :-
  win(Winner,Loser,NewWinner),
  lose(Loser,Winner,NewLoser).
scores_drawn(A,B,NewA,NewB) :-
  draw(A,B,NewA),draw(B,A,NewB).

test_pass(X,Y,M) :- X == Y,writeln(M-passed);writeln(M-failed).
test :- 
  A = 1600,B = 1700,
  win(A,B,Win),test_pass(Win,1620,win),
  draw(A,B,Draw),test_pass(Draw,1604,draw),
  lose(A,B,Lose),test_pass(Lose,1588,lose).
