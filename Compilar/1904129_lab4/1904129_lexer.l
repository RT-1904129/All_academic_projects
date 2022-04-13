%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "parser.tab.h"

%}

digit [0-9]
letter [a-zA-Z]

%%
[ \t]+ ;
[-]?{digit}+                                                            {printf("An INTEGER_CONSTANT : %s is encountered\n", yytext); return INTEGER_CONSTANT ; }
[-]?{digit}*"."{digit}+                                                 {printf("An FLOAT_CONSTANT : %s is encountered\n", yytext); return FLOAT_CONSTANT ; }
">"                                                                     {printf("GT\n"); return GT; }
">="                                                                    {printf("GE\n"); return GE; }
"<"                                                                     {printf("LT\n"); return LT; }
"<="                                                                    {printf("LE\n"); return LE; }
"int"                                                                   {printf("INT\n"); return INT; }
"float"                                                                 {printf("FLOAT\n"); return FLOAT; }
"char"                                                                  {printf("CHAR\n"); return CHAR;}
";"                                                                     {printf("SEMICOLON\n"); return SEMICOLON; }
","                                                                     {printf("COMMA\n"); return COMMA; }
"assign"                                                                {printf("ASSIGN\n"); return ASSIGN; }
"if"                                                                    {printf("IF\n"); return IF;}
"else"                                                                  {printf("ELSE\n"); return ELSE;}
"&&"                                                                    {printf("AND\n"); return AND;}   
"||"                                                                    {printf("OR\n"); return OR;}
"!"                                                                     {printf("NOT\n"); return NOT;}
"=="                                                                    {printf("EQ\n"); return EQ;}
"!="                                                                    {printf("NE\n"); return NE;}
"while"                                                                 {printf("WHILE\n"); return WHILE;}
"return"                                                                {printf("RETURN\n"); return RETURN;}
"{"                                                                     {printf("open Bracket found {\n"); return  yytext[0];}
"}"                                                                     {printf("closed Bracket found }\n"); return  yytext[0];}
"("                                                                     {printf("Small Bracket found )\n"); return  yytext[0];}
")"                                                                     {printf("Captal Bracket found (\n" ); return  yytext[0];}
{letter}+                                                               {printf("ID %s\n", yytext); return ID; }
"\n"                                                                    {printf("The paragraph ended\n");}
.                                                                       ;
%%
