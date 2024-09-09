%{
   #include "sintactico.tab.h"
%}

%%

"//".+      { }
[ \t\r]     { }
\n          { }

"program"  {return PROGRAM_TOKEN;}
"else" {return VARIABLE_TOKEN;}
"read"    {return INTEGER_TOKEN;}
"readIn"      {return FLOAT_TOKEN;}
"for"    {return STRING_TOKEN;}
"then"    {return BOOLEAN_TOKEN;}
"suma" {return TRUE_TOKEN;}
"resta"     {return FALSE_TOKEN;}
"edad"	{return EDAD_TOKEN;}
"fin"		{return END_TOKEN;}
"if"        {return IF_TOKEN;}
"entonces"  {return THEN_TOKEN;}
"sino"      {return ELSE_TOKEN;}
"leer"	    {return INPUT_TOKEN;}
"escribir"  {return OUTPUT_TOKEN;}
"mientras"  {return WHILE_TOKEN;}
"hacer"     {return DO_TOKEN;}
"repetir"   {return REPEAT_TOKEN;}
"hasta"     {return UNTIL_TOKEN;}


[a-zA-Z][a-zA-Z0-9_]*"a"   {return STRING_IDENT_TOKEN;}
[a-zA-Z][a-zA-Z0-9_]*"b"   {return STRING_IDENT_TOKEN;}
[a-zA-Z][a-zA-Z0-9_]*"c"   {return STRING_IDENT_TOKEN;}
[a-zA-Z][a-zA-Z0-9_]*"d"   {return BOOLEAN_IDENT_TOKEN;}
[a-zA-Z][a-zA-Z0-9_]*"f"   {return PROGRAM_IDENT_TOKEN;}
"[a-zA-Z]"          {return STRING_TOKEN_REGEX;}
[0-9]+           {return INTEGER_TOKEN_REGEX;}
[0-9]+\.[0-9]+   {return FLOAT_TOKEN_REGEX;}

"&&"     {return AND_TOKEN;}
"|"     {return OR_TOKEN;}
"!"     {return NOT_TOKEN;}
","     {return SEPARATOR_TOKEN;}
":"     {return DATA_ASSIGN_TOKEN;}
";"     {return END_EXPRESSION_TOKEN;} 
"+"     {return ADD_OP_TOKEN;}
"-"     {return SUB_OP_TOKEN;}
"*"     {return MUL_OP_TOKEN;}
"/"     {return DIV_OP_TOKEN;}
">"     {return MORE_THAN_TOKEN;}
"<"     {return LESS_THAN_TOKEN;}
">="    {return MORE_EQUAL_TOKEN;}
"<="    {return LESS_EQUAL_TOKEN;}
"="    {return EQUAL_TO_TOKEN;}
"!="    {return DIFFERENT_TO_TOKEN;}
"="     {return ASSIGNER_TOKEN;}
"("     {return OPEN_BRACKET_TOKEN;}
")"     {return CLOSE_BRACKET_TOKEN;}

.       { printf("Invalid token\n"); return -1; }

%%

int yywrap() { }



