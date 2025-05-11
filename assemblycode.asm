;
; AssemblerApplication3.asm
<<<<<<< HEAD
=======
;
; Created: 1/21/2025 11:26:45 AM
; Author : 1933124
;
; Replace with your application code

;
; Lab10.asm
>>>>>>> 9da6e9a0b7477aacbbbc52c50b9393cf9050b925
;
; Created: 1/21/2025 11:26:45 AM
; Author : 1933124
;
; Replace with your application code
.EQU BUSON = $80
.EQU VAL = $96 
.EQU ADR = $3000 ; adress specified
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

	clr r21
	del1s://delay
		ldi r25, $1E
		ldi r24, $C8 ; hex value to loop to achieve time delay
		rcall delms
		inc r21
		cpi r21, 40
		brne del1s
		clr r21	

	ldi r17, $01 ; clears the lcd
	sts ADR, r17
	rcall delms

	ldi r17, $06
	sts ADR, r17
	rcall del37

	rcall init_msg3
	rcall loopmsg

	init_check:
	in r18, PINE ; reads PINE to switch between standby and connected
	andi r18, $01

<<<<<<< HEAD
	cpi r18, $01 ;If high, connected message
	breq connectedmsg

	cpi r18, $00 ; if low, standby message
=======
	cpi r18, $01
	breq connectedmsg

	cpi r18, $00
>>>>>>> 9da6e9a0b7477aacbbbc52c50b9393cf9050b925
	breq standbymsg

	rjmp init_check

standbymsg:
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

<<<<<<< HEAD
	ldi r17, $00 ; stopsn the car by force durring standby
=======
	ldi r17, $00 ; stopsn the car by force
>>>>>>> 9da6e9a0b7477aacbbbc52c50b9393cf9050b925
	out PORTD, r17

check:
	in r18, PINE ; reads PINE to switch between standby and connected
	andi r18, $01
	cpi r18, $01
	breq connectedmsg
	rjmp check

connectedmsg:
	clr r21
	del42:
		ldi r25, $00
		ldi r24, $CB ; hex value to loop to achieve 1 ms
		rcall delms ; this loops 1ms 40 times to achieve 40ms
		inc r21
		cpi r21, 40
		brne del42
		clr r21

	ldi r17, $C0 ;function set to go to the next line of lcd
	sts ADR, r17
	rcall del37

	ldi r17, $0F ;function set
	sts ADR, r17
	rcall del37

	rcall init_msg2
	rcall loopmsg

	connected:
	in r16, PINB ; Continues to read input 
	andi r16, $0F

	in r18, PINE ; reads PINE to switch between standby and connected
	andi r18, $01
	cpi r18, $00
	breq standbymsg
 
	cpi r16, 1 ; checks if D0 is high
	breq forward

	cpi r16, 2 ; checks if D1 is high
	breq left


	cpi r16, 4 ; checks if D2 is high
	breq right


	cpi r16, 8 ; checks if D3 is high
	breq back

	ldi r17, $00 ; stopsn the car
	out PORTD, r17

	rjmp connected

	forward:
		ldi r17, $0A ; Turns the car forward
		out PORTD, r17
		rjmp connected

	left:
		ldi r17, $06 ; turns car left
		out PORTD, r17
		rjmp connected

	right:
		ldi r17, $09 ; turns car right
		out PORTD, r17
		rjmp connected

	back:
		ldi r17, $05 ; turns car back
		out PORTD, r17
		rjmp connected

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
init_msg3:
	ldi r30, low(msg3<<1) ; initializes msg array to z
	ldi r31, high(msg3<<1)
	ret 
<<<<<<< HEAD
loopmsg: ; function to output message to lcd
=======
loopmsg:
>>>>>>> 9da6e9a0b7477aacbbbc52c50b9393cf9050b925
	lpm r17, Z+
	cpi r17, NUL
	breq end
	rcall lcd_puts
	rjmp loopmsg
	ret

end:
	ret

lcd_puts: ; outputs one letter at a time to the lcd
	ldi r25, $13
	ldi r24, $88 
	rcall delms ; this is a 1 ml second delay for every character outputed
	sts $2100, r17 ; outputs the character stored in r17
	ret

msg: .db "Recon Bot 1.0",NUL
msg1: .db "Stand by ",NUL
msg2: .db "Connected",NUL
msg3: .db "Status:",NUL