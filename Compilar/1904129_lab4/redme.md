- Our Design a syntax analyzer using Bison which will accept an input code writ-
ten in a toy programming language. For this assignment, the syntax analyzer
accepts some declaration statements written in a function. You have already
designed a lexical analyzer which tokenizes the inputs in assignment 2. Please
return appropriate tokens to the parsers for the input lexemes. Some example
tokens, the symbols and the context-free grammar are given below.

Non-terminals :-
prog funcDef type argList declList stmtList argList arg type decl varList
stmtList



command Type :-   bison -d 1904129_parser.y
		 :-   flex 1904129_lexer.l
	       :-   gcc 1904129_parser.tab.c lex.yy.c -lfl
		 :-   ./a.out < input