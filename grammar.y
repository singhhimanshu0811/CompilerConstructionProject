%debug
%define parse.error verbose
%{
#include <math.h>
#include <stdlib.h>
#include <stddef.h>
#include <stdio.h>
#include <string.h>
#include <error.h>
#include <errno.h>
	
#include "extetrickstype.h"
	
void yyerror(const char *s)
{
fprintf(stderr,"%s\n",s);
return;
}
	
int yywrap()
{
	return 1;
}
	
char* indent_proc(char* body) {
	char* ans = malloc(1024);
	memset(ans, 0, 1024);
	char* line = strtok(body, "\n");
	while(line != NULL) {
		sprintf(ans, "%s    %s\n", ans, line);
		line = strtok(NULL, "\n");
	}
	free(body);
	return ans;
}
const char *verbatim="from engine import *\n";
	
%}
	
%token SECTION1 SECTION2 SECTION3 NEWLINE NUM ID IF THEN ELSE END WHILE CALL WITH OR AND NOT NEG PLAY RETURN
	
%%
START :  SECTION1 NEWLINE PRIMITIVE SECTION2 NEWLINE FUNCTIONS SECTION3 NEWLINE ENGINE  { 
			$$ = (ExtetricksSType)malloc(sizeof(xtetricksSType));
			$$->value.StringValue = (char*)malloc(1024*sizeof(char));
			sprintf($$->value.StringValue, "%s\n#PRIMITIVE:\n%s\n#FUNCTIONS:\n%s\n#ENGINE:\n%s\n", verbatim,$3->value.StringValue, $6->value.StringValue, $9->value.StringValue);

			printf("%s\n", $$->value.StringValue); 
		};
/* VERBATIM: {
	$$ = (ExtetricksSType)malloc(sizeof(xtetricksSType));
	$$->value.StringValue = (char*)malloc(1024*sizeof(char));
	sprintf($$->value.StringValue, "%s", verbatim);
	//printf("%s\n", $$->value.StringValue);
} */
	
PRIMITIVE : ID '=' EXPR NEWLINE PRIMITIVE { 
				$$ = (ExtetricksSType)malloc(sizeof(xtetricksSType));
				$$->value.StringValue = (char*)malloc(1024*sizeof(char));
				sprintf($$->value.StringValue, "%s = %s\n%s", $1->value.StringValue, $3->value.StringValue, $5->value.StringValue);
				// printf("PRIMITIVE -> ID '=' EXPR NEWLINE PRIMITIVE\n"); 
			}
			| { 
				$$ = (ExtetricksSType)malloc(sizeof(xtetricksSType));
				$$->value.StringValue = (char*)malloc(1024*sizeof(char));
				strcpy($$->value.StringValue, "");
				// printf("PRIMITIVE -> #\n"); 
			}
					;
	
ENGINE : '[' PLAY ']' { 
			$$ = (ExtetricksSType)malloc(sizeof(xtetricksSType));
			$$->value.StringValue = (char*)malloc(1024*sizeof(char));
			sprintf($$->value.StringValue, "if __name__ == '__main__':\n\tmainFunc()\n\ttetris_engine = TetrisEngine()\n");
			// printf("ENGINE -> '[' PLAY ']'\n"); 
		}
		| '[' PLAY WITH PARAM PARAMLIST ']' { 
			$$ = (ExtetricksSType)malloc(sizeof(xtetricksSType));
			$$->value.StringValue = (char*)malloc(1024*sizeof(char));
			sprintf($$->value.StringValue, "if __name__ == '__main__':\n\tmainFunc()\n\ttetris_engine = TetrisEngine(%s%s)\n", $4->value.StringValue, $5->value.StringValue);
			// printf("ENGINE -> '[' PLAY WITH PARAM PARAMLIST ']'\n"); 
		};
	
FUNCTIONS : FUNCTION NEWLINE FUNCTIONS { 
				$$ = (ExtetricksSType)malloc(sizeof(xtetricksSType));
				$$->value.StringValue = (char*)malloc(1024*sizeof(char));
				sprintf($$->value.StringValue, "%s\n%s", $1->value.StringValue, $3->value.StringValue);
				// printf("FUNCTIONS -> FUNCTION NEWLINE FUNCTIONS\n"); 
			}
			| {
				$$ = (ExtetricksSType)malloc(sizeof(xtetricksSType));
				$$->value.StringValue = (char*)malloc(1024*sizeof(char));
				strcpy($$->value.StringValue, "");
				// printf("FUNCTIONS -> #\n"); 
			};
FUNCTION : '{' ID BODY '}'{ 
				$$ = (ExtetricksSType)malloc(sizeof(xtetricksSType));
				$$->value.StringValue = (char*)malloc(1024*sizeof(char));
				char* body = indent_proc($3->value.StringValue);
				sprintf($$->value.StringValue, "def %s():\n%s", $2->value.StringValue, body);
				// printf("FUNCTION -> '{' ID BODY '}'\n"); 
			};
	
BODY : STATEMENT BODY { 
			$$ = (ExtetricksSType)malloc(sizeof(xtetricksSType)); 
			$$->value.StringValue = (char*)malloc(1024*sizeof(char)); 
			sprintf($$->value.StringValue, "%s\n%s", $1->value.StringValue, $2->value.StringValue);
			// printf("BODY -> STATEMENT BODY\n"); 
		}
		| STATEMENT { 
			$$ = (ExtetricksSType)malloc(sizeof(xtetricksSType));
			$$->value.StringValue = (char*)malloc(1024*sizeof(char));
			sprintf($$->value.StringValue, "%s", $1->value.StringValue);
			// printf("BODY -> STATEMENT\n"); 
		};
	
STATEMENT : IFSTATEMENT { 
				$$ = (ExtetricksSType)malloc(sizeof(xtetricksSType));
				$$->value.StringValue = (char*)malloc(1024*sizeof(char));
				sprintf($$->value.StringValue, "%s", $1->value.StringValue);
				// printf("%s", $1->value.StringValue); 
			}
			| WHILELOOP { 
				$$ = (ExtetricksSType)malloc(sizeof(xtetricksSType));
				$$->value.StringValue = (char*)malloc(1024*sizeof(char));
				sprintf($$->value.StringValue, "%s", $1->value.StringValue);
				// printf("%s", $1->value.StringValue); 
			}
			| ID '=' EXPR {
				$$ = (ExtetricksSType)malloc(sizeof(xtetricksSType)); 
				$$->value.StringValue = (char*)malloc(1024*sizeof(char)); 
				sprintf($$->value.StringValue, "global %s\n%s = %s",$1->value.StringValue, $1->value.StringValue, $3->value.StringValue); 
				// printf("STATEMENT -> ID '=' EXPR: %s\n", $$->value.StringValue); 
			}
			| RETURN EXPR { 
				$$ = (ExtetricksSType)malloc(sizeof(xtetricksSType));
				$$->value.StringValue = (char*)malloc(1024*sizeof(char));
				sprintf($$->value.StringValue, "return %s", $2->value.StringValue);
				// printf("STATEMENT -> RETURN EXPR\n"); 
			}
			;
	
IFSTATEMENT : IF '(' EXPR ')' THEN BODY END {
				$$ = (ExtetricksSType)malloc(sizeof(xtetricksSType)); 
				$$->value.StringValue = (char*)malloc(1024*sizeof(char)); 
				char* stm = indent_proc($6->value.StringValue);
				sprintf($$->value.StringValue, "if %s :\n%s", $3->value.StringValue, stm); 
				// printf("IFSTATEMENT -> IF '(' EXPR ')' THEN STATEMENT END\n"); 
			}
			| IF '(' EXPR ')' THEN STATEMENT ELSE STATEMENT END {
				$$ = (ExtetricksSType)malloc(sizeof(xtetricksSType)); 
				$$->value.StringValue = (char*)malloc(1024*sizeof(char)); 
				char* stm1 = indent_proc($6->value.StringValue);
				char* stm2 = indent_proc($8->value.StringValue);
				sprintf($$->value.StringValue, "if %s :\n%selse:\n%s", $3->value.StringValue, stm1, stm2); 
				// printf("IFSTATEMENT -> IF '(' EXPR ')' THEN STATEMENT ELSE STATEMENT END\n"); 
			}
			;
	
WHILELOOP : WHILE '(' EXPR ')' BODY END { 
				$$ = (ExtetricksSType)malloc(sizeof(xtetricksSType));
				$$->value.StringValue = (char*)malloc(1024*sizeof(char));
				char* stm = indent_proc($5->value.StringValue);
				sprintf($$->value.StringValue, "while %s :\n%s", $3->value.StringValue, stm);
				// printf("WHILELOOP -> WHILE '(' EXPR ')' STATEMENT END\n"); 
			}
					;
	
EXPR : ARITHLOGIC {
			$$ = (ExtetricksSType)malloc(sizeof(xtetricksSType)); 
			$$->value.StringValue = (char*)malloc(1024*sizeof(char)); 
			sprintf($$->value.StringValue, "%s", $1->value.StringValue); 
			// printf("EXPR -> ARITHLOGIC: %s\n", $$->value.StringValue); 
		}
			| '[' CALL ID ']' { 
			$$ = (ExtetricksSType)malloc(sizeof(xtetricksSType));
			$$->value.StringValue = (char*)malloc(1024*sizeof(char));
			sprintf($$->value.StringValue, "%s()", $3->value.StringValue);
			// printf("EXPR -> '[' CALL ID ']'\n"); 
		}
		| '[' CALL ID WITH PARAM PARAMLIST ']' { 
			$$ = (ExtetricksSType)malloc(sizeof(xtetricksSType));
			$$->value.StringValue = (char*)malloc(1024*sizeof(char));
			sprintf($$->value.StringValue, "%s(%s%s)", $3->value.StringValue, $5->value.StringValue, $6->value.StringValue);
			// printf("EXPR -> '[' CALL ID WITH PARAM PARAMLIST ']'\n"); 
		}
		;
	
ARITHLOGIC : TERM ARITH1 {
				$$ = (ExtetricksSType)malloc(sizeof(xtetricksSType)); 
				$$->value.StringValue = (char*)malloc(1024*sizeof(char)); 
				sprintf($$->value.StringValue, "%s%s", $1->value.StringValue, $2->value.StringValue); 
				// printf("ARITHLOGIC -> TERM ARITH1: %s\n", $$->value.StringValue); 
			}
			;
	
TERM : FACTOR TERM1 {
			$$ = (ExtetricksSType)malloc(sizeof(xtetricksSType)); 
			$$->value.StringValue = (char*)malloc(1024*sizeof(char)); 
			sprintf($$->value.StringValue, "%s%s", $1->value.StringValue, $2->value.StringValue); 
			// printf("TERM -> FACTOR TERM1: %s\n", $$->value.StringValue); 
		};
	
ARITH1 : '+' TERM ARITH1 {
			$$ = (ExtetricksSType)malloc(sizeof(xtetricksSType)); 
			$$->value.StringValue = (char*)malloc(1024*sizeof(char)); 
			sprintf($$->value.StringValue, " + %s%s", $2->value.StringValue, $3->value.StringValue); 
			// printf("ARITH1 -> '+' TERM ARITH1: %s\n", $$->value.StringValue); 
		}
		| '-' TERM ARITH1 {
			$$ = (ExtetricksSType)malloc(sizeof(xtetricksSType)); 
			$$->value.StringValue = (char*)malloc(1024*sizeof(char)); 
			sprintf($$->value.StringValue, " - %s%s", $2->value.StringValue, $3->value.StringValue); 
			// printf("ARITH1 -> '-' TERM ARITH1\n"); 
			}
		| '>' TERM ARITH1 {
			$$ = (ExtetricksSType)malloc(sizeof(xtetricksSType)); 
			$$->value.StringValue = (char*)malloc(1024*sizeof(char)); 
			sprintf($$->value.StringValue, " > %s%s", $2->value.StringValue, $3->value.StringValue); 
			// printf("ARITH1 -> '>' TERM ARITH1\n"); 
			}
		| '<' TERM ARITH1 {
			$$ = (ExtetricksSType)malloc(sizeof(xtetricksSType)); 
			$$->value.StringValue = (char*)malloc(1024*sizeof(char)); 
			sprintf($$->value.StringValue, " < %s%s", $2->value.StringValue, $3->value.StringValue); 
			// printf("ARITH1 -> '<' TERM ARITH1\n"); 
			}
		| OR TERM ARITH1 {
			$$ = (ExtetricksSType)malloc(sizeof(xtetricksSType)); 
			$$->value.StringValue = (char*)malloc(1024*sizeof(char)); 
			sprintf($$->value.StringValue, " || %s%s", $2->value.StringValue, $3->value.StringValue); 
			// printf("ARITH1 -> OR TERM ARITH1\n"); 
			}
		| {
			$$ = (ExtetricksSType)malloc(sizeof(xtetricksSType)); 
			$$->value.StringValue = (char*)malloc(1024*sizeof(char)); 
			strcpy($$->value.StringValue, "");
			// strcpy($$->value.StringValue, ""); printf("ARITH1 -> #\n"); 
			};
	
FACTOR : ID {$$ = (ExtetricksSType)malloc(sizeof(xtetricksSType)); $$->value.StringValue = (char*)malloc(1024*sizeof(char)); strcpy($$->value.StringValue, $1->value.StringValue); 
				// printf("FACTOR -> ID\n"); 
				}
			| NUM {$$ = (ExtetricksSType)malloc(sizeof(xtetricksSType)); $$->value.StringValue = (char*)malloc(1024*sizeof(char)); strcpy($$->value.StringValue, $1->value.StringValue); 
					// printf("FACTOR -> NUM: %s\n", $$->value.StringValue); 
					}
			| '(' EXPR ')' {$$ = (ExtetricksSType)malloc(sizeof(xtetricksSType)); $$->value.StringValue = (char*)malloc(1024*sizeof(char)); sprintf($$->value.StringValue, "(%s)", $2->value.StringValue); 
								// printf("FACTOR -> '(' EXPR ')'\n"); 
								}
			| '(' NEG EXPR ')' { 
				$$ = (ExtetricksSType)malloc(sizeof(xtetricksSType));
				$$->value.StringValue = (char*)malloc(1024*sizeof(char));
				sprintf($$->value.StringValue, "(-%s)", $3->value.StringValue);
				// printf("FACTOR -> '(' NEG EXPR ')'\n"); 
				} 
			| '(' NOT EXPR ')' {$$ = (ExtetricksSType)malloc(sizeof(xtetricksSType)); $$->value.StringValue = (char*)malloc(1024*sizeof(char)); sprintf($$->value.StringValue, "(!%s)", $2->value.StringValue); 
				// printf("FACTOR -> '(' NOT EXPR ')'\n"); 
			};
	
TERM1 : '*' FACTOR TERM1 {$$ = (ExtetricksSType)malloc(sizeof(xtetricksSType)); $$->value.StringValue = (char*)malloc(1024*sizeof(char)); sprintf($$->value.StringValue, " * %s%s", $2->value.StringValue, $3->value.StringValue); 
			// printf("TERM1 -> '*' FACTOR TERM1\n"); 
			}
			| AND FACTOR TERM1 {$$ = (ExtetricksSType)malloc(sizeof(xtetricksSType)); $$->value.StringValue = (char*)malloc(1024*sizeof(char)); sprintf($$->value.StringValue, " && %s%s", $2->value.StringValue, $3->value.StringValue); 
				// printf("TERM1 -> AND FACTOR TERM1\n"); 
			}
			| {$$ = (ExtetricksSType)malloc(sizeof(xtetricksSType)); $$->value.StringValue = (char*)malloc(1024*sizeof(char)); strcpy($$->value.StringValue, ""); 
				// printf("TERM1 -> #\n"); 
			};
	
PARAM : ID '=' EXPR { 
			$$ = (ExtetricksSType)malloc(sizeof(xtetricksSType));
			$$->value.StringValue = (char*)malloc(1024*sizeof(char));
			sprintf($$->value.StringValue, "%s = %s", $1->value.StringValue, $3->value.StringValue);
			// printf("PARAM -> ID '=' EXPR\n"); 
		}
		;
	
PARAMLIST : PARAM PARAMLIST { 
				$$ = (ExtetricksSType)malloc(sizeof(xtetricksSType));
				$$->value.StringValue = (char*)malloc(1024*sizeof(char));
				sprintf($$->value.StringValue, ", %s%s", $1->value.StringValue, $2->value.StringValue);
				// printf("PARAMLIST -> PARAM PARAMLIST\n"); 
			}
			| { 
				$$ = (ExtetricksSType)malloc(sizeof(xtetricksSType));
				$$->value.StringValue = (char*)malloc(1024*sizeof(char));
				strcpy($$->value.StringValue, "");
				// printf("PARAMLIST -> #\n"); 
			};
%%
	
int main(int argc, char *argv[])
{
yyparse();
return 0;
}