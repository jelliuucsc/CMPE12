;Jerry Liu
;3/11/16
;SECTION:2   TA:Priyesh
.ORIG x3000

START
	AND 	R0,R0,0		;Clears all data in registers
	AND 	R1,R1,0
	AND 	R2,R2,0
	AND 	R3,R3,0
	AND 	R4,R4,0
	AND 	R5,R5,0	
	AND 	R6,R6,0
MSG1		.STRINGZ	 "Welcome to Jerry's Ceaser Cypher Program...\n"
MSG2 		.STRINGZ	 "Do you want to (E)ncrypt or D(ecrypt) or E(X)it?\n"
MSG3		.STRINGZ	 "Please select a relevant option.\n"
MSG4		.STRINGZ	 "What is the cipher (1-25)?\n"
MSG5		.STRINGZ	 "What is the string(up to 200 characters)?\n"
MSG6		.STRINGz	 "<Decrypted>"
MSG7		.STRINGZ	 "<Encrypted>"
NEWLINE		.STRINGZ	 "\n"
GREET
	LEA	R0, MSG1	;greets the user
	PUTS
	
EDX
	
	AND 	R0,R0,0		;Clears all data in registers
	AND 	R1,R1,0
	AND 	R2,R2,0
	AND 	R3,R3,0
	AND 	R4,R4,0
	AND 	R5,R5,0	
	AND 	R6,R6,0

	LD	R1, Dflag
	AND	R1, R1, 0
	ST	R1, Dflag
	LEA	R0, MSG2	;asks user if they want to encrypt, decrypt or exit program
	PUTS
	
	GETC
	PUTC

	LD	R1, X		;Loads X into R1
	ADD	R1, R0, R1	;Checks if it equals X
	BRz	EXIT		;If x, exit program
	LD	R1, D		;Loads D into R1
	ADD	R1, R0, R1	;Checks if it equals D
	BRz	STOREd	
	LD	R1, E		;Loads E into R1
	ADD	R1, R0, R1	;Checks if it equals E
	BRz	STOREe
	
	BR	INVALID

INVALID
	LEA	R0, NEWLINE
	PUTS
	LEA	R0, MSG3	;asks user to choose another option
	BR	EDX

STOREd	
	ADD	R1, R1, 1
	ST 	R1, Dflag	;Dflag counter is 1(Decrypt)
	BR	CIPHERM
STOREe

	ST 	R1, Dflag	;Dflag counter is 0(Encrypt)

CIPHERM
	LEA	R0, NEWLINE
	PUTS
	LEA	R0, MSG4
	PUTS
CIPHER
	GETC
	PUTC

	LD	R1, 0		;CLEARS R1 to 0
	LD	R1, LF		;LD LineFeed check to R1
	ADD	R1, R0, R1	;Checking if LF + R0 = 0
	BRz	STRING
	LD	R2, ASCII
	ADD	R3, R2, R0	;converts from ascii to a number
	ADD	R6, R6, 10	;Mult10 counter

MULT10
	ADD	R4, R4, R5
	ADD	R6, R6, -1	;decreases Mult10 counter
	BRp 	MULT10		;loop 10 times
	ADD     R5, R3, R4	;Int = digit +int
	ST	R5, CIPHERn	;stores the cipher number for later use
	BR	CIPHER		;goes back to CIPHER method

STRING
	LEA  	R0, MSG5
	PUTS
	
	LD	R3, length
	LEA	R6, ARRAY
	LD 	R2, COUNTER
	
	
STRINT	
	
	GETC
	PUTC	
	
	LD	R1, 0		;CLEARS R1 to 0
	LD	R1, LF		;LD LineFeed check to R1
	ADD	R1, R0, R1	;Checking if LF + R0 = 0
	BRz	PRINT
	ADD	R5, R6, R3	;points to row1
	STR 	R0, R6, 0	;store char into row0
	JSR	CODE
	STR	R0, R5, 0       ;stores encrypted/decrypted char into row1
	ADD	R6, R6, 1	;increment index
	
	ADD R2, R2, 1     	;counts how many characters input into string
	BR	STRINT

PRINT
	ST	R2, COUNTER	;store number of characters in string
	AND 	R0,R0,0		;Clears all data in registers
	AND 	R1,R1,0
	AND 	R2,R2,0
	AND 	R3,R3,0
	AND 	R4,R4,0
	AND 	R5,R5,0	
	AND 	R6,R6,0
	
	LD	R1, Dflag
	BRz	DMSG
	BRp	EMSG
DMSG
	LEA	R0, MSG6
	PUTS
	BR	LOADARR1
EMSG	
	LEA	R0, MSG7
	PUTS
	BR	LOADARR1

LOADARR1
	LEA	R6, ARRAY
	LD	R2, COUNTER	
PRINTROW0
	
	LDR 	R0, R6, 0
	ADD	R6, R6, 1	
	PUTC
	ADD	R2, R2, -1
	BRp	PRINTROW0
	LEA	R0, NEWLINE
	PUTS
	
LOADARR2
	LEA	R6, ARRAY
	LD	R3, length
	LD	R2, COUNTER
	LD	R1, Dflag
	BRz	EM
	BRp	DM	
PRINTROW1
	
	ADD	R5, R6, R3
	LDR	R0, R5, 0
	ADD	R6, R6, 1	
	PUTC
	ADD	R2, R2, -1
	BRp	PRINTROW1
	LEA	R0, NEWLINE
	PUTS
	BR	EDX
EM
	LEA 	R0, MSG7
	PUTS
	BR	PRINTROW1
DM	
	LEA 	R0, MSG6
	PUTS
	BR	PRINTROW1
EXIT	HALT
	
CODE
	LD 	R1, UCASEL
	ADD	R4, R0, R1		
	BRn	ENDCODE		;checks lower bound of upper case
	LD	R1, UCASEH	
	ADD	R4, R0, R1
	BRnz	DOUCODE		;checks upper bound of upper case
	LD 	R1, LCASEL
	ADD	R4, R0, R1		
	BRn	ENDCODE		;checks lower bound of lower case
	LD	R1, LCASEH	
	ADD	R4, R0, R1
	BRnz	DOLCODE		;checks upper bound of lower case
	BR	ENDCODE
DOLCODE
	LD	R4, CIPHERn
	LD	R1, Dflag
	BRz	ENCRYPTL		
	ADD	R0, R4, R0	;decrypts if lower bound
	LD 	R1, LCASEH	
	ADD	R4, R0, R1
	BRp	STOREUP		;checks if it is lower case z
	BR	ENDCODE
DOUCODE
	
	LD	R4, CIPHERn
	LD	R1, Dflag
	BRz	ENCRYPTU		
	ADD	R0, R4, R0	;decrypts if lower bound
	LD 	R1, UCASEH	
	ADD	R4, R0, R1
	BRp	STOREUP		;checks if it is upper case Z
	BR	ENDCODE
 	
STOREUP
	LD	R4, ALPHABET
	ADD	R0, R0, R4
	BR	ENDCODE
STORELOW
	LD	R4, ALPHABET
	ADD	R0, R0, R4
	BR	ENDCODE

ENCRYPTL
	NOT	R4, R4		;1's comp
	ADD	R4, R4, 1	;2's comp to make encrypted msg negative
	ADD	R0, R4, R0	;decrypts if lower bound
	LD 	R1, LCASEL	
	ADD	R4, R0, R1
	BRn	STORELOW	;checks if it is lower case a
	BR	ENDCODE

ENCRYPTU
	NOT	R4, R4		;1's comp
	ADD	R4, R4, 1	;2's comp to make encrypted msg negative
	ADD	R0, R4, R0	;decrypts if lower bound
	LD 	R1, UCASEL	
	ADD	R4, R0, R1
	BRp	STORELOW		;checks if it is upper case A
	BR	ENDCODE
ENDCODE	RET


X		.FILL		 -88
D		.FILL		 -68
E		.FILL		 -69
ASCII		.FILL		 -48
Dflag		.FILL		   0
Eflag		.FILL		   0
LF		.FILL		 -10
CIPHERn		.FILL 		   0
length		.FILL		 200
COUNTER		.FILL		   0

UCASEL 		.FILL 		 -65
UCASEH 		.FILL 		 -90
LCASEL 		.FILL 		 -97
LCASEH 		.FILL 		 -122

ALPHABET	.FILL		 -26

ARRAY		.BLKW		 400



	.END