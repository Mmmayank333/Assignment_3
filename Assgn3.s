       ;Exponential Series
  	    AREA    appcode ,CODE,READONLY
        EXPORT __main
        ENTRY
__main    FUNCTION
		
        MOV R0,#30;Storing the number of terms of the series (n) in R0
        MOV R1,#1;Storing the counting variable (i) in R1
				
		LDR R2,= 0x00000001 ;For storing the final sum of the exponent
	    VMOV.F S0,R2
	    VCVT.F32.U32 S0,S0
	   
	    LDR R3,= 0x00000001 ;For storing the intermediate multiplication result
	    VMOV.F S1,R3 ; 
	    VCVT.F32.U32 S1,S1
	   
	    LDR R4,= 0x00000003 ;Storing the value of X in R4
	    VMOV.F S2,R4 
	    VCVT.F32.U32 S2,S2
	   
	    LDR R5,= 0x00000001 ;R5 for storing the value of factorial
	    VMOV.F S6,R5 ; 
	    VCVT.F32.U32 S6,S6
				
Compare    CMP R1,R0 ;Comparing values of i and n 
        BLE loop; if i < n goto loop
        B stop;else goto stop
		
loop    VMUL.F32 S1,S1,S2 ;temp = temp*x
		VMOV.F32 S3,S1
        VMOV.F32 S5,R1 ;Moving the value of register R1 to floating register S5
        VCVT.F32.U32 S5, S5 ;Converting the value of S5 from exponential form to floating point number
		
		VMUL.F32 S6,S6,S5
        VDIV.F32 S3,S3,S6 ;Dividing temp by factorial S6 and storing it back in temp
        VADD.F32 S0,S0,S3 ;Final Sum
		
        ADD R1,R1,#1 ;Incrementing the counter variable 'i'
        B Compare ;Again goto comparision
		
stop    B stop
        ENDFUNC
        END