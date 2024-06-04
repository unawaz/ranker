:- module(ranker,[]).
:- use_module(elo).

update(X,Y) :- retract(X),assert(Y).
insert(X) :- assert(X).
empty(X) :- retractall(X).
remove(X) :- retract(X).
exists(X) :- X.
not_exists(X) :- not(exists(X)).

:- dynamic account/1.
:- dynamic user/2.
:- dynamic granted_directives/2.
:- dynamic granted_items/2.
:- dynamic directive/3.
:- dynamic item/3.
:- dynamic item_directive/4.
:- dynamic pay/2.

register_account(Email) :- insert(account(Email)).
register_user(Email,Account) :- insert(user(Email,Account)).
pay(Account) :- get_time(T),insert(pay(Account,T)).
payed_ago(Account,Seconds) :-
  get_time(T),pay(Account,O),Seconds is T - O.
payed_valid(Account,MaximumSeconds) :-
  payed_ago(Account,Duration),Duration < MaximumSeconds.

account_exists(X) :- account(X).
user_exists(User,Account) :- user(User,Account).

grant_directives(User,Account) :- 
  insert(granted_directives(User,Account)).
ungrant_directives(User,Account) :-
  remove(granted_directives(User,Account)).

grant_items(User,Account) :- insert(grant_items(User,Account)).
ungrant_items(User,Account) :- remove(grant_items(User,Account)).

create_directive(User,Account,Directive) :-
  insert(directive(User,Account,Directive)).
pause_directive(User,Account,Directive) :-
  insert(pause_directive(User,Account,Directive)).
unpause_directive(User,Account,Directive) :-
  remove(pause_directive(User,Account,Directive)).
delete_directive(User,Account,Directive) :-
  remove(directive(User,Account,Directive)).

create_item(User,Account,Item) :- insert(item(User,Account,Item)).
pause_item(User,Account,Item) :- insert(pause_item(User,Account,Item)).
unpause_item(User,Account,Item) :- remove(pause_item(User,Account,Item)).
delete_item(User,Account,Item) :- remove(item(User,Account,Item)).

add_item(U,A,I,D) :- insert(item_directive(U,A,I,D)).
remove_item(U,A,I,D) :- remove(item_directive(U,A,I,D)).

get_choice(U,A,D,X,Y) :-
  findall(I,item_directive(U,A,I,D),L),
  random_member(X,L),random_member(Y,L).
choose(U,A,D,Chosen,Other) :-
  insert(choose(U,A,D,Chosen,Other)).
unsure(U,A,D,X,Y) :-
  insert(unsure(U,A,D,X,Y)).

accounts(L) :- findall(X,account(X),L).
users(L) :- findall(X-Y,user(X,Y),L).
granted_directives(A,L) :- findall(U,grant_directives(U,A),L).
granted_items(A,L) :- findall(U,grant_items(U,A),L).
directives(A,L) :- findall(D,directive(_,A,D),L).
items(A,L) :- findall(I,item(_,A,I),L).

random_email(X) :- uuid(I),string_concat(I,'@gmail.com',X).
register_random_account :- random_email(X),register_account(X).
random_account(R) :- findall(X,account(X),L),random_member(R,L).
register_random_user :-
  random_account(A),random_email(U),register_user(U,A).
random_user(A,R) :- findall(U,user(U,A),L),random_member(R,L).
restart :- 
  empty(account(_)),
  empty(user(_,_)),
  empty(granted_directives(_,_)),
  empty(granted_items(_,_)),
  empty(directive(_,_,_)),
  empty(item(_,_,_)),
  empty(item_directive(_,_,_,_)),
  empty(pay(_,_)).

test :-restart,
  register_random_account,
  register_random_account,
  register_random_user,
  accounts(A),users(U),
  grant_directives(U,A),
  granted_directives(A,GD),
  writeln(accounts-A-users-U),
  writeln(granted_directives-GD).

%register_admin(Email) :- admin(Email),fail;assert(admin(Email)).
%register_user(Admin,Email) :- 
%  user(Email,Admin),fail;assert(user(Email,Admin)).
%pay(Admin) :- payed(Admin),fail;assert(payed(Admin)).
%deactivate_user(User,Admin) :- 
%  deactivated(User,Admin),fail;assert(deactivated(User,Admin)).
%reactivate_user(User,Admin) :- retract(deactivate(User,Admin));fail.
%allow_lists(User,Admin) :- 
%  lists(User,Admin),fail;assert(lists(User,Admin)).
%disallow_lists(User,Admin) :- retract(lists(User,Admin));fail.
%allow_items(User,Admin) :-
%  items(User,Admin),fail;assert(items(User,Admin)).
%disallow_items(User,Admin) :- retract(items(User,Admin));fail.
%create_list(User,Admin,Directive) :-
%  list(Directive,User,Admin),fail;
%  lists(User,Admin),assert(list(Directive,User,Admin)).
%create_item(User,Admin,List,Text) :-
%  list(Text,List,User,Admin),fail;
%  items(User,Admin),assert(Text,List,User,Admin).
%
%choose(Winner,Loser,List,User,Admin) :-
%  assert(won(Winner,Loser,List,User,Admin)),
%  elo(Winner,W,List,Admin),
%  elo(Loser,L,List,Admin),
%  calculate_elo(W,L,WW,LL),
%  update(elo(Winner,W),elo(Winner,WW)),
%  update(elo(Loser,L),elo(Loser,LL)).
%
% calculate_elo(Winner,Loser,WinnerNew,LoserNew).

