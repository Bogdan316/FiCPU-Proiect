# General Purpose Processor
## General information
- two 16-bit general purpose registers (X and Y)
- 16-bit accumulator
- 16-bit stack pointer
- 16-bit instructions
- 16-bit word size
- 16-bit floating point addition and multiplication
- Zero, Negative, Carry and Overflow flags
## Instructions
- a list with all the supported instructions can be found [here](General%20Purpose%20CPU.pdf)
## Design
- the schematic of the design can be found [here](design.pdf)
## Assembler
- requires python 3.10
- supports line comments
- provides basic syntax checking
- addresses start with # and are specified in hexadecimal
- numbers start with $ and are specified in hexadecimal
- usage: ```python3.10 pyassembler program_file [-o destination_file]```
## Example program
- stores 1 at address #03 if the provided number is a palindrome
```assembly
; 79 in hexadecimal = 121 in decimal
MOV X, $79
PSH X
PSH X
JMP PAL
; get result
POP X
; get initial number
POP Y
; compare to check if is palindrome
MVR X
CMP Y
BRZ TRUE
MOV X, $00
BRA RES
TRUE: MOV X, $01
RES: STX #03
HLT
; read return addr and store in mem
PAL: POP Y
STY #01
; mov number to acc
POP X
MVR X

; reversed number will pe saved at address #00
MOV Y, $00
STY #00

; push digit to stack
LOOP: MOV Y, $0A
MOD Y
MVA Y
PSH Y

; multiply what we have at #00 with 10
LDY #00
MVR Y
MOV Y, $0A
MUL Y

; get current digit from stack, add it and then store to #00
POP Y
ADD Y
MVA Y
STY #00

; div by 10
MVR X
MOV X, $0A
DIV X
BRZ END
MVA X
BRA LOOP

END: LDX #00
LDY #01
PSH X
PSH Y
RET
```
