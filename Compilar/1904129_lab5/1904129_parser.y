%{

#include <stdio.h>

int yylex(void);
int yyerror(char*);


%}

%token ID INTEGER_CONSTANT FLOAT_CONSTANT INT FLOAT CHAR SEMICOLON COMMA ASSIGN IF ELSE AND OR NOT WHILE RETURN RELOP ELIF
%left OR AND

%%
prog : funcDef ;
funcDef : type ID '(' argList ')' '{' declList stmtList '}'
argList : arg COMMA arg | %empty;
arg : type ID;
type      : INT | FLOAT ;
declList  : decl SEMICOLON declList | %empty ;
decl      : type varList;
varList : ID COMMA varList | ID;
stmtList : stmtList stmt | stmt;
stmt : assignStmt | ifStmt | whileStmt | ElseifStmt | ElseStmt ;
assignStmt : ID ASSIGN EXP SEMICOLON;
EXP : EXP '+' TERM | EXP '-' TERM | TERM;
TERM : TERM '*' FACTOR | TERM '/' FACTOR | FACTOR;
FACTOR : ID;
ifStmt : IF'('bExp')''{'stmtList'}';
bExp : EXP RELOP EXP;
ElseStmt : ELSE'{'stmtList'}'; 
ElseifStmt : ELIF'('bExp')''{'stmtList'}'; 
whileStmt : WHILE'('bExp')''{'stmtList'}';
bExp : bExp OR bExp |  bExp AND bExp |  NOT'('bExp')' ;
%%

int main(int argc, char **argv) {
	yyparse();
}

int yyerror(char *s){
    fprintf(stderr, "error : %s\n", s);
}
