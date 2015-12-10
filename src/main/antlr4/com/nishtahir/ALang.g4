grammar ALang;

compilationUnit
    :   statements EOF
    ;

statement
    :   assignment
    |   forLoop
    |   ifStatement
    |   printStatement
    ;

statements
    : statement*
    | '{' statement* '}'
    ;

ifStatement
    : 'if' expression statements ('else' statements)?
    ;

assignment
    :   Identifier ':=' expression      #identifierAssignment
    |   index      ':=' expression      #indexAssignment
    ;

// for (i := 1 ~ 10)
forLoop
    : 'for' '('Identifier ':=' range ')' statements
    ;


range
    :   expression RNG expression
    ;

printStatement
    :   'print'   ('(' parameter ')' | parameter )    #print
    |   'println' ('(' parameter ')' | parameter )    #printLine
    ;

parameter
    : literal
    | expression
    | Identifier
    ;

expression
    :   expression op=(INCR|DECR)               #exprIncrDecr
    |   expression op=(MULT|DIV) expression     #exprMultDiv
    |   expression op=(ADD|SUB) expression      #exprAddSub
    |   expression op=('>' | '<' | '=') expression          #exprBoolean
    |   op=(MIN | MAX) '(' expression ',' expression ')'    #exprMinMax
    |   SWAP '(' expression ',' expression ')'              #exprSwap
    |   '(' expression ')'                  #exprBracket
    |   expressionList                      #exprList
    |   index                               #exprIndex
    |   literal                             #literalExpression
    |   Identifier                          #identifierExpression
    ;

INCR    :   '++';
DECR    :   '--';
MULT    :   '*' ;
DIV     :   '/' ;
ADD     :   '+' ;
SUB     :   '-' ;

GTR     :   '>' ;
LESS    :   '<' ;
EQL     :   '=' ;
NEQL    :   '!=';

RNG     :   '~' ;
MIN     :   'min'|'MIN';
MAX     :   'max'|'MAX';
SWAP    :   'swap'|'SWAP';
expressionList
    :   '[' expression (',' expression)* ']'
    ;

index
    :   Identifier '^' expression
    ;

literal
    :   NumberLiteral               #literalNumber
    |   StringLiteral               #literalString
    |   Identifier                  #literalIdentifier
    ;

Identifier
    :   LETTERS (LETTERS|NumberLiteral)*
    ;

StringLiteral
    :   '"' StringCharacters? '"'
    ;

fragment
StringCharacters
    :   StringCharacter+
    ;

fragment
StringCharacter
    :   ~["\\]
    ;

LETTERS
    :   [a-zA-Z]+
    ;

NumberLiteral
    :   [0-9]+
    ;

WS  :  [ \n\r\t\u000C]+ -> skip
    ;

LINE_COMMENT
    :  '#'  ~[\r\n]* -> skip
    ;
