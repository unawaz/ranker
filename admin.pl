:- module(admin,[]).

:- dynamic account_email/2.
:- dynamic paused/1.
:- dynamic system_paused/0.
:- dynamic unsubscribed/1.

% account is uuid because passing accounts between email holders
% should be allowed
transfer_account(OldEmail,NewEmail) :-
  account_email(OldEmail,Account),
  retract(account_email(OldEmail,Account)),
  assert(account_email(NewEmail,Account)).

% pause/unpause an account arbitrary reason 
pause(Account) :- assert(pause(Account)).
unpause(Account) :- retract(pause(Account)).

% register account when a new user wishes to form account
register_accounbt(Email) :-
  uuid(ID),assert(account_email(ID,Email)).

% pause/unpause whole system 
pause :- assert(system_paused).
unpause :- retract(system_paused).

% when an account wishes to no longer pay
unsubscribed_account(Account) :- assert(unsubscribed(Account)).
resubscribe_account(Account) :- retract(unsubscribed(Account)).

% add/withdraw funds, pay for the month, check if payed for this month
account_add_funds(Account,Amount) :-
  balance(Account,Old),
  New is Amount + Old,
  retract(balance(Account,Old)),
  assert(balance(Account,New)).
account_withdraw_funds(Account,Amount) :-
  Less is -1 * Amount,
  account_add_fund(Account,Less).

now_is_valid(Account) :-
  pay(Account,Pay),month(Month),get_time(Now),
  Next is Pay + Month,Now < Next.
account_pay(Account) :- now_is_valid(Account).
account_pay(Account) :- 
  retract(pay(Account,_)),
  get_time(Time),assert(pay(Account,Time)).
account_pay(Account) :- get_time(Time),assert(pay(Account,Time)). 
month(Month) :-
  Minute = 60,Hour is 60 * Minute,Day is 24 * Hour,Month is 30 * Day.

% based on pause / payed / unsubscriped / system paused, 
% whether account operating
account_can_operate(Account) :- 
  not(system_paused),
  not(paused(Account)),
  not(unsubscribed(Account)),
  now_is_valid(Account).
