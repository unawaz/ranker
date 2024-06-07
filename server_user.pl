:- module(server_user,[]).

:- dynamic id/1.
:- dynamic created/1.
:- dynamic paused/0.

set_id(ID) :- 
  not(id(_)),not(created(_)),
  assert(id(ID)),get_time(Time),assert(created(Time)).

add_compared(DirectiveID,WonID,LostID) :-
  assert(compared(DirectiveID,WonID,LostID)).

pause :- assert(paused).
unpause :- retract(paused).


