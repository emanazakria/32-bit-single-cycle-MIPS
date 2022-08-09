module Control_Unit #	( 
							Instruction_Width 	= 32
						)
						(
							input 	wire 	[Instruction_Width-1:0]		Instruction 	,
							input 	wire								Zero 			,
							
							output 	reg 	[2:0]						ALU_Control		,
							output 	reg									JMP 			,
							output 	reg									MemtoReg		,
							output 	reg 								MemWrite		,
							output 	reg 								ALUSrc 			,
							output 	reg 								PCSrc 			,
							output 	reg 								RegDst 			,
							output 	reg 								RegWrite 			
							
						);
						
							localparam 	loadWord 		= 	6'b10_0011 	;
							localparam 	StoreWord 		= 	6'b10_1011 	;
							localparam 	rType	 		= 	6'b00_0000 	;
							localparam 	addimmediate	=	6'b00_1000 	;
							localparam 	branchifEqual	=	6'b00_0100 	;
							localparam 	jump_inst 		= 	6'b00_0010 	;
							
							localparam 	ADD 			= 	6'b10_0000 	;
							localparam 	SUB 			= 	6'b10_0010 	;
							localparam 	SLT				= 	6'b10_1010 	;
							localparam 	MUL				= 	6'b01_1100 	;
							localparam 	AND				= 	6'b10_0100 	;
							localparam 	OR				= 	6'b10_0101 	;
							
							wire 	[5:0] 	Opcode 	;
							wire 	[5:0] 	Funct 	;
							reg				Branch 	;
							reg 	[1:0]	ALUOp 	;
							
							assign 	Opcode 	= Instruction [Instruction_Width-1 : 26] 	;
							assign 	Funct 	= Instruction [5 : 0]						;
				
always @(*)
	begin
		case (Opcode
		
			loadWord :
				begin
					JMP 		= 	1'b0 	;
					ALUOp 		= 	2'b00 	;
					MemWrite 	= 	1'b0 	;
					RegWrite 	= 	1'b1 	;
					RegDst 		= 	1'b0 	;
					ALUSrc 		= 	1'b1	;
					MemtoReg 	= 	1'b1 	;
					Branch 		= 	1'b0 	;
				end
				
			StoreWord :
				begin
					JMP 		= 	1'b0 	;
					ALUOp 		= 	2'b00 	;
					MemWrite 	= 	1'b1 	;
					RegWrite 	= 	1'b0 	;
					RegDst 		= 	1'b0 	;
					ALUSrc 		= 	1'b1	;
					MemtoReg 	= 	1'b1 	;
					Branch 		= 	1'b0 	;
				end
				
			rType :
				begin
					JMP 		= 	1'b0 	;
					ALUOp 		= 	2'b10 	;
					MemWrite 	= 	1'b0 	;
					RegWrite 	= 	1'b1 	;
					RegDst 		= 	1'b1 	;
					ALUSrc 		= 	1'b0	;
					MemtoReg 	= 	1'b0 	;
					Branch 		= 	1'b0 	;
				end
				
			addimmediate :
				begin
					JMP 		= 	1'b0 	;
					ALUOp 		= 	2'b00 	;
					MemWrite 	= 	1'b0 	;
					RegWrite 	= 	1'b1 	;
					RegDst 		= 	1'b0 	;
					ALUSrc 		= 	1'b1	;
					MemtoReg 	= 	1'b0 	;
					Branch 		= 	1'b0 	;
				end	
			
			branchifEqual:
				begin
					JMP 		= 	1'b0 	;
					ALUOp 		= 	2'b01 	;
					MemWrite 	= 	1'b0 	;
					RegWrite 	= 	1'b0 	;
					RegDst 		= 	1'b0 	;
					ALUSrc 		= 	1'b0	;
					MemtoReg 	= 	1'b0 	;
					Branch 		= 	1'b1 	;
				end	
				
			jump_inst :
				begin
					JMP 		= 	1'b1 	;
					ALUOp 		= 	2'b00 	;
					MemWrite 	= 	1'b0 	;
					RegWrite 	= 	1'b0 	;
					RegDst 		= 	1'b0 	;
					ALUSrc 		= 	1'b0	;
					MemtoReg 	= 	1'b0 	;
					Branch 		= 	1'b0 	;
				end	
				
			default :
				begin
					JMP 		= 	1'b0 	;
					ALUOp 		= 	2'b00 	;
					MemWrite 	= 	1'b0 	;
					RegWrite 	= 	1'b0 	;
					RegDst 		= 	1'b0 	;
					ALUSrc 		= 	1'b0	;
					MemtoReg 	= 	1'b0 	;
					Branch 		= 	1'b0 	;
				end			
				
		endcase
	end

always @ (*)
	begin
		case (ALUOp)
			
			2'b00 : ALU_Control = 3'b010 	;
			2'b01 : ALU_Control = 3'b100 	;
			2'b10 : begin
						case (Funct)
								ADD 	: 	ALU_Control = 3'b010 	;
								SUB 	: 	ALU_Control = 3'b100 	;
								SLT 	: 	ALU_Control = 3'b110 	;
								MUL 	: 	ALU_Control = 3'b101	;
								AND 	: 	ALU_Control = 3'b000 	;
								OR		: 	ALU_Control = 3'b001 	;
								default	: 	ALU_Control = 3'b010 	;	
						endcase	
					end
					
			default : ALU_Control 	= 3'b010 	;
			
		endcase
	end
		
				assign 	PCSrc 	= Branch & Zero	;				
endmodule