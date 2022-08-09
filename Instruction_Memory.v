module Instruction_Memory #
(
		parameter   WIDTH		= 	32 				,
		parameter   DEPTH		= 	100	
)
(
		input 	wire 	[WIDTH-1:0] PC 				,
	
		output 	reg 	[DEPTH-1:0] INSTRUCTION
);

	initial 
		begin
			$readmemh("mem.txt",memory)
		end
		
	always@(PC)	
		begin
			INSTRUCTION = memory[PC>>2] ;
		end
		
endmodule