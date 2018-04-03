room(1).
room(2).
room(3).
room(4).
room(5).
room(6).
room(7).
room(8).
room(9).
room(10).
room(11).
room(12).
room(13).
room(14).
room(15).
room(16).

door(1,2).
door(1,7).
door(2,8).
door(3,8).
door(4,8).
door(4,9).
door(5,6).
door(5,9).
door(6,9).
door(7,8).
door(7,9).
door(7,10).
door(7,11).
door(7,12).
door(7,13).
door(7,14).
door(14,15).
door(15,16).

ring(5).
ring(9).
ring(16).

next_to(Room1, Room2):-(door(Room1, Room2); door(Room2, Room1)).

reverse([],Z,Z).
reverse([H|T],Z,Acc) :-reverse(T,Z,[H|Acc]).

%Given Start and Dest 
path(StartRoom,DestRoom):-nonvar(StartRoom), nonvar(DestRoom),
	ring(DestRoom),
	get_path(StartRoom, DestRoom),
	fail.

%Given only ending
path(StartRoom,DestRoom):-var(StartRoom), nonvar(DestRoom),
	ring(DestRoom),
	forall(room(E), (get_path(E, DestRoom))),
	fail.

%Given only starting
path(StartRoom,DestRoom):-nonvar(StartRoom), var(DestRoom),
	forall(ring(E), (get_path(StartRoom, E))),
	fail.

%Given nothing
path(StartRoom,DestRoom):-var(StartRoom), var(DestRoom),
	forall(ring(PH), forall(room(Room), (get_path(Room, PH)))),
	fail.
	
get_path(StartRoom,DestRoom):-nonvar(StartRoom), nonvar(DestRoom),
	forall(make_path(StartRoom, DestRoom, R), nl).


make_path(Start,Dest,T):-nonvar(Start), nonvar(Dest), var(T),
	T = [],
	go(Start, Dest, T,R),
	reverse(R,Route, []),
	write(Route).

%When Beginning and end room is the same.
go(X,X,T,[X|T]). 	

go(Place,Dest,T,R):-next_to(Place,Next),
	\+(member(Next,T)), 
	go(Next,Dest,[Place|T],R).
	

