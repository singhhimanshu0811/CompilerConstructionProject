build: 
	bison -d -r all grammar.y ; flex lexer.l ;  
	gcc extetrickstype.c lex.yy.c grammar.tab.c;./a.out < testinput.tetris 2>/dev/null > output.py;
	python3 output.py