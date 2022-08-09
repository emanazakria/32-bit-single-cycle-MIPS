module Register_File #	(
							parameter AdressWidth	=	5		,
							parameter WIDTH 		= 	32		,
							parameter DEPTH			= 	100
						)
						(
							input wire  [AdressWidth-1:0] 		A1	,
							input wire  [AdressWidth-1:0] 		A2	,
							input wire  [AdressWidth-1:0] 		A3	,
							input wire  [WIDTH-1:0]				WD3	,
							input wire							WE3	,
							input wire							CLK	,
							input wire							RST	,
							
							output wire 	[WIDTH-1:0] 		RD1	,
							output wire 	[WIDTH-1:0] 		RD2	
							
						);
			reg 	[WIDTH-1:0] REG_FILE [DEPTH-1:0] 	;
			integer i 									;
			
			always @(posedge CLK , negedge RST)
				begin
					if(!RST)
						begin
							for (i = 0 ; i < DEPTH ; i = i+1)
								begin
									REG_FILE[i] <= 'b0 ;
								end
						end
					else
						begin
							if (WE3)
								begin
									REG_FILE[A3] <= WD3 ;
								end
						end
				end
				
				assign RD1 = REG_FILE[A1] ;
				assign RD2 = REG_FILE[A2] ;
				
				
endmodule 