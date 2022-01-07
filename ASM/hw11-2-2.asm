#include <p16Lf1826.inc>

temp	equ	0x25
temp1	equ	0x24
clock_time equ	0x26

;****************START
		org	0x00
start	clrf clock_time
		movlw	.6
		movwf	temp
loop1	movlw	.10
		movwf	temp1
loop2		movf	clock_time,0
			movwf	PORTB
			incf	clock_time,1  ;�Ӧ�ƥ[�@
			decfsz 	temp1,1
			goto loop2
		swapf clock_time,1   ;�o�T���Q��ƥ[�@
		incf	clock_time,1  
		swapf clock_time,1
		movf clock_time,0
		andlw 0xf0		;��Ӧ���k�s
		movwf clock_time
		decfsz 	temp,1
		goto loop1
		goto start
		end