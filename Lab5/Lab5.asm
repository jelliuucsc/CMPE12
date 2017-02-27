;Jerry Liu
;CMPE 12/12L
;Lab 5
;Section:2 TA:Priyesh

	.ORIG x3000

START
	AND 	R0,R0,0		;Clears all data in registers
	AND 	R1,R1,0
	AND 	R2,R2,0
	AND 	R3,R3,0
	AND 	R4,R4,0
	AND 	R5,R5,0	
	AND 	R6,R6,0
	AND 	R7,R7,0
	
	LEA	R0, MSG1	;Greets the user
	PUTS
MSG	
	
	AND 	R0,R0,0		;Clears all data in registers
	AND 	R1,R1,0
	AND 	R2,R2,0
	AND 	R3,R3,0
	AND 	R4,R4,0
	AND 	R5,R5,0	
	AND 	R6,R6,0
	AND 	R7,R7,0
	LEA	R0, MSG2	;Asks user for input
	PUTS
	

INT
	GETC			;Gets the integer inside R0	
	PUTC			
	
	
	AND	R1, R1, 0		;CLEARS R1 to 0
	LD	R1, LF		;LD LineFeed check to R1
	LD	R3, COUNTER
	
	ADD	R1, R0, R1	;Checking if LF + R0 = 0
	BRz	PARTA		;if Zero, go to Part A
Signed	
	AND	R1, R1, 0	;Clears R1
	LD	R1, NEGATIVE	;Loads -45 + R0 = 0
	ADD	R1, R0, R1	;Checks if "-"
	BRz	FLAG		;If zero, go to FLAG
	
Quit	
	LD	R1, X		;Sets X ascii value into X
	ADD	R1, R0, R1	;Adds X with R0 
	BRz	END		;If zero, End

Conv			
	LD	R1, ASCII	;Loads ASC(-48) into R1
	LD	R2, ten		;Loads counter 10 into R2
	
	ADD	R5, R0, R1	;Converts from ascii to decimal
	AND	R4, R4, 0
	BR 	MULT10

				
END	HALT			;ends the program
	
FLAG
	AND     R7, R7, 0
	AND    	R1, R1, 0		;loads 1 into R1
	ADD 	R1, R7, 1
	ST	R1, flag	;Loads Flag into R1
	BR	INT		;goes to INT

MULT10
	ADD R4 ,R4 , R6		;multiplies/ adds 10 times to int
	ADD R2, R2, -1 		;COUNTER	
	BRp MULT10		;checks
	ADD R6, R4, R5		;Int = int + digit
	BR  INT			;Goes to INT
Print1
	LEA R0, Bit0		;prints out 0
	PUTS
	BR LOOP
Print2 
	LEA R0, Bit1          ;prints out 1
	PUTS
	BR LOOP
FLAGTRUE
	NOT R6, R6		;checks if negative
	ADD R6, R6, 1
	BR PARTB
	
PARTA	
	LD  R1, flag
	ADD R1, R1, -1
	BRz FLAGTRUE
	BR PARTB

PARTB	
	LEA	R1, MASK
	ST	R1, MASKptrs
Msk
	LDI	R5, MASKptrs	;Checks the MASKptrs
	AND 	R2, R6, R5
	BRz  	Print1
	BRp	Print2
LOOP

	ADD 	R1, R1,1
	ST	R1, MASKptrs
	ADD 	R3, R3, -1	
	BRp	Msk
	LEA	R0, NEWLINE
	PUTS
	BR	MSG

flag	 .FILL	0		;Flag starts at zero
ten	 .FILL	10		;Counter
int	 .FILL	0		
NEGATIVE .FILL	-45		; Checks if it was negative
LF	 .FILL	-10		; Checks linefeed
ASCII	 .FILL	-48		; Saved variable to subtract ascii value
X	 .FILL	-120		; Checks the ascii value for x
COUNTER  .FILL  16		; Counters for the Masking
MASKptrs .FILL 0
MASK				;Mask locations 
	.FILL	x8000	
	.FILL	x4000	
	.FILL	x2000	
	.FILL	x1000	
        .FILL	x0800	
	.FILL	x0400	
	.FILL	x0200	
	.FILL	x0100	
	.FILL	x0080	
	.FILL	x0040	
	.FILL	x0020
	.FILL	x0010	
	.FILL	x0008	
	.FILL	x0004
	.FILL	x0002
	.FILL	x0001	
	
MSG1	.STRINGZ "Welcome to Jerry's Decimal Conversion Program...\n"
MSG2 	.STRINGZ "Enter a decimal number or X to quit: \n>"
NEWLINE	.STRINGZ "\n"
Bit0	.STRINGZ "0"
Bit1	.STRINGZ "1"
	.END
