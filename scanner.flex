%{
// HEADERS
#include <stdlib.h>
#include "common.h"
#include "parser.h"

// variables maintained by the lexical analyser
int yyline = 1;
%}

%option noyywrap

%%
[ \t] {  }
\n { yyline++; }
"+" { return ADD_TOKEN; }
\-?[0-9][0-9]*(\.[0-9]*)? { 
   return NUMBER_TOKEN; 
}
.  { yyerror("unexpected character"); }
%%

