:- module(account,[]).

:- dynamic user/1.
:- dynamic paused/1.
:- dynamic granted_directives/1.
:- dynamic granted_items/1.
:- dynamic paused_directive/1.
:- dynamic directive/1.

add_user(ID) :- assert(user(ID)).

pause_user(ID) :- assert(paused(ID)).
unpause_user(ID) :- retract(paused(ID)).

grant_directives(UserID) :- assert(granted_directives(UserID)).
ungrant_directives(UserID) :- retract(granted_directives(UserID)).

grant_items(UserID) :- assert(granted_items(UserID)).
ungrant_items(UserID) :- retract(granted_items(UserID)).

add_directive(ID) :- assert(directive(ID)).
pause_directive(ID) :- assert(paused_directive(ID)).
unpause_directive(ID) :- retract(paused_directive(ID)).

