/** Main module (main_module.prolog)

  This file is a brief example of some Prolog functionalities
  and main charateristics. It was written with the purpose of
  getting me started with this amazing programming language..
  Sure enough, it was a success: I'm hooked in :D ..

  This application "dynamically" creates some workers and some 
  murderers (dynamically means that the facts are not written one
  by one, but added to the knowledge base or "KnB" by Prolog 
  itself). It then prints out some stuff, so that you know that 
  it did something, and least but not last that it worked nice & 
  good.

  @author AresAndy
  @license BSD
*/

% ========================
% module declaration

:- module(main_module, [main/0]).

% ========================
% dynamic database population headers
% (Tells that those facts might change dynamically)

:- dynamic tool/1.
:- dynamic weapon/1.
:- dynamic worker/2.
:- dynamic killer/2.

% ========================
% Utility predicates

appendTopMostDB(X) :- asserta(X). /** Insert fact on top of KnB */

print_list([]) :- true. /** Prints every element of a list */
print_list([X|XS]) :-
	format("~w ", X),
	print_list(XS).

% ========================
% Tools creation predicates

createTools([]) :-  /** Create tools: no tools provided */
	true.
	
createTools([X|XS]) :-  /** Create tools: tools provided */
	appendTopMostDB(tool(X)), 
	createTools(XS).

% ========================
% Weapons creation predicates

createWeapons([]) :-  /** Create weapons: no weapons provided */
	true.
	
createWeapons([X|XS]) :-  /** Create weapons: weapons provided */
	appendTopMostDB(weapon(X)), 
	createWeapons(XS).

% ========================
% Workers creation predicates

createWorkers([], _) :-  /** Create workers: no names provided */
	true.
	
createWorkers([Name|Names], []) :-  /** Create workers, no tool */
	appendTopMostDB(worker(Name, tool(_))), 
	createWorkers(Names, []).
	
createWorkers([Name|Names], [Tool|Tools]) :-  /** Create workers with tools */
	appendTopMostDB(worker(Name, tool(Tool))), 
	createWorkers(Names, Tools).

% ========================
% Killers creation predicates

createKillers([], _) :-  /** Create killers, no name provided */
	true.
	
createKillers([Name|Names], []) :-  /** Create killers, no weapon */
	appendTopMostDB(killer(Name, weapon(knife))), 
	createKillers(Names, []).
	
createKillers([Name|Names], [Wep|Weps]) :- /** Create killers, weaponized */
	appendTopMostDB(killer(Name, weapon(Wep))), 
	createKillers(Names, Weps).

% ========================
% Querying predicates


killers(X) :- findall([X0, X1], killer(X0, X1), X). % give all killers
workers(X) :- findall([X0, X1], worker(X0, X1), X). % give all worksers

% ========================
% main predicate

main :- 
	write("Creating tools..."), nl,
	createTools([saw, hammer, axe, nail, pencil]),
	write("Creating weapons..."), nl,
	createWeapons([axe, hammer, knife]),
	write("Creating workers..."), nl,
	createWorkers([john, aaron, jack, simon], []),
	write("Creating killers..."), nl,
	createKillers([judas, bruto, jason], []),
	killers(Kill),
	workers(Work), % To Kill and Work are bound the results
	print_list(Kill), nl,
	print_list(Work), nl,
	halt.
