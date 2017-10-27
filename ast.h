
// AST definitions
#ifndef __ast_h__
#define __ast_h__
//hello
// AST for expressions
struct _Expr {
  enum {
    E_INTEGER,
    E_OPERATION,
    E_BOOLEAN
  } kind;
  union {
    int value; // for integer values
    struct {
      int operator; // PLUS, MINUS, etc
      struct _Expr* left;
      struct _Expr* right;
    } op; // for binary expressions
  } attr;
};

typedef struct _Expr Expr;

struct _ExprList {
	Expr *exp;
	struct _ExprList* next;
};

 // Convenience typedef
typedef struct _ExprList ExprList;


// Constructor functions (see implementation in ast.c)
Expr* ast_integer(int v);
Expr* ast_bool(bool v);
Expr* ast_operation(int operator, Expr* left, Expr* right);
ExprList* mkList(Expr* e, ExprList* list);

#endif
