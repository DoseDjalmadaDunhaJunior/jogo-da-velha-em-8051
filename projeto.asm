;MOV R5, #70
	;ACALL lcd_init
	;mov a,#'G'
	;call sendCharacter
	;mov a,#'A'
	;call sendCharacter
	;mov a,#'N'
	;call sendCharacter
	;mov a,#'H'
	;call sendCharacter
	;mov a,#'A'
	;call sendCharacter
	;mov a,#'D'
	;call sendCharacter
	;mov a,#'O'
	;call sendCharacter
	;mov a,#'R'
	;call sendCharacter
	;mov a,#'_'
	;call sendCharacter
	;mov a,#'J'
	;call sendCharacter
	;mov a,#'O'
	;call sendCharacter
	;mov a,#'G'
	;call sendCharacter
	;mov a,#'A'
	;call sendCharacter
	;mov a,#'D'
	;call sendCharacter
	;mov a,#'O'
	;call sendCharacter
	;mov a,#'R'
	;call sendCharacter
	;mov a,#47H
	;acall posicionaCursor
	;mov a,#'1'
	;call sendCharacter
	;JMP $



; When a key is pressed the key number
; is placed in R0.

; For this program, the keys are numbered
; as:

;	+----+----+----+
;	| 11 | 10 |  9 |	row3
;	+----+----+----+
;	|  8 |  7 |  6 |	row2
;	+----+----|----+
;	|  5 |  4 |  3 |	row1
;	+----+----+----+
;	|  2 |  1 |  0 |	row0
;	+----+----+----+
;	 col2 col1 col0

; The pressed key number will be stored in
; R0. Therefore, R0 is initially cleared.
; Each key is scanned, and if it is not
; pressed R0 is incremented. In that way,
; when the pressed key is found, R0 will
; contain the key's number.

; The general purpose flag, F0, is used
; by the column-scan subroutine to indicate
; whether or not a pressed key was found
; in that column.
; If, after returning from colScan, F0 is
; set, this means the key was found.


; --- Mapeamento de Hardware (8051) ---
    RS      equ     P1.3    ;Reg Select ligado em P1.3
    EN      equ     P1.2    ;Enable ligado em P1.2


org 0000h
	LJMP START

org 0030h
START:
; put data in RAM
	MOV 40H, #'-' 
	MOV 41H, #'-'
	MOV 42H, #'-'


MAIN:
	ACALL lcd_init

ROTINA:
	call zera
	jmp rodada
	JMP ROTINA

rodada:
	cpl p3.4
	jnb p3.4 , rodada1
	call salvapo
	jmp rodada2
	call salvapo
	ret

rodada1:
	MOV 43H, #'O'
	MOV 44H, #'O'
	MOV 45H, #'O'
	MOV 46H, #'O'
	MOV 47H, #'O'
	MOV 48H, #'O'
	MOV 49H, #'O'
	MOV 4AH, #'O'
	MOV 4BH, #'O'
	ACALL leituraTeclado
	JNB F0, rodada1   ;if F0 is clear, jump to ROTINA
	MOV A, #07h		; posição em relação ao display onde vai aparecer
	ACALL posicionaCursor	
	MOV A, #40h
	ADD A, R0
	MOV R0, A
	MOV A, @R0        
	ACALL sendCharacter
	clr f0
	jmp rodada


rodada2:
	MOV 43H, #'X'
	MOV 44H, #'X'
	MOV 45H, #'X'
	MOV 46H, #'X'
	MOV 47H, #'X'
	MOV 48H, #'X'
	MOV 49H, #'X'
	MOV 4AH, #'X'
	MOV 4BH, #'X'
	ACALL leituraTeclado
	JNB F0, rodada2   ;if F0 is clear, jump to ROTINA
	MOV A, #07h		; posição em relação ao display onde vai aparecer
	ACALL posicionaCursor	
	MOV A, #40h
	ADD A, R0
	MOV R0, A
	MOV A, @R0        
	ACALL sendCharacter
	clr f0
	jmp confere
	jmp rodada

zera:
	mov 50h, #00h
	mov 51h, #00h
	mov 52h, #00h
	mov 60h, #00h
	mov 61h, #00h
	mov 62h, #00h
	mov 70h, #00h
	mov 71h, #00h
	mov 72h, #00h
	ret

salvapo:
	;por enquanto vou considerar a variavel como o B
	;simplismente para não ficar parado no codigo
	mov b, #01h
	mov 50h, b
	inc b
	mov 51h, b
	inc b
	mov 52h, b
	inc b
	mov 60h, b
	inc b
	mov 61h, b
	inc b
	mov 62h, b
	inc b
	mov 70h, b
	inc b
	mov 71h, b
	inc b
	mov 72h, b
	ret

confere:
	mov a, 50h 
	subb a, #058h
	jz  confere58abc2
	call confere4fabc1
	call confere58adg1
	call confere4fadg1
	call confere58aei1
	call confere4faei1
	call confere58beh1
	call confere4fbeh1
	call confere58cfi1
	ret

confere58abc2:
	mov a, 51h
	subb a, #058h
	jz confere58abc3
	ret

confere58abc3:
	mov a, 52h
	subb a, #058h
	;jz player1G
	ret


confere4fabc1:
	mov a, 50h 
	subb a, #04fh
	jz  confere4fabc2
	ret

confere4fabc2:
	mov a, 51h 
	subb a, #04fh
	jz  confere4fabc3
	ret

confere4fabc3:
	mov a, 52h
	subb a, #04fh
	;jz player2G
	ret

confere58adg1:
	mov a, 50h
	subb a, #058h
	jz confere58adg2
	ret

confere58adg2:
	mov a, 60h
	subb a, #058h
	jz confere58adg3
	ret

confere58adg3:
	mov a, 70h
	subb a, #058h
	;jz player1G
	ret

confere4fadg1:
	mov a, 50h
	subb a, #04fh
	jz confere4fadg2
	ret


confere4fadg2:
	mov a, 60h
	subb a, #04fh
	jz confere4fadg3
	ret


confere4fadg3:
	mov a, 70h
	subb a, #04fh
	;jz player2G
	ret

confere58aei1:
	mov a, 51h
	subb a, #058h
	jz confere58aei2
	ret

confere58aei2:
	mov a, 61h
	subb a, #058h
	jz confere58aei3
	ret

confere4faei1:
	mov a, 51h
	subb a, #04fh
	jz confere4faei2
	ret

confere4faei2:
	mov a, 61h
	subb a, #04fh
	jz confere4faei3
	ret

confere4faei3:
	mov a, 72h
	subb a, #04fh
	;jz player2G
	ret

confere58beh1:
	mov a, 50h
	subb a, #058h
	jz confere58beh2
	ret

confere58beh2:
	mov a, 61h
	subb a, #058h
	jz confere58beh3
	ret

confere58beh3:
	mov a, 71h
	subb a, #058h
	;jz player1G
	ret

confere58aei3:
	mov a, 72h
	subb a, #058h
	;jz player2G
	ret

confere4fbeh1:
	mov a, 51h
	subb a, #04fh
	jz confere58beh2
	ret

confere4fbeh2:
	mov a, 61h
	subb a, #04fh
	jz confere58beh3
	ret

confere4fbeh3:
	mov a, 71h
	subb a, #04fh
	;jz player2G
	ret

confere58cfi1:
	mov a, 52h
	subb a, #058h
	jz confere58cfi2
	ret

confere58cfi2:
	mov a, 62h
	subb a, #058h
	jz confere58cfi3
	ret

confere58cfi3:
	mov a, 72h
	subb a, #058h
	;jz player1G
	ret

confere4fcfi1:
	mov a, 52h
	subb a, #04fh
	jz confere4fcfi2
	ret

confere4fcfi2:
	mov a, 62h
	subb a, #04fh
	jz confere4fcfi3
	ret

confere4fcfi3:
	mov a, 72h
	subb a, #04fh
	;jz player2G
	ret

confere58def1:
	mov a, 60h
	subb a, #058h
	jz confere58def2
	ret

confere58def2:
	mov a, 61h
	subb a, #058h
	jz confere58def3
	ret

confere58def3:
	mov a, 62h
	subb a, #058h
	;jz player1G
	ret

confere4fdef1:
	mov a, 60h
	subb a, #04fh
	jz confere4fdef2
	ret

confere4fdef2:
	mov a, 61h
	subb a, #04fh
	jz confere4fdef3
	ret

confere4fdef3:
	mov a, 62h
	subb a, #04fh
	;jz player2G
	ret

confere58ceg1:
	mov a, 52h
	subb a, #058h
	jz confere58ceg2
	ret

confere58ceg2:
	mov a, 61h
	subb a, #058h
	jz confere58ceg3
	ret

confere58ceg3:
	mov a, 70h
	subb a, #058h
	;jz player1G
	ret

confere4fceg1:
	mov a, 52h
	subb a, #04fh
	jz confere4fceg2
	ret

confere4fceg2:
	mov a, 61h
	subb a, #04fh
	jz confere4fceg3
	ret

confere4fceg3:
	mov a, 70h
	subb a, #04fh
	;jz player2G
	ret

confere58ghi1:
	mov a, 70h
	subb a, #058h
	jz confere58ghi2
	ret

confere58ghi2:
	mov a, 71h
	subb a, #058h
	jz confere58ghi3
	ret

confere58ghi3:
	mov a, 72h
	subb a, #058h
	;jz player1G
	ret

confere4fghi1:
	mov a, 70h
	subb a, #04fh
	jz confere4fghi2
	ret

confere4fghi2:
	mov a, 71h
	subb a, #04fh
	jz confere4fghi3
	ret

confere4fghi3:
	mov a, 72h
	subb a, #04fh
	;jz player2G
	ret

player1G:
;mensagem que o jogador 1 ganhou
	sjmp $;

player2G:
;mensagem que o jogador 2 ganhou
	sjmp $;


leituraTeclado:
	MOV R0, #0			; clear R0 - the first key is key0
	; scan row0
	MOV P0, #0FFh	
	CLR P0.0			; clear row0
	CALL colScan		; call column-scan subroutine
	JB F0, finish		; | if F0 is set, jump to end of program 
						; | (because the pressed key was found and its number is in  R0)
	; scan row1
	SETB P0.0			; set row0
	CLR P0.1			; clear row1
	CALL colScan		; call column-scan subroutine
	JB F0, finish		; | if F0 is set, jump to end of program 
						; | (because the pressed key was found and its number is in  R0)
	; scan row2
	SETB P0.1			; set row1
	CLR P0.2			; clear row2
	CALL colScan		; call column-scan subroutine
	JB F0, finish		; | if F0 is set, jump to end of program 
						; | (because the pressed key was found and its number is in  R0)
	; scan row3
	SETB P0.2			; set row2
	CLR P0.3			; clear row3
	CALL colScan		; call column-scan subroutine
	JB F0, finish		; | if F0 is set, jump to end of program 
						; | (because the pressed key was found and its number is in  R0)
finish:
	RET

; column-scan subroutine
colScan:
	JNB P0.4, gotKey	; if col0 is cleared - key found
	INC R0				; otherwise move to next key
	JNB P0.5, gotKey	; if col1 is cleared - key found
	INC R0				; otherwise move to next key
	JNB P0.6, gotKey	; if col2 is cleared - key found
	INC R0				; otherwise move to next key
	RET					; return from subroutine - key not found
gotKey:
	SETB F0				; key found - set F0
	RET					; and return from subroutine




; initialise the display
; see instruction set for details
lcd_init:

	CLR RS		; clear RS - indicates that instructions are being sent to the module

; function set	
	CLR P1.7		; |
	CLR P1.6		; |
	SETB P1.5		; |
	CLR P1.4		; | high nibble set

	SETB EN		; |
	CLR EN		; | negative edge on E

	CALL delay		; wait for BF to clear	
					; function set sent for first time - tells module to go into 4-bit mode
; Why is function set high nibble sent twice? See 4-bit operation on pages 39 and 42 of HD44780.pdf.

	SETB EN		; |
	CLR EN		; | negative edge on E
					; same function set high nibble sent a second time

	SETB P1.7		; low nibble set (only P1.7 needed to be changed)

	SETB EN		; |
	CLR EN		; | negative edge on E
				; function set low nibble sent
	CALL delay		; wait for BF to clear


; entry mode set
; set to increment with no shift
	CLR P1.7		; |
	CLR P1.6		; |
	CLR P1.5		; |
	CLR P1.4		; | high nibble set

	SETB EN		; |
	CLR EN		; | negative edge on E

	SETB P1.6		; |
	SETB P1.5		; |low nibble set

	SETB EN		; |
	CLR EN		; | negative edge on E

	CALL delay		; wait for BF to clear


; display on/off control
; the display is turned on, the cursor is turned on and blinking is turned on
	CLR P1.7		; |
	CLR P1.6		; |
	CLR P1.5		; |
	CLR P1.4		; | high nibble set

	SETB EN		; |
	CLR EN		; | negative edge on E

	SETB P1.7		; |
	SETB P1.6		; |
	SETB P1.5		; |
	SETB P1.4		; | low nibble set

	SETB EN		; |
	CLR EN		; | negative edge on E

	CALL delay		; wait for BF to clear
	RET


sendCharacter:
	SETB RS  		; setb RS - indicates that data is being sent to module
	MOV C, ACC.7		; |
	MOV P1.7, C			; |
	MOV C, ACC.6		; |
	MOV P1.6, C			; |
	MOV C, ACC.5		; |
	MOV P1.5, C			; |
	MOV C, ACC.4		; |
	MOV P1.4, C			; | high nibble set

	SETB EN			; |
	CLR EN			; | negative edge on E

	MOV C, ACC.3		; |
	MOV P1.7, C			; |
	MOV C, ACC.2		; |
	MOV P1.6, C			; |
	MOV C, ACC.1		; |
	MOV P1.5, C			; |
	MOV C, ACC.0		; |
	MOV P1.4, C			; | low nibble set

	SETB EN			; |
	CLR EN			; | negative edge on E

	CALL delay			; wait for BF to clear
	CALL delay			; wait for BF to clear
	RET

;Posiciona o cursor na linha e coluna desejada.
;Escreva no Acumulador o valor de endereço da linha e coluna.
;|--------------------------------------------------------------------------------------|
;|linha 1 | 00 | 01 | 02 | 03 | 04 |05 | 06 | 07 | 08 | 09 |0A | 0B | 0C | 0D | 0E | 0F |
;|linha 2 | 40 | 41 | 42 | 43 | 44 |45 | 46 | 47 | 48 | 49 |4A | 4B | 4C | 4D | 4E | 4F |
;|--------------------------------------------------------------------------------------|
posicionaCursor:
	CLR RS	
	SETB P1.7		    ; |
	MOV C, ACC.6		; |
	MOV P1.6, C			; |
	MOV C, ACC.5		; |
	MOV P1.5, C			; |
	MOV C, ACC.4		; |
	MOV P1.4, C			; | high nibble set

	SETB EN			; |
	CLR EN			; | negative edge on E

	MOV C, ACC.3		; |
	MOV P1.7, C			; |
	MOV C, ACC.2		; |
	MOV P1.6, C			; |
	MOV C, ACC.1		; |
	MOV P1.5, C			; |
	MOV C, ACC.0		; |
	MOV P1.4, C			; | low nibble set

	SETB EN			; |
	CLR EN			; | negative edge on E

	CALL delay			; wait for BF to clear
	CALL delay			; wait for BF to clear
	RET


;Retorna o cursor para primeira posição sem limpar o display
retornaCursor:
	CLR RS	
	CLR P1.7		; |
	CLR P1.6		; |
	CLR P1.5		; |
	CLR P1.4		; | high nibble set

	SETB EN		; |
	CLR EN		; | negative edge on E

	CLR P1.7		; |
	CLR P1.6		; |
	SETB P1.5		; |
	SETB P1.4		; | low nibble set

	SETB EN		; |
	CLR EN		; | negative edge on E

	CALL delay		; wait for BF to clear
	RET


;Limpa o display
clearDisplay:
	CLR RS	
	CLR P1.7		; |
	CLR P1.6		; |
	CLR P1.5		; |
	CLR P1.4		; | high nibble set

	SETB EN		; |
	CLR EN		; | negative edge on E

	CLR P1.7		; |
	CLR P1.6		; |
	CLR P1.5		; |
	SETB P1.4		; | low nibble set

	SETB EN		; |
	CLR EN		; | negative edge on E

	CALL delay		; wait for BF to clear
	RET


delay:
	MOV R7, #50
	DJNZ R7, $
	RET