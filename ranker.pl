:- dynamic admin/1.

update(X,Y) :- retract(X),assert(Y).

register_admin(Email) :- admin(Email),fail;assert(admin(Email)).
register_user(Admin,Email) :- 
  user(Email,Admin),fail;assert(user(Email,Admin)).
pay(Admin) :- payed(Admin),fail;assert(payed(Admin)).
deactivate_user(User,Admin) :- 
  deactivated(User,Admin),fail;assert(deactivated(User,Admin)).
reactivate_user(User,Admin) :- retract(deactivate(User,Admin));fail.
allow_lists(User,Admin) :- 
  lists(User,Admin),fail;assert(lists(User,Admin)).
disallow_lists(User,Admin) :- retract(lists(User,Admin));fail.
allow_items(User,Admin) :-
  items(User,Admin),fail;assert(items(User,Admin)).
disallow_items(User,Admin) :- retract(items(User,Admin));fail.
create_list(User,Admin,Directive) :-
  list(Directive,User,Admin),fail;
  lists(User,Admin),assert(list(Directive,User,Admin)).
create_item(User,Admin,List,Text) :-
  list(Text,List,User,Admin),fail;
  items(User,Admin),assert(Text,List,User,Admin).

choose(Winner,Loser,List,User,Admin) :-
  assert(won(Winner,Loser,List,User,Admin)),
  elo(Winner,W,List,Admin),
  elo(Loser,L,List,Admin),
  calculate_elo(W,L,WW,LL),
  update(elo(Winner,W),elo(Winner,WW)),
  update(elo(Loser,L),elo(Loser,LL)).

% calculate_elo(Winner,Loser,WinnerNew,LoserNew).

:- halt.
