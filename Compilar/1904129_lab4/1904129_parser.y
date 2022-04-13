%{

#include <stdio.h>

int yylex(void);
int yyerror(char*);


%}

%token ID INTEGER_CONSTANT FLOAT_CONSTANT INT FLOAT CHAR SEMICOLON COMMA ASSIGN IF ELSE AND OR NOT EQ GE LE LT GT NE WHILE RETURN 

%%
prog : funcDef
funcDef : type ID '(' argList ')' '{' declList stmtList '}'
argList : arg COMMA arg | ;
arg : type ID;
declList : decl SEMICOLON declList | ;
decl : type varList;
varList : ID COMMA varList|ID;
type : INT|FLOAT | CHAR;
stmtList : ;
%%

int main(int argc, char **argv) {
	yyparse();
}

int yyerror(char *s){
    fprintf(stderr, "error : %s\n", s);
}
