module Sign_Extend #	(
							parameter 	IN_WIDTH 	= 16 ,
							parameter 	OUT_WIDTH 	= 32
						)
						(
							input 	wire [IN_WIDTH-1:0] 	Inst ,
							
							output 	wire [OUT_WIDTH-1:0] 	SignImm	
						);
						
							assign 	SignImm 	=	{ { (IN_WIDTH) {Inst[IN_WIDTH-1] } },Inst}; 
endmodule