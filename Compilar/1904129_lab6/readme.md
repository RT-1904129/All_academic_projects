- Our Design a syntax analyzer using Bison which will accept an input code writ-
ten in a toy programming language. 
In the last assignment, we had a context-free grammar for accepting com-
mon programming language statements. Now, we have to incorporate a symbol
table which keeps track of all the variables and function names that are declared.
It will have two fields per variable, name and type, and these fields will be pop-
ulated when any declaration statement is encountered. For function names, it
will have two fields, name and return type. For now, you can assume that it is
an array, not a hash table. Next, whenever a variable is encountered, you have
to find its type using a lookup operation in the symbol table.
Now, you have to add type-checking code for assignment statements. You
have to derive type of an expression (denoted by non-terminal exp). If an integer
variable/constant and a floating-point variable/constant are added, the type of
the corresponding expression will be FLOAT. You have to check whether the
variables are declared before using in the assignment statements.
The following program fragment should raise a warning as a floating-point
number is assigned to the variable a, which is an integer. Also, it should raise
an error as the variable d is used without being declared.

command Type :-   bison -d 1904129_parser.y
		 :-   flex 1904129_lexer.l
	       :-   gcc 1904129_parser.tab.c lex.yy.c -lfl -Ly
		 :-   ./a.out < input