/** Format-less I/O for Prolog (nice-io.prolog)

  This file includes a series of predicates, so that you can
  read and write without worring about the full-stop thing
  (presumes that the keyboard is buffered). Won't work with
  Arity Prolog.

  @author "AresAndy"
  @license BSD

  ## Legend ##
  EOL = End Of Line
  *aux = auxiliary (for instance used for tail recursion)
*/

:- module(nice-io, [read_str/1,
		    read_atom/1,
		    read_num/1,
                    write_str/1]).

% =========================
% read_str and read_str_aux
%
% Reads a string until an EOL is reached.
% read_str_aux is an auxiliary predicate, shouldn't be used
% on its own.

read_str_aux(-1, []) :- !. % invalid char
read_str_aux(10, []) :- !. % UNIX EOL
read_str_aux(13, []) :- !. % M$ EOL
read_str_aux(Char, [Char|Rest]) :- read_str(Rest).

read_str(String) :- 
	get0(Char), 
	read_str_aux(Char,String).

% =========================
% read_atom
%
% Reads a string and converts it into an atom.
% Not quite fault-tollerant (bad atom syntax might fail on this
% one).

read_atom(Atom) :- 
	read_str(String), 
	name(Atom, String).

% =========================
% read_num
%
% Reads a string and converts it into a number.
% Not quite fault-tollerant (bad number syntax might fail on this
% one).

read_num(Num) :- 
	read_str(String), 
	name(Num, String).

% =========================
% write_str
%
% I believe this one is self-explanatory.

write_str([]).
write_str([Char|Rest]) :- 
	put(Char), 
	write_str(Rest).
