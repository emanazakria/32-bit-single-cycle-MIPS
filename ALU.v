module ALU #
(
    parameter   DATA_WIDTH      =   32
)
(
	input 	wire  	[DATA_WIDTH-1:0] 		SrcA		,
	input 	wire  	[DATA_WIDTH-1:0] 		SrcB		,
	input 	wire  	[2:0] 					ALU_Control	, 

	output 	reg 	[DATA_WIDTH-1:0] 		ALU_Result 	,
	output 	wire 							Zero 
);

localparam AND 	= 3'b000 								;
localparam OR 	= 3'b001 								;
localparam ADD 	= 3'b010 								;
localparam SUB 	= 3'b100 								;
localparam MUL 	= 3'b101 								;
localparam SLT 	= 3'b110 								;

always @(*)
 begin
  case (ALU_Control) 
  
    AND : 		begin
					ALU_Result = SrcA & SrcB 	;
				end
			
    OR : 		begin
					ALU_Result = SrcA | SrcB 	;
				end
			
    ADD : 		begin
					ALU_Result = SrcA + SrcB 	;
				end
			
    SUB : 		begin
					ALU_Result = SrcA - SrcB 	;
				end
			
    MUL : 		begin
					ALU_Result = SrcA * SrcB 	;
				end
			
    SLT : 		begin
					ALU_Result = (SrcA < SrcB) 	;
				end
			
    default : 	begin
					ALU_Result = {(DATA_WIDTH){1'b0}}	;
				end
 endcase
end
	assign Zero = (ALU_Result == {(DATA_WIDTH){1'b0}})  			; 
endmodule