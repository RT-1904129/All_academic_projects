%{
    // importing all library
    #include <string.h>
    #define MAX 45
    char sym_tab[MAX][MAX];
    int  count = 0;
    void add_sym_tab(char name[], int len);
%}
digit [0-9]
letter [a-zA-Z]
letter_or_digit {digit}|{letter}|[_]    


%%
[ \t]+                                                               ;
[-]?{digit}+                                                             { printf("An integer : %s is encountered\n", yytext); }
[-]?{digit}*"."{digit}+                                                  { printf("A float : %s is encountered\n", yytext); } 
"int"|"float"|"if"|"else"|"void"|"short"|"double"|"bool"|"char"|"signed"|"unsigned"|"for"|"while"|"do"|"return"|"switch"|"break"|"case"|"continue"|"goto"|"long"|"static"|"union"|"default"                { printf("Reserved words : %s is encountered\n", yytext); }            
[_]*{letter}{letter_or_digit}*                                          { printf("Identifier : %s is encountered\n", yytext); add_sym_tab(yytext, yyleng); }
"<"|">"|"<="|">="|"=="                                                  { printf("An Relational operator : %s is encountered\n", yytext); }
"="|"+"|"−="|"∗="|"/="|"-"|"*"                                          { printf("Arithmetic operator : %s is encountered\n", yytext); }

";"|"("|")"|","|"["|"]"|"{"|"}"                                         { printf("A Special character : %s is encountered\n",yytext); }
\/\*.*\*\/                                                              { printf("Comments are ignored\n"); }    
%%


void add_sym_tab(char *name, int len){
    for(int i=0;i<count;i++){
        if(strcmp(sym_tab[i],name) == 0) return ;
    }
    strcpy(sym_tab[count], name);
    count++;
}

int main(){
    yylex();
    printf("Number of entries in symbol table is %d\n", count);
}
