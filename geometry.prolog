/** Basic 2D geometry (geometry.prolog)
  This is a joke library. Why it is a joke? Well, it's not 100% legit.
  Some predicates are valid, some aren't.. It's up to you to find what's wrong
  and propose a fix. Enjoy.
  
  @author "AresAndy"
  @license BSD
*/

:- module(geometry, [point/2,
                     segment/2,
		     distance_points/3,
		     segment_lenght/2,
		     angle/3,
                     arc/2,
                     gradient/2,
		     radiant/2,
                     horizontal/1,
                     vertical/1,
		     arc_between_segments/3
		     perpendicular/2
                     parallel/2]).

point(_, _).

segment(point(_, _), point(_, _)).

distance_points(point(X1, Y1), point(X2, Y2), Res) :- Res is sqrt(((X2 - X1) ** 2) + ((Y2 - Y1) ** 2)).

segment_lenght(segment(A, B), Res) :- distance_points(A, B, Res).

angle(point(_, _), _, _).

gradient(Rad, Res) :- Res is (Rad * 180) rdiv pi.

radiant(Gra, Res) :- Res is (Gra * pi) rdiv 180.

arc(angle(_, A, B), Res) :- Res is atan(A rdiv B).

vertical(segment(point(X, _), point(Y, _))) :- X =:= Y;

horizontal(segment(point(_, X), point(_, Y))) :- X =:= Y.

arc_between_segments(X, Y, Res) :-
	segment_lenght(X, Xl),
	segment_lenght(Y, Yl),
	arc(angle(_, Xl, Yl), SubRes),
	gradient(SubRes, Res).

perpendicular(X, Y) :- 
	(vertical(Y), horizontal(X)); 
	(vertical(X), horizontal(Y));
	arc_between_segments(X, Y, SubRes),
        between(89.9998, 90.9998, SubRes).
	
parallel(X, Y) :- 
	(vertical(Y), vertical(X)); 
	(horizontal(X), horizontal(Y));
	arc_between_segments(X, Y, SubRes),
	between(359.9998, 0.9998, SubRes).

