edge(1,2,1).
edge(1,4,1).
edge(1,3,2.5).
edge(2,3,1).
edge(2,5,1).
edge(3,4,1).
edge(3,5,2.2).
edge(4,5,1).

new_edge(X,Y,L) :- edge(X,Y,L); edge(Y,X,L).

%===Union iii + iio===
union([], M2, M2) :- !.
union([X|M1], M2, M3) :- member(X, M2), !, union(M1, M2, M3).
union([X|M1], M2, [X|M3]) :- union(M1, M2, M3).

unionAll(M1,M2,M3):- union(M1,M2,M), perm(M,M3),!.

perm([],[]).
perm([X|T], T2):- perm(T,T1), insert(X,T1,T2).

insert(E,L1,L2):- delete_one(E,L2,L1).

delete_one(E,[E|T],T).
delete_one(E,[H|T],[H|T1]):- delete_one(E,T,T1).

%unionAll([a,b,c],[c,d,e],[a,b,c,d,e,g]).

%===Sort===
ins_sort([ ],[ ]).
ins_sort([H|T],L):- ins_sort(T,T_Sort),insertSort(H,T_Sort,L),!.

insertSort(X,[],[X]).
insertSort(X,[H|T],[H|T1]):- X>H,!,insertSort(X,T,T1).
insertSort(X,T,[X|T]).

%ins_sort([-1,3,2,1,0],X).

%===16===
path(A,B,P):-p(A,[B],P).
 
p(A,[A|Tail],[A|Tail]).
p(A,[B|Tail],P):-new_edge(B,C,_),not(member(C,Tail)),p(A,[C,B|Tail],P).

%path(a,d,X).

%===19===
list_length(Xs,L) :- list_length(Xs,0,L) .

list_length( []     , L , L ) .
list_length( [_|Xs] , T , L ) :- T1 is T+1 , list_length(Xs,T1,L).

cycle:-new_edge(A,B,_), findall(P,path(A,B,P),Set), list_length(Set, SL), SL >= 2,!.

%cycle.

%===20===
not_connected:-new_edge(A,_,_),new_edge(B,_,_),dif(A,B),not(path(A,B,_)).
 
is_connected:-not(not_connected).

%is_connected.

%===17===
pathMin(A,B,P,L):-pMin(A,[B],P,L).
 
pMin(A,[A|Tail],[A|Tail],0).
pMin(A,[B|Tail],P,L):-new_edge(B,C,L1),not(member(C,Tail)),pMin(A,[C,B|Tail],P,L2), L is L1 + L2.

minPath(A,B,X) :- setof([L,P],pathMin(A,B,P,L),Set), sort(Set,Sorted), onlyMins(Sorted,Mins), member(X,Mins).

%minPath(a,c,X).

%===18===
short_path(X,Y,R):-create_level_list([X],Y,R,[X,Y]).

create_level_list([],_,[],_):-!.
create_level_list(X,Y,R,_):- path_to_target(X,Y,R).
create_level_list(X,Y,[Z|R],Q):-append(Q,X,Q1),create_paths_again(X,L,Q1),not(check_path(X,Y)),create_level_list(L,Y,R,Q),search(X,R,Z).

path_to_target([X|_],Y,[X,Y]):-new_edge(X,Y,_).
path_to_target([_|T],Y,Res):-path_to_target(T,Y,Res).

check_path([A|_],Y):-new_edge(A,Y,_),!.
check_path([_|B],Y):-check_path(B,Y).

create_paths_again([],[],_):-!.
create_paths_again([X|Tail],R,Q):-findall(C,new_edge(X,C,_),T),append(Q,[X|Tail],W),create_paths_again(Tail,K,W), append(K,T,R1), path_member(R1,W,R),!.
create_paths_again([_|L],R,Q):-create_paths_again(L,R,Q).

path_member([],_,[]):-!.
path_member([X|L],T,[X|R]):-not(member(X,T)),not(member(X,L)),path_member(L,T,R),!.
path_member([_|L],T,R):-path_member(L,T,R).

search([X|_],[A|_],X):-new_edge(X,A,_).
search([_|X],A,R):-search(X,A,R).

%short_path(1,5,X).
