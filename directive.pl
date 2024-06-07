:- module(directive,[]).

:- dynamic created/1.
:- dynamic id/1.
:- dynamic account/1.
:- dynamic creator/1.
:- dynamic text/1.
:- dynamic admin_access/1.
:- dynamic item_text/2.
:- dynamic item_user/2.
:- dynamic item_time/2.
:- dynamic compared/6.

create(Account,User,Text) :-
  get_time(Time),assert(created(Time)),
  uuid(ID),assert(id(ID)),
  assert(account(Account)),
  assert(creator(User)),
  assert(text(Text)).

grant_admin_access(User) :- assert(admin_access(User)).
ungrant_admin_access(User) :- retract(admin_access(User)).

change_directive_text(Text) :- retract(text(_)),assert(text(Text)).

add_item(Text,User) :-
  uuid(ID),get_time(Time),
  assert(item_time(ID,Time)),
  assert(item_text(ID,Text)),
  assert(item_user(ID,User)).

change_item_text(ID,Text) :-
  retract(item_text(ID,_)),
  assert(item_text(ID,Text)).

add_comparison(User,DirectiveID,WonID,LostID) :-
  get_time(Time),uuid(ID),
  assert(compared(ID,Time,User,DirectiveID,WonID,LostID)).

get_random_pair(ID1,ID2,Text1,Text2) :-
  setof(ID-Text,item_text(ID,Text),Items),
  random_member(ID1-Text1,Items),
  random_member(ID2-Text2,Items).
