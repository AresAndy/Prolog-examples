/** Build script (make.prolog)
 This file is used by make.sh to batch-create an executable
 of this project. Very hard-coded, needs improvements for sure,
 but as a firs attempt from a newcomer, this is nice.

@author AresAndy
@license BSD
*/

:- [main_module].         % Importing main module
:- autoload_all.          % Might help
:-
    write("Loaded main module. Compiling...."), nl,
    qsave_program(out,
    	[goal(main_module:main),
	 stand_alone(true)]),            % Actual save on disk
    write("Executable created. Bye"), nl.

:- halt.
