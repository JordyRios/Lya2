%{
int yylex();
int yyerror(char*);
%}

%token PROGRAM_TOKEN
%token VARIABLE_TOKEN
%token INTEGER_TOKEN
%token FLOAT_TOKEN
%token STRING_TOKEN
%token BOOLEAN_TOKEN
%token TRUE_TOKEN
%token FALSE_TOKEN
%token BEGIN_TOKEN
%token END_TOKEN
%token IF_TOKEN
%token THEN_TOKEN
%token ELSE_TOKEN
%token INPUT_TOKEN
%token OUTPUT_TOKEN
%token WHILE_TOKEN
%token DO_TOKEN
%token REPEAT_TOKEN
%token UNTIL_TOKEN
%token STRING_IDENT_TOKEN
%token FLOAT_IDENT_TOKEN
%token INT_IDENT_TOKEN
%token BOOLEAN_IDENT_TOKEN
%token PROGRAM_IDENT_TOKEN
%token STRING_TOKEN_REGEX
%token INTEGER_TOKEN_REGEX
%token FLOAT_TOKEN_REGEX
%token AND_TOKEN
%token OR_TOKEN
%token NOT_TOKEN
%token SEPARATOR_TOKEN
%token DATA_ASSIGN_TOKEN
%token END_EXPRESSION_TOKEN
%token ADD_OP_TOKEN
%token SUB_OP_TOKEN
%token MUL_OP_TOKEN
%token DIV_OP_TOKEN
%token MORE_THAN_TOKEN
%token LESS_THAN_TOKEN
%token MORE_EQUAL_TOKEN
%token LESS_EQUAL_TOKEN
%token EQUAL_TO_TOKEN
%token DIFFERENT_TO_TOKEN
%token ASSIGNER_TOKEN
%token OPEN_BRACKET_TOKEN
%token CLOSE_BRACKET_TOKEN


%%
	inicio:
		header vars logic
		{
			printf("Programa compilado exitosamente!\n");
		};
		| header logic
		{
			printf("Programa compilado exitosamente!\n");
		};
	
	header:
		PROGRAM_TOKEN PROGRAM_IDENT_TOKEN END_EXPRESSION_TOKEN;
	
	vars:
		VARIABLE_TOKEN; |
		VARIABLE_TOKEN declarations;
	
	declarations:
		string_declaration DATA_ASSIGN_TOKEN STRING_TOKEN END_EXPRESSION_TOKEN declarations ; |
		int_declaration DATA_ASSIGN_TOKEN INTEGER_TOKEN END_EXPRESSION_TOKEN declarations; |
		float_declaration DATA_ASSIGN_TOKEN FLOAT_TOKEN END_EXPRESSION_TOKEN declarations; |
		boolean_declaration DATA_ASSIGN_TOKEN BOOLEAN_TOKEN END_EXPRESSION_TOKEN declarations |
		string_declaration DATA_ASSIGN_TOKEN STRING_TOKEN END_EXPRESSION_TOKEN; |
		int_declaration DATA_ASSIGN_TOKEN INTEGER_TOKEN END_EXPRESSION_TOKEN; |
		float_declaration DATA_ASSIGN_TOKEN FLOAT_TOKEN END_EXPRESSION_TOKEN; |
		boolean_declaration DATA_ASSIGN_TOKEN BOOLEAN_TOKEN END_EXPRESSION_TOKEN 
		
	
	string_declaration:
		STRING_IDENT_TOKEN SEPARATOR_TOKEN string_declaration; |
		STRING_IDENT_TOKEN;
	
	int_declaration:
		INT_IDENT_TOKEN SEPARATOR_TOKEN int_declaration; |
		INT_IDENT_TOKEN;

	float_declaration:
		FLOAT_IDENT_TOKEN SEPARATOR_TOKEN float_declaration; |
		FLOAT_IDENT_TOKEN;
	
	boolean_declaration:
		BOOLEAN_IDENT_TOKEN SEPARATOR_TOKEN boolean_declaration; |
		BOOLEAN_IDENT_TOKEN;

	logic:
		BEGIN_TOKEN END_TOKEN; |
		BEGIN_TOKEN process END_TOKEN;
	
	process:
		 inputouput process; |
		 conditional process; |
		loop process; |
		 assignation process; |
		 inputouput; |
		 conditional; |
		 loop; |
		assignation; 
	
	inputouput:
		INPUT_TOKEN OPEN_BRACKET_TOKEN identifiers CLOSE_BRACKET_TOKEN END_EXPRESSION_TOKEN; | 
		OUTPUT_TOKEN OPEN_BRACKET_TOKEN identifiers CLOSE_BRACKET_TOKEN END_EXPRESSION_TOKEN; 
	
	identifiers:
		STRING_IDENT_TOKEN; |
		FLOAT_IDENT_TOKEN; |
		INT_IDENT_TOKEN; |
		BOOLEAN_IDENT_TOKEN; 

	conditional:
		IF_TOKEN OPEN_BRACKET_TOKEN condition CLOSE_BRACKET_TOKEN THEN_TOKEN logic ELSE_TOKEN logic; 

	loop:
		while_loop; |
		repeat_loop;
	
	while_loop:
		WHILE_TOKEN OPEN_BRACKET_TOKEN condition CLOSE_BRACKET_TOKEN DO_TOKEN logic;
	
	repeat_loop:
		REPEAT_TOKEN logic UNTIL_TOKEN OPEN_BRACKET_TOKEN condition CLOSE_BRACKET_TOKEN END_EXPRESSION_TOKEN;

	assignation:
		FLOAT_IDENT_TOKEN ASSIGNER_TOKEN numeric_decimal_expression END_EXPRESSION_TOKEN; |
		INT_IDENT_TOKEN ASSIGNER_TOKEN numeric_decimal_expression END_EXPRESSION_TOKEN; |
		BOOLEAN_IDENT_TOKEN ASSIGNER_TOKEN boolean_expression END_EXPRESSION_TOKEN; |
		STRING_IDENT_TOKEN ASSIGNER_TOKEN string_expression END_EXPRESSION_TOKEN; 
	
	condition:
		boolean_expression; |
		numeric_decimal_expression;

	numeric_decimal_expression:
		numeric_variables; |
		numeric_decimal_expression ADD_OP_TOKEN numeric_decimal_expression; |
		numeric_decimal_expression SUB_OP_TOKEN numeric_decimal_expression; |
		numeric_decimal_expression MUL_OP_TOKEN numeric_decimal_expression; |
		numeric_decimal_expression DIV_OP_TOKEN numeric_decimal_expression; |
		OPEN_BRACKET_TOKEN numeric_decimal_expression CLOSE_BRACKET_TOKEN; 
		
	numeric_variables:
		FLOAT_TOKEN_REGEX; |
		FLOAT_IDENT_TOKEN; |
		INT_IDENT_TOKEN; |
		INTEGER_TOKEN_REGEX; 
	
	string_expression:
		STRING_TOKEN_REGEX; |
		STRING_IDENT_TOKEN; 

	string_variables:
		STRING_TOKEN_REGEX; |
		STRING_IDENT_TOKEN; 

	boolean_variables:
		BOOLEAN_IDENT_TOKEN; |
		FALSE_TOKEN; |
		TRUE_TOKEN; 

	booleand_operators:
		AND_TOKEN; |
		OR_TOKEN; |
		NOT_TOKEN; 

	relational_operators:
		MORE_THAN_TOKEN; |
		LESS_THAN_TOKEN; |
		MORE_EQUAL_TOKEN; |
		LESS_EQUAL_TOKEN; |
		EQUAL_TO_TOKEN; |
		DIFFERENT_TO_TOKEN; 

	artimetic_operators:
		ADD_OP_TOKEN; |
		SUB_OP_TOKEN; |
		MUL_OP_TOKEN; |
		DIV_OP_TOKEN;

	boolean_expression:
		boolean_variables; |
		boolean_variables booleand_operators boolean_variables; |
		string_variables DIFFERENT_TO_TOKEN string_variables; |
		string_variables EQUAL_TO_TOKEN string_variables; |
		numeric_variables relational_operators numeric_variables; |
		numeric_variables artimetic_operators numeric_variables; |
		OPEN_BRACKET_TOKEN boolean_expression CLOSE_BRACKET_TOKEN; 
	
%%


int main()
{
	yyparse();
	return 0;
}

int yyerror(char *e)
{
	printf("Error: %s\n", e);
}
