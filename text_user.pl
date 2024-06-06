:- module(text_user,[]).

greeting :- writeln('welcome to ranker').
accounts :- 
  writeln('you are registered in ex1@gmail.com account'),
  writeln('you are registered in ex2@gmail.com account').
directives :-
  writeln('choose the directive you wish to participate in'),
  writeln('1. choose the better name'),
  writeln('2. which idea is more important'),
  writeln('R. give series of random comparisons from all directives').
comparison :-
  writeln('which is the more import ant idea'),
  writeln('a. this idea'),
  writeln('b. or this idea').

:- greeting.
:- accounts.
:- directives.
:- comparison.
