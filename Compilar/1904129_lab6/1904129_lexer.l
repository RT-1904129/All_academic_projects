%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "1904129_parser.tab.h"

%}

digit [0-9]
letter [a-zA-Z]

%%

[ \t]+ ;
[-]?{digit}+                                                            {printf("An INTEGER_CONSTANT : %s is encountered\n", yytext); return INTEGER_CONSTANT ; }
[-]?{digit}*"."{digit}+                                                 {printf("An FLOAT_CONSTANT : %s is encountered\n", yytext); return FLOAT_CONSTANT ; }
\/\*.*\*\/                                                              {printf("The comments are removed\n"); }

"="                                                                     {printf("= is encountered\n"); return ASSIGN; }
">"|"<"|">="|"<="|"=="|"!="                                             {printf("Relational Operator is encountered.\n");  return RELOP; }
"int"                                                                   {printf("INT\n"); return INT; }
"float"                                                                 {printf("FLOAT\n"); return FLOAT; }
"char"                                                                  {printf("CHAR\n"); return CHAR;}
";"                                                                     {printf("SEMICOLON\n"); return SEMICOLON; }
","                                                                     {printf("COMMA\n"); return COMMA; }
"if"                                                                    {printf("IF\n"); return IF;}
"else"                                                                  {printf("ELSE\n"); return ELSE;}
"else if"                                                               {printf("ELSE IF\n"); return ELIF;}
"&&"                                                                    {printf("AND\n"); return AND;}   
"||"                                                                    {printf("OR\n"); return OR;}
"!"                                                                     {printf("NOT\n"); return NOT;}
"while"                                                                 {printf("WHILE\n"); return WHILE;}
"return"                                                                {printf("RETURN\n"); return RETURN;}
"{"                                                                     {printf("open Bracket found {\n"); return  yytext[0];}
"}"                                                                     {printf("closed Bracket found }\n"); return  yytext[0];}
"("                                                                     {printf("Small Open Bracket found )\n"); return  yytext[0];}
")"                                                                     {printf("Small Close Bracket found (\n" ); return  yytext[0];}
"+"|"/"|"*"|"-"|"+="|"*="|"/="|"-="                                     {printf("Arithmetic operator : %s is encountered\n", yytext); return yytext[0]; }
{letter}+                                                               {printf("ID %s\n", strcpy(yylval.sval,yytext)); return ID; }
"\n"                                                                    {printf("The paragraph ended\n");}
.                                                                       ;
%%
