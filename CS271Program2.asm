TITLE Fibonacci    (Program2.asm)

; Name: Colleen Minor	
;Email: minorc@onid.oregonstate.edu
; CS271-400 / Assignment 2 Date: 1/25/2015
; Description: Program that displays the user's choice of number of Fibonacci numbers.

INCLUDE Irvine32.inc
INCLUDE Macros.inc

.data
 upperLimit equ 46			;maximum number user can choose
 userName BYTE 50 DUP(?)	;string to be entered by user
 userChoice SDWORD ?		;integert to be entered by user
 count SDWORD 0				;counter to keep track of how many numbers have been printed to console
 cur SDWORD 1				;variable to hold number that is next to be printed
 prev SDWORD ?				;variable to hold last number (to add next time)

.code
main PROC
;introduction
		mWrite "Welcome to Program #2. My name is Colleen. What is yours?"
		call Crlf
		mWrite "Name: "
		mReadString userName
		call Crlf

;userInstructions
		mWrite "Hello "
		mWriteString userName
		mWrite ". Welcome to Fibbonacci! This program will prompt you to enter "
		call Crlf
		mWrite "an integer between 1 and 46."
		call Crlf
		mWrite "That many fibbonacci numbers will be displayed."
		call Crlf

;getUserData
		getUserData:
			call Crlf
			mWrite "Please enter an integer between 1 and 46: "
			call readInt
			mov userChoice, eax
			cmp eax, upperLimit 
			jg errorLoop		;if the user's choice exceed the upper limit, jump to the error loop
			jmp displayFibs		;else jump to displayFibs
		errorLoop:
			call Crlf
			mWrite "Sorry, number must be between 1 and 46. Please try again."
			call Crlf
			jmp getUserData

;displayFibs

		displayFibs: 
			mov eax, count
			cmp eax, userChoice
			je exit_loop	;if userChoice is equal to count, exit
			mov ecx, 5		;move 5 to ecx to run "counted loop" 5 times

			countedLoop:
				cmp count, 0
				je countIsZero
				jmp countNotZero
				countIsZero:		;loop to display first number (1) 
					mWrite "1"
					mWriteSpace
					inc count
					dec ecx			;decriment ecx so that this time countedLoop only runs 4 more times

				countNotZero:		;the inner-loop that displays all of the numbers besides the first 1
					mov eax, count
					cmp eax, userChoice
					je exit_loop
					mov edx, prev	
					mov ebx, cur 
					mov prev, ebx
					add edx, ebx 
					mov cur, edx	;mov the sum to cur
					mov eax, cur	;now the cur to be printed
					call writeDec
					mWriteSpace
					inc count
			loop countedLoop

		call Crlf
		mov eax, count
		cmp eax, userChoice
		jl displayFibs
		je displayFibs

		exit_loop:
			call Crlf
			mWrite "Thank you for using Fibonacci! Have a lovely day!"
			call Crlf
		exit	
main ENDP
END main
