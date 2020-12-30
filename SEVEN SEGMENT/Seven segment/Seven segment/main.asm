;
; mimo.asm
;
; Created: 23/12/2020 8:11:29 PM
; Author : Lenovo
;


; Replace with your application code
main:

LDI R20, 0xFF // set bit all to 1
OUT DDRD, R20 // set all portD as OUTPUT
CBI DDRC, 1 // set pin A1 as input (DRY)
CBI DDRC, 2 // set pin A2 as input (FOOD)

// initializing register for seven segment display
LDI R21, 0b01011110 // initialize value 0b01011110 inside R21  // display "d" , PORTD
LDI R22, 0b10110000 // display "r" , PORTD
LDI R23, 0b01101110 //display "y" , PORTD
LDI R25, 0b11110000 // display "F"
LDI R26, 0b10111111 // display "O"
LDI R16, 0x00


loop:

SBIC PINC, 1 // skip next line if A1 is clear
RJMP DRY // go to subroutine DRY to display dry
SBIC PINC, 2 //skip next line if A2 is clear
RJMP FOOD // go to subroutine FOOD to display food
RJMP loop
RJMP main

// run if pushButton 1 is set 
DRY:
	OUT PORTD, R21 // send the contents of R21 out from portD // display "d" , PORTD
	CALL DELAY
	OUT PORTD, R22 // display "r"
	CALL DELAY
	OUT PORTD, R23 // display "y"
	CALL DELAY
	OUT PORTD, R16 // OFF seven segment
	JMP loop

// run if pushButton 2 is set
FOOD:
	OUT PORTD, R25 // display "F"
	CALL DELAY
	OUT PORTD, R26 // display "O"
	CALL DELAY
	OUT PORTD, R16 // clear seven segment
	CALL DELAY
	OUT PORTD, R26   // display "O"
	CALL DELAY
	OUT PORTD, R21 // send the contents of R21 out from portD // display "d" , PORTD
	CALL DELAY
	OUT PORTD, R16 //  OFF seven segment
	JMP loop

DELAY:
	LDI R18, 50
	LDI R19, 40
	LDI R16, 10
L1:
   DEC R16
   BRNE L1
   DEC R19
   BRNE L1
   DEC R18
   BRNE L1
   NOP
   RET

