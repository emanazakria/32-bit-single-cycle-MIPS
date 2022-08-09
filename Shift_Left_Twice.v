module Shift_Left_Twice #	(
								parameter Data_Width 	= 32
							)
							(
								input 	wire 	[Data_Width-1:0] 	in  	,
								output 	wire 	[Data_Width-1:0] 	out
							);
							
								assign out = in << 2 ;
endmodule