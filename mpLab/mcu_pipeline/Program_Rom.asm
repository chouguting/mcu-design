#include <p16Lf1826.inc>

hour	equ	0x21
minute	equ	0x22

hour_temp	equ	0x23
minute_temp	equ	0x24
temp 	equ	0x25
temp1 	equ	0x26
temp2 	equ	0x27
temp3 	equ	0x28
temp4 	equ	0x29
;-------START----------------
		org 0x00
		clrf hour
		clrf minute
start	clrf hour_temp
		clrf minute_temp
		movlw .24
		movwf temp	
loop1	movlw .10
		movwf temp1
loop2		movlw .6
			movwf temp2
			clrf minute_temp
loop3			movlw .10
				movwf temp3
loop4				movf minute_temp,0	;���h��s�ɶ���T
					movwf minute
					movf hour_temp,0
					movwf hour
					incf minute_temp,1   ;�������Ӧ�ƥ[�@
					decfsz temp3,1
					bra loop4
				swapf minute_temp,1	 ;�������Q��ƥ[�@
				incf minute_temp,1	; (���洫�Q��ƩM�Ӧ�ơA�[�@�A�A���^��)
				swapf minute_temp,1
				movlw 0xf0
				andwf minute_temp,1
				decfsz temp2,1
				bra loop3		
			incf hour_temp,1	 ;�p�ɪ��Ӧ�ƥ[�@
			decfsz temp,1	;�p�G�p�ɤw�g�ƨ�23�A�N���X�j���start(���s�}�l)
			bra continue	
			bra start	
continue	clrf minute_temp
			decfsz temp1,1
			bra loop2
		swapf hour_temp,1	;�p�ɪ��Q��ƥ[�@
		incf hour_temp,1	; (���洫�Q��ƩM�Ӧ�ơA�[�@�A�A���^��)
		swapf hour_temp,1
		movlw 0xf0
		andwf hour_temp,1
		movf hour_temp,0
		movwf hour
		bra loop1
		end

