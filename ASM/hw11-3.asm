#include <p16Lf1826.inc>

minute	equ	0x21
second	equ	0x22

minute_temp	equ	0x23
second_temp	equ	0x24
temp 	equ	0x25
temp1 	equ	0x26
temp2 	equ	0x27
temp3 	equ	0x28
;-------START----------------
		org 0x00
		clrf minute
		clrf second
start	clrf minute_temp
		clrf second_temp
		movlw .6
		movwf temp	
loop1	movlw .10
		movwf temp1
loop2		movlw .6
			movwf temp2
			clrf second_temp
loop3			movlw .10
				movwf temp3
loop4				movf second_temp,0
					movwf second
					movf minute_temp,0
					movwf minute
					incf second_temp,1
					decfsz temp3,1
					bra loop4
				swapf second_temp,1
				incf second_temp,1
				swapf second_temp,1
				movlw 0xf0
				andwf second_temp,1
				decfsz temp2,1
				bra loop3		
			incf minute_temp,1
			clrf second_temp
			decfsz temp1,1
			bra loop2
		swapf minute_temp,1
		incf minute_temp,1
		swapf minute_temp,1
		movlw 0xf0
		andwf minute_temp,1
		movf minute_temp,0
		decfsz temp,0
		movwf minute
		decfsz temp,1
		bra loop1
		bra start
		end