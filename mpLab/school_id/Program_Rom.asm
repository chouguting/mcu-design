#include <p16Lf1826.inc>

temp	equ	0x25
temp1	equ	0x24
clock_time equ	0x26

count1 equ h'20'
count2 equ h'21'
count3 equ h'22'
temp2	equ	0x26
;****************START
		org	0x00
start	clrf PORTB
		movlw	.0	
		movwf	PORTB
		call delay
		movlw	.0	
		movwf	PORTB
		call delay
		movlw	.8	
		movwf	PORTB
		call delay
		movlw	.5	
		movwf	PORTB
		call delay
		movlw	.7	
		movwf	PORTB
		call delay
		movlw	.0	
		movwf	PORTB
		call delay
		movlw	.0	
		movwf	PORTB
		call delay
		movlw	.5	
		movwf	PORTB
		call delay
		goto start

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
