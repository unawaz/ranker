:- module(ranker_test,[test/2]).
:- use_module(ranker).

test(G,M) :- ranker:restart,
  (G,write('passed '),writeln(M);write('failed '),writeln(M)).

gmail(X,O) :- string_concat(X,'@gmail.com',O).

:- test(gmail('nawaz.umar','nawaz.umar@gmail.com'),'gmail').

:- test((
    gmail(umar,Email),
    ranker:register_account(Email),
    ranker:account_exists(Email)
  ),'account registers').

:- test((
    gmail(umar,Account),
    gmail(nawaz,User),
    ranker:register_user(User,Account),
    ranker:user_exists(User,Account)
  ),'user registers').

user(User,Account) :- gmail(umar,Account),gmail(umar,User).

:- test((
    user(User,Account),
    ranker:grant_directives(User,Account),
    ranker:granted_directives(User,Account)
  ),'directives granted').

:- test((
    user(User,Account),
    ranker:grant_items(User,Account),
    ranker:granted_items(User,Account)
  ),'items granted').

:- test((
  ),'directive added').

:- test((
  ),'item added').

:- test((
  ),'directives ungranted').

:- test((
  ),'items ungranted').

:- test((
  ),'item added to directive').

:- test((
  ),'create testing function of randomly generated items').

:- test((
  ),'create testing function of randomly generated directives').

:- test((
  ),'create testing function of randomly genearated users').


:- ranker:users(L),writeln(L).

:- halt.
