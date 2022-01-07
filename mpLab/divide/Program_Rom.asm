#include <p16Lf1826.inc>

a_val	equ	0x25
c_val	equ	0x24
answer	equ	0x23
count	equ 0x26
temp	equ 0x27

count1 equ h'20'
count2 equ h'21'
count3 equ h'22'

;****************START
		org	0x00
		clrf a_val  ;a=0
		clrf c_val	;c=0
		;clrf answer	;ans=0
		clrf count	;count=0
		movlw 0x15		
		movwf a_val  ;a=21 (0x15)
		movlw .3	
		movwf c_val  ;c=3
loop	subwf a_val,1  ;a=a-c
		incf count,1  ;count++
		btfss a_val,7  ;if(a<0) jump 1
		bra loop
		decf count,1  ;count--
		movf count,0	
		movwf PORTB		;cout << count
		clrf temp	;temp=0
		movf a_val,0		;w=a
		subwf temp,1	;temp=temp-w  (0-a)
		movf temp,0		;w=temp
		subwf c_val,0  ;w=c-temp
		movwf PORTB    ;cout << count
		
		
		
		

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
