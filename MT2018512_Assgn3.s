  area     appcode, CODE, READONLY
       IMPORT printMsg1
	   EXPORT __main
       ENTRY


__main  FUNCTION		 
        MOV R2, #20 ;Storing no. of iterations in R2
        MOV R1 , #1 ;Value of counter in R1
		MOV R3, #3 ;Denoting the logic function needs to be implemented
        VLDR.F32 S0,=1 ;For storing final result of exp(x) in S0
		VLDR.F32 S1,=1 ;For storing intermediate values
        VLDR.F32 S2,=3 ;Storing the value of x in R4 
		VLDR.F32 S3,=1 ;For storing the value of factorial 
		VLDR.F32 S5,=1
		VLDR.F32 S6,=1 ;For storing intermediate values
		VLDR.F32 S7,=1 
        VLDR.F32 S8,=1 ;For storing the value of "1+ exp(x)"
		VLDR.F32 S9,=1 ;For storing the result of sigmoid function

		BAL Switch
		
Switch	
		CMP R3,#0		;For AND operation 
		BEQ logic_and
		CMP R3,#1		;For OR operation
		BEQ logic_or
		CMP R3,#2		;For NOT operation
		BEQ logic_not
		CMP R3,#3		;For NAND operation
		BEQ logic_nand
		CMP R3,#4		;For NOR operation
		BEQ logic_nor
		CMP R3,#5       ;For XOR operation 
		BEQ logic_xor
		CMP R3,#6		;For XNOR operation
		BEQ logic_xnor
		

epowx    CMP R2, R1 ;Comparing values of i and n 
        BEQ sigmoid
		
		VMUL.F32 S1,S1,S2 ;temp = temp*x

		VMOV.F32 S6,S1
        VMOV.F32 S4,R1 ;Moving the value of register R1 to floating register S4
        VCVT.F32.U32 S4, S4 ;Converting the value of S4 from exponential form to floating point number
		
		VMUL.F32 S5,S5,S4
        VDIV.F32 S6,S6,S5 ;Dividing temp by factorial S5 and storing it back in temp
        VADD.F32 S0,S0,S6 ;Final Sum
		
        ADD R1,R1,#1 ;Incrementing the counter variable 'i'
        B epowx ;Again goto comparision
		
		
sigmoid
		VADD.F32 S8,S0,S7
		VDIV.F32 S9,S0,S8
		BL printMsg1
		B stop
		
		
logic_and
		VLDR.F32 S10,=-0.1
		VLDR.F32 S11,=0.2
		VLDR.F32 S12,=0.2
		VLDR.F32 S13,=-0.2
		B	dataset
		
logic_or
		VLDR.F32 S10,=-0.1
		VLDR.F32 S11,=0.7
		VLDR.F32 S12,=0.7
		VLDR.F32 S13,=-0.1
		B	dataset
		
logic_not
		VLDR.F32 S10,=0.5
		VLDR.F32 S11,=-0.7
		VLDR.F32 S12,=0
		VLDR.F32 S13,=0.1
		B	dataset
		
logic_nand
		VLDR.F32 S10,=0.6
		VLDR.F32 S11,=-0.8
		VLDR.F32 S12,=-0.8
		VLDR.F32 S13,=0.3
		B	dataset
		
logic_nor
		VLDR.F32 S10,=0.5
		VLDR.F32 S11,=-0.7
		VLDR.F32 S12,=-0.7
		VLDR.F32 S13,=0.1
		B  	dataset
		
logic_xor		
		VLDR.F32 S10,=-5
		VLDR.F32 S11,=20
		VLDR.F32 S12,=10
		VLDR.F32 S13,=1
		B	dataset

logic_xnor
		VLDR.F32 S10,=-5
		VLDR.F32 S11,=20
		VLDR.F32 S12,=10
		VLDR.F32 S13,=1
		B	dataset
		
dataset
		VLDR.F32 S14,=1
		VLDR.F32 S15,=0
		VLDR.F32 S16,=0
		B compute
		
compute
		VMUL.F32 S17,S10,S14;
		VMUL.F32 S18,S11,S15;
		VMUL.F32 S19,S12,S16;
		VADD.F32 S20,S17,S18
		VADD.F32 S20,S20,S19
		VADD.F32 S20,S20,S13    
		VMOV.F32 S2, S20;
		B epowx
		

stop B stop ; stop program
     ENDFUNC
     END