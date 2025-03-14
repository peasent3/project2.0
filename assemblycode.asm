;
; Lab10.asm
;
; Created: 11/25/2024 1:49:29 PM
; Author : kinji
;
; Replace with your application code

.EQU BUSON = $80
.EQU VAL = $96 
.EQU ADR = $2000 ; adress specified
.EQU NUL = 0

.cseg
reset: rjmp start
.org $16

start:
	ldi r16, low(ramend) ; initialzies ramend in ordet to use subroutines
	out spl, r16
	ldi r16, high(ramend)
	out sph, r16 

init_bus:
	LDI R17, BUSON ; initializes bus
	OUT MCUCR, R17

init_start:
	clr r21
	del40:
		ldi r25, $00
		ldi r24, $CB ; hex value to loop to achieve 1 ms
		rcall delms
		inc r21
		cpi r21, 40
		brne del40
		clr r21

	ldi r17, $38 ;function set to write on the first line of lcd
	sts ADR, r17
	rcall del37
	
	ldi r17, $0F ;function set
	sts ADR, r17
	rcall del37

ldi r25, $1D
ldi r24, $B0 ; hex value for loops to achieve 1.52 ms

	ldi r17, $01 ; clears the lcd
	sts ADR, r17
	rcall delms

	ldi r17, $06
	sts ADR, r17
	rcall del37

	rcall init_msg
	rcall loopmsg


next_line:
	clr r21
	del41:
		ldi r25, $00
		ldi r24, $CB ; hex value to loop to achieve 1 ms
		rcall delms ; this loops 1ms 40 times to achieve 40ms
		inc r21
		cpi r21, 40
		brne del41
		clr r21

	ldi r17, $C0 ;function set to go to the next line of lcd
	sts ADR, r17
	rcall del37

	
	ldi r17, $0F ;function set
	sts ADR, r17
	rcall del37

	rcall init_msg1
	rcall loopmsg

check:
	in r18, PINB ; reads PINB to switch between ndoe and spvis
	andi r18, $01
	cpi r18, $01
	breq next_line2
	rjmp check

next_line2:

	ldi r17, $C0 ;function set to go to the next line of lcd
	sts ADR, r17
	rcall del37

	ldi r17, $0F ;function set
	sts ADR, r17
	rcall del37

	rcall init_msg2
	rcall loopmsg

	check2:
	in r18, PINB ; reads PINB to switch between ndoe and spvis
	andi r18, $01
	cpi r18, $00
	breq next_line
	rjmp check2

fini: rjmp fini

delms:
	nop
	sbiw R25:R24, 1 ;loop a number of times initialzied prior to rcall
	brne delms
	ret

del37: 
	inc r21
	cpi r21, 37; increment 37 times, 1 us each
	brne del37 ;
	clr r21 ; clears register for next rcall
	ret

init_msg:
	ldi r30, low(msg<<1) ; initializes msg array to z
	ldi r31, high(msg<<1)
	ret 
init_msg1:
	ldi r30, low(msg1<<1) ; initializes msg array to z
	ldi r31, high(msg1<<1)
	ret
init_msg2:
	ldi r30, low(msg2<<1) ; initializes msg array to z
	ldi r31, high(msg2<<1)
	ret 

loopmsg:
	lpm r17, Z+
	cpi r17, NUL
	breq end
	rcall lcd_puts
	rjmp loopmsg
	ret

end:
	ret


lcd_puts:
	ldi r25, $13
	ldi r24, $88 
	rcall delms ; this is a 1 ml second delay for every character outputed
	sts $2100, r17 ; outputs the character stored in r17
	ret

msg: .db "Recon Bot 1.0",NUL
msg1: .db "Standby ",NUL
msg2: .db "Power On",NUL