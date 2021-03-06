%{
// HEADERS
#include <stdlib.h>
#include "parser.h"

// variables maintained by the lexical analyser
int yyline = 1;
%}

%option noyywrap

%%
[ \t]+ {  }
#.*\n { yyline++; }
\n { yyline++; }


\-?[0-9]+ {
   yylval.intValue = atoi(yytext);
   return INT;
}
"true"  { return TRUE;}
"false" { return FALSE;}
"+" { return PLUS; }
"-" { return MINUS;}
"*" { return MULT; }
"/" { return DIV;  }
"%" { return MOD;  }
":=" {  return ATTR; }
"<"  {  return LRTHAN;  }
">"  {  return GRTHAN;  }
"==" {  return EQ;  }
"("  {  return _PARENS;  }
")"  {  return PARENS_;  }
"{"  {  return _CURLY;  }
"}"  {  return CURLY_;  }
.  { yyerror("unexpected character"); }
%%
