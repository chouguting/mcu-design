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
start	clrf clock_time
		movlw	.6		;?Q???q0??5
		movwf	temp
loop1	movlw	.10		;????q0??9
		movwf	temp1
loop2		movf	clock_time,0
			movwf	PORTB		;??X??r
			call delay
			incf	clock_time,1  ;????[?@
			decfsz 	temp1,1
			bra	loop2
		swapf clock_time,1   ;?o?T???Q???[?@
		incf	clock_time,1  
		swapf clock_time,1
		movf clock_time,0
		andlw 0xf0		;??????k?s
		movwf clock_time
		decfsz 	temp,1
		bra	 loop1
		bra	 start

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
