:- discontiguous pausable/2.
one_many(account,user).
one_many(directive,item).
one_many(account,item).
one_many(account,directive).
one_only(account).
once_only(account,user).
once_only(directive,item).
once_only(account,item).
once_only(account,directive).
grantable(account,user,item).
grantable(account,user,directive).
pausable(account,directive).
pausable(account,directive,item).
pausable(account,user).
pausable(account).

:- halt.
