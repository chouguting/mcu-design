#include <p16Lf1826.inc>

a_val	equ	0x25
c_val	equ	0x24
answer	equ	0x23

temp	equ 0x27
return_val equ 0x28
a_pram	equ	0x29
c_pram	equ	0x2A
func_temp equ	0x2B
func_count	equ 0x2C

;****************START
		org	0x00
		clrf a_val  ;a=0
		clrf c_val	;c=0
		clrf temp	;temp=0
		movlw .7		
		movwf a_val  ;a=7
		movlw .29	
		movwf c_val  ;c=29
loop	movf a_val,0
		movwf a_pram  
		movf c_val,0
		movwf c_pram  ;fuction call mod(a,c) 
		call mod
		movf return_val,0 ;w=mod(a,c) 
		movwf temp ;temp=w (temp=a%c)
		movf c_val,0  
		movwf a_val ;a=c
		movf temp,0 
		movwf c_val ;c=temp

		movf c_val,0
		movwf temp	;temp=c (這行不必要)
		decf temp,1 ;w--
		btfss temp,7 ;if(w<0) break
		goto loop
		movf a_val,0
		movwf PORTB  ;cout<<answer
		goto $
		

		;function mod(a_pram,c_pram) return return_val
mod		clrf func_count
		movf c_pram,0
		subwf a_pram,1  ;a=a-c
		incf func_count,1  ;count++
		btfss a_pram,7  ;if(a<0) jump 1
		bra mod
		decf func_count,1  ;count--
		clrf func_temp	;temp=0
		movf a_pram,0		;w=a
		subwf func_temp,1	;temp=temp-w  (0-a)
		movf func_temp,0		;w=temp
		subwf c_pram,0  ;w=c-temp
		movwf return_val    ;cout << count
		return		
		end	
