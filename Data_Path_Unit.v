module Data_Path_Unit # (
							parameter 	WIDTH 	= 32  
						)
						(	
							input 	wire 					CLK 	 		,
							input 	wire 					RST 			,
							input 	wire 	[WIDTH-1:0] 	Instruction 	,
							input 	wire 	[WIDTH-1:0] 	ReadData 		,
							input 	wire 	[2:0]			ALU_Control 	,
							input 	wire					JMP 			,
							input 	wire 					MemtoReg 		,
							input 	wire 					ALUSrc  		,
							input 	wire 					PCSrc  			,
							input  	wire					RegDst 			,
							input  	wire					RegWrite 		,
							
							output 	wire 	[WIDTH-1:0] 	PC				,
							output 	wire 	[WIDTH-1:0] 	ALU_Result 		,
							output 	wire 	[WIDTH-1:0] 	WriteData 		,
							output 	wire 					Zero 
							
						);
							wire 	[WIDTH-1:0] 	SrcA 				;
							wire 	[WIDTH-1:0] 	SrcB 				;
							wire 	[WIDTH-1:0] 	WD3Result			;
							
							wire 	[4:0]			A1 					;
							wire 	[4:0]			A2 					;
							wire 	[4:0]			A3 					;
								
						
							wire 	[WIDTH-1:0] 	PC_in 				;
							wire 	[WIDTH-1:0] 	PCPlus4				;
							wire 	[WIDTH-1:0] 	PCBranch 			;
							wire 	[WIDTH-1:0] 	Plus_branch_MUX_OUT ;
							
							wire 	[WIDTH-1:0] 	SignImmShiftOut		;
							wire 	[WIDTH-1:0] 	SignImm 			;
							wire 	[27:0] 			JmpInsShiftOut 		;
							
							assign  A1 	= 	Instruction[25:21] 	;
							assign  A2 	= 	Instruction[20:16] 	;
					
					
		Register_File registerfile 
			(
				.CLK	(CLK)		,
				.RST	(RST)		,
				.A1 	(A1)		,
				.A2 	(A2)		,
				.A3 	(A3)		,
				.WD3 	(WD3Result)	,
				.WE3 	(RegWrite) 	,
				
				.RD1 	(SrcA) 		,
				.RD2 	(WriteData)
				
			);
			
			
		Shift_Left_Twice #(.Data_Width(28)) JmpInsShift
			(
				.in		(2'b00,Instruction[25:0]) 	,
				.out	(JmpInsShiftOut)
			);
			
			
			
		Shift_Left_Twice SignImmShift
			(
				.in		(SignImm]) 			,
				.out	(SignImmShiftOut)
			);	
			
			
		MUX	 WD3_MUX 
			(	
				.A		(ALU_Result) 	,
				.B		(ReadData)		,
				.Sel	(MemtoReg)		,
				
				.OUT	(WD3Result)
			);				
				
			
			
		assign PC_JMP 	= 	{PCPlus4[WIDTH:28],JmpInsShiftOut} ,
		
		MUX	 Jump_MUX 
			(	
				.A		(Plus_branch_MUX_OUT) 	,
				.B		(PC_JMP)				,
				.Sel	(JMP)					,
				
				.OUT	(PCSrc)
			);	

			
		MUX	 #(.WIDTH(5)) 	Reg_Write_MUX
			(	
				.A		(Instruction[20:16]) 	,
				.B		(Instruction[15:11])	,
				.Sel	(RegDst)				,
				
				.OUT	(A3)
			);	
			
			
		MUX	 Data_MUX 
			(	
				.A		(WriteData) 	,
				.B		(SignImm)		,
				.Sel	(ALUSrc)		,
				
				.OUT	(SrcB)
			);	
			
		MUX	 Plus_branch_MUX 
			(	
				.A		(PCPlus4) 				,
				.B		(PCBranch)				,
				.Sel	(PCSrc)					,
				
				.OUT	(Plus_branch_MUX_OUT)
			);
				
		assign PC4 	= 32'b100 	;		

		Adder plus 
			(
				.A		(PC)	,
				.B		(PC4)	,
				
				.OUT	(PCPlus4)
			);
			
			
		Adder Branch 
			(
				.A		(PCPlus4)			,
				.B		(SignImmShiftOut)	,
				
				.OUT	(PCBranch)
			);			
			
	
		Sign_Extend SignExtend
			(	
				.Inst		(Instruction[15:0])	,
			
				.SignImm	(SignImm)
			);	
							
		PC ProgramCounter 
			(
				.CLK	(CLK)	,
				.RST	(RST)	,
				.PC_in	(PC_in)	,
				
				.PC_out	(PC)
				
			);
			
		ALU ALU
			(	.SrcA			(SrcA)			,
				.SrcB			(SrcB) 			,
				.ALU_Control	(ALU_Control)	,
				
				.ALU_Result		(ALU_Result)	,
				.Zero			(Zero)
			);
			
		
endmodule