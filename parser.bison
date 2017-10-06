%start prog;
%token NUMBER_TOKEN  // Numbers
%token ADD_TOKEN // +
%token MULT_TOKEN // *
%left ADD_TOKEN

%{
#include <stdio.h>
#include "common.h"
%}

%%
prog: /* empty */
    | expr prog

expr: NUMBER_TOKEN
   | expr ADD_TOKEN expr
   ;
%%
#include <stdio.h>

int main(int argc, char **argv)
{
  if (argc > 0) yyin = fopen(argv[1], "r");
  yyparse();
  return 0;
}
