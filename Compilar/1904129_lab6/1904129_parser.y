%{
#include <stdio.h>
#include<string.h>
#include <stdbool.h>
#define MAX 45
struct check{
    char Etype[MAX];
    char ID[MAX];
};
int yylex(void);
int yyerror(char *);
struct check sym_tab[MAX];
int  count = 0;
char Currtype[10];

void add_sym_tab(char *name){
    for(int i=0;i<count;i++){
        if(strcmp(sym_tab[i].ID,name) == 0) return ;
    }
    strcpy(sym_tab[count].ID, name);
    strcpy(sym_tab[count].Etype, Currtype);
    count++;
}

int search(char ID []){
    for(int i=0;i<count;i++){
        if(strcmp(sym_tab[i].ID,ID) == 0) return 1;
    }
    return 0;
}

char* get_type(char * ID){
    for(int i=0;i<count;i++){
        if(strcmp(sym_tab[i].ID,ID)==0) return sym_tab[i].Etype ;
    }
}

%}
%union{
    int  ival;
    double dval;
    char  sval[10];
};

%token INTEGER_CONSTANT FLOAT_CONSTANT INT FLOAT CHAR SEMICOLON COMMA ASSIGN IF ELSE AND OR NOT WHILE RETURN RELOP ELIF
%token <sval> ID
%type <sval> EXP TERM FACTOR bExp 
%left OR AND

%%
prog : funcDef ;
funcDef : type ID{add_sym_tab($2);} '(' argList ')' '{' declList stmtList '}'
argList : arg COMMA arg | %empty;
arg : type ID;
type      : INT { strcpy(Currtype, "int"); }   | FLOAT { strcpy(Currtype, "float"); }  ;
declList  : decl SEMICOLON declList | %empty ;
decl      : type varList;
varList : ID{add_sym_tab($1);} COMMA varList | ID{add_sym_tab($1);};
stmtList : stmtList stmt | stmt;
stmt : assignStmt | ifStmt | whileStmt | ElseifStmt | ElseStmt ;
assignStmt : ID ASSIGN EXP {  
        if(strcmp(get_type($1), $3)) 
            { 
                printf("Both data type of Expression is different Error\n"); 
            }
	   } SEMICOLON;


EXP : EXP '+' TERM
    {
            if(!strcmp($1, "float") || !strcmp($3, "float")) 
            { 
                { strcpy($$, "float"); }
            }
    } 
EXP: EXP '-' TERM {
           if(!strcmp($1, "float") || !strcmp($3, "float")) 
            { 
                { strcpy($$, "float"); }
            }
    } | TERM {strcpy($$,$1);};
TERM : TERM '*' FACTOR{
            if(!strcmp($1, "float") || !strcmp($3, "float")) 
            { 
                { strcpy($$, "float"); }
            }
    }  | TERM '/' FACTOR {
           if(!strcmp($1, "float") || !strcmp($3, "float")) 
            { 
                { strcpy($$, "float"); }
            }
    } | FACTOR {strcpy($$,$1);};
FACTOR : ID {
            if(!search($1)){
                printf("This variable is not declared\n");
            } 
            else strcpy($$,get_type($1));} ;
FACTOR : INTEGER_CONSTANT {strcpy($$,"int");} |  FLOAT_CONSTANT {strcpy($$,"float");};

ifStmt : IF'('bExp')''{'stmtList'}';
bExp : EXP RELOP EXP;
ElseStmt : ELSE'{'stmtList'}'; 
ElseifStmt : ELIF'('bExp')''{'stmtList'}'; 
whileStmt : WHILE'('bExp')''{'stmtList'}';
bExp : bExp OR bExp |  bExp AND bExp |  NOT'('bExp')' ;
%%

int main(int argc, char **argv) {
	yyparse();
    printf("Printing the Symbol Table\n");
    for(int i=0;i<count;i++){
        printf("%s type %s\n",sym_tab[i].ID,sym_tab[i].Etype);
    } 
}

int yyerror(char *s){
    fprintf(stderr, "error : %s\n", s);
}
