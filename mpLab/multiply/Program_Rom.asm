#include <p16Lf1826.inc>

a_val	equ	0x25
c_val	equ	0x24

count1 equ h'20'
count2 equ h'21'
count3 equ h'22'
answer	equ	0x23
;****************START
		org	0x00
		clrf a_val
		clrf c_val
		clrf answer
		movlw .5		
		movwf a_val
		movlw .6	
		movwf c_val
loop	addwf answer,1
		decfsz a_val,1
		bra loop
		movf answer,0
		movwf PORTB
		
		
		

delay	movlw .30
		movwf count1
delay1	clrf count2
delay2	clrf count3
delay3	decfsz count3,1
		goto delay3
		decfsz count2,1
		goto delay2
		decfsz count1,1
		goto delay2
		return
		end	
