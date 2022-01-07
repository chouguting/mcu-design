#include <p16Lf1826.inc>

temp	equ	0x25
temp1	equ	0x24
clock_time equ	0x26

;****************START
		org	0x00
start	clrf clock_time
		movlw	.6
		movwf	temp
loop1	movf	clock_time,0
		movwf	PORTB
		movlw	.9
		movwf	temp1
loop2		incf	clock_time,1
			movf	clock_time,0
			movwf	PORTB
			decfsz 	temp1,1
			goto loop2
		swapf clock_time,1
		incf	clock_time,1
		swapf clock_time,1
		movf clock_time,0
		;andlw .240
		andlw 0xf0
		movwf clock_time
		decfsz 	temp,1
		goto loop1
		goto start

		end