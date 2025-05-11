start: 
  clr r16

	main: 
	
	in r16, PINB ; Continues to read input 
	andi r16, $0F 

	cpi r16, 1 ; checks if D0 is high
	breq forward

	cpi r16, 2 ; checks if D1 is high
	breq left


	cpi r16, 4 ; checks if D2 is high
	breq right


	cpi r16, 8 ; checks if D3 is high
	breq back


	cpi r16, 8 ; checks if theres no inputs
	ldi r17, $00 ; stopsn the car
	out porta, r17

	rjmp main

	forward:
		ldi r17, $0A ; Turns the car forward
		out PORTA, r17
		rjmp main

	left:
		ldi r17, $06 ; turns car left
		out PORTA, r17
		rjmp main

	right:
		ldi r17, $09 ; turns car right
		out PORTA, r17
		rjmp main

	back:
		ldi r17, $05 ; turns car back
		out PORTA, r17
		rjmp main

fini:
	rjmp fini
	


