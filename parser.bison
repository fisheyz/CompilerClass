// Tokens
%token
  INT
  PLUS
  MINUS
  MULT
  DIV
  MOD
  ATTR
  LRTHAN
  GRTHAN
  EQ
  _PARENS
  PARENS_
  _CURLY
  CURLY_
  TRUE
  FALSE

// Operator associativity & precedence
%left ATTR
%left LRTHAN GRTHAN EQ
%left PLUS MINUS
%left MULT DIV MOD


// Root-level grammar symbol
%start program;

// Types/values in association to grammar symbols.
%union {
  int intValue;
  bool  boolValue;
  Expr* exprValue;
  ExprList* list;
  //ExprBool* exprBoolValue;
}

%type <intValue> INT
%type <boolValue> TRUE
%type <boolValue> FALSE
%type <exprValue> expr
%type <list> expr_list
//%type <exprBoolValue> exprBool

// Use "%code requires" to make declarations go
// into both parser.c and parser.h
%code requires {
#include <stdio.h>
#include <stdlib.h>
#include "ast.h"

extern int yylex();
extern int yyline;
extern char* yytext;
extern FILE* yyin;
extern void yyerror(const char* msg);
ExprList* root;
}

%%
program:expr_list { root = $1; }

expr_list: expr { $$ = mkList($1,NULL); }
	|expr expr_list { $$ = mkList($1,$2); }
  	;
expr:
  INT {
    $$ = ast_integer($1);
  }
  |
  expr PLUS expr {
    $$ = ast_operation(PLUS, $1, $3);
  }
  |
  expr MINUS expr{
	$$ = ast_operation(MINUS, $1, $3);
  }
  |
   expr MULT expr{
	$$ = ast_operation(MULT, $1, $3);
  }
  |
   expr DIV expr{
	$$ = ast_operation(DIV, $1, $3);
  }
  |
   expr MOD expr{
	$$ = ast_operation(MOD, $1, $3);
  }
  ;
%%

void yyerror(const char* err) {
  printf("Line %d: %s - '%s'\n", yyline, err, yytext  );
}
