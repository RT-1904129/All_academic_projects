- Our Lexical analyser will identify the things as fallow and it remove all comment and it remove all space.
• Keywords : short, float, double, bool, char, signed, unsigned, for, while,
do, return, void, switch, break, case, continue, goto, long, static, union,
default
• Integer constants: 12, 0, 3456, -234, etc.
• Floating point constant: 1.2, 4.25, -0.35, etc.
• Arithmetic operators: =, + =, − =, ∗ =, / =
• Relational operators: <, >, <=, >=, ==
• Special symbols: ;, (, ), comma, [, ], {, }
And it also recognise Multiline comment .
After identifying the identifiers, the lexical analyser
- The input code files for the Lexical Analyser are in C++. It is assumed that the input code files are syntactically correct
and has only the following keywords in their code : "if", "then", "else", "int", "return","float".

- There are 1 Input code files on which the Lexical Analyser is tested. 
    - That is the custom code written by me to check. ( input ) it have float values also .


To run lexical analyzer command type :- flex 1904129_Lab3.l
				     :- gcc lex.yy.c -lfl
				     :- ./a.out <input
