module MUX #	(
					parameter WIDTH = 32
				)
				(
					input  wire  	[WIDTH-1:0] 	A 	,
					input  wire  	[WIDTH-1:0] 	B 	,
					input  wire  	 				Sel	,
					
					output wire 	[WIDTH-1:0] 	OUT
				);
				
				assign OUT = (!Sel) ? A : B ;	
endmodule