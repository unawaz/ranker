intercalate(L,S,O) :- atomic_list_concat(L,S,O).
concat(L,O) :- atomic_list_concat(L,O).
unwords(L,O) :- intercalate(L,' ',O).
unlines(L,O) :- intercalate(L,'\n',O).
uncommas(L,O) :- intercalate(L,',',O).
surround(X,Z,Y,O) :- concat([X,Y,Z],O).
middle(X,M,O) :- surround(X,X,M,O).
dq(X,O) :- middle('"',X,O).
sq(X,O) :- middle('\'',X,O).
angles(X,O) :- surround('<','>',X,O).
braces(X,O) :- surround('{','}',X,O).
parens(X,O) :- surround('(',')',X,O).
squares(X,O) :- surround('[',']',X,O).
equals(X,Y,O) :- concat([X,'=',Y],O).

kv([K,V],O) :- dq(V,VQ),equals(K,VQ,O).
kvl(L,O) :- maplist(kv,L,O).

ctag(T,O) :- concat(['</',T,'>'],O).
otag(T,KVL,O) :- kvl(KVL,S),concat(['<',T,' ',S,'>'],O).
stag(T,O) :- angles(T,O).

tag(T,KVL,Body,O) :- 
  otag(T,KVL,Ot),ctag(T,Ct),
  concat([Ot,Body,Ct],O).
sctag(T,L,O) :- stag(T,A),ctag(T,Z),concat(L,LL),concat([A,LL,Z],O).

title(Title,O) :- sctag('title',[Title],O).
head(Title,O) :- 
  title(Title,T),
  sctag('head',[T],O).
html(Title,Body,O) :-
  body(Body,B),
  head(Title,Head),
  sctag('html',[Head,B],O).

head([Css],[s],Title,Body).

:- halt.
