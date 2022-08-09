module MIPS_TOP #	(
						parameter 	WIDTH 	= 32 
					)
					(
						input 	wire 			CLK 		,
						input 	wire 			RST 		,
						
						output 	wire [15:0] 	TestValue
					);
						
						
						wire 					JMP 		;
						wire 					MemtoReg	;
						wire					ALUSrc 		;
						wire 					PCSrc 		;
						wire 					RegDst 		;
						wire 					RegWrite 	;
						wire 					MemWrite 	;l
						wire 					Zero 		;
						
						wire 	[2:0] 			ALU_Control ;
						wire 	[WIDTH-1:0] 	Instruction	;
						wire 	[WIDTH-1:0] 	PC 			;
						wire 	[WIDTH-1:0] 	ALU_Result 	;
						wire 	[WIDTH-1:0] 	WriteData 	;
						wire 	[WIDTH-1:0] 	ReadData 	;

Data_Memory 	DataMemory
	(
		.A			(ALU_Result) 	,
		.WD			(WriteData)		,
		.WE			(MemWrite)		,
		.CLK		(CLK) 			,
		.RST		(RST)			,				
		
		.RD			(ReadData) 		,
		.TestValue	(TestValue)
	);
	
	

Instruction_Memory 	InstructionMemory
	(
		.PC				(PC) 		,
		
		.INSTRUCTION	(Instruction)
	);
	
	
	
Control_Unit 	ControlUnit 
	(
		.Instruction	(Instruction)	,
		.Zero			(Zero) 			,
		
		.ALU_Control	(ALU_Control)	,
		.JMP			(JMP)			,
		.MemtoReg		(MemtoReg)		,
		.MemWrite		(MemWrite)		,
		.ALUSrc			(ALUSrc)		,
		.PCSrc			(PCSrc) 		,
		.RegDst			(RegDst)		,
		.RegWrite		(RegWrite) 		
	);
					
Data_Path_Unit 	DataPathUnit	
	(
		.CLK			(CLK) 	 		,
		.RST			(RST) 			,
		.Instruction	(Instruction) 	,
		.ReadData		(ReadData) 		,
		.ALU_Control	(ALU_Control) 	,
		.JMP			(JMP) 			,
		.MemtoReg		(MemtoReg) 		,
		.ALUSrc			(ALUSrc)  		,
		.PCSrc			(PCSrc)  		,
		.RegDst			(RegDst) 		,
		.RegWrite 		(RegWrite)		,
							
		.PC				(PC)			,
		.ALU_Result		(ALU_Result) 	,
		.WriteData		(WriteData)		,
		.Zero			(Zero) 
	);
	

endmodule 