module Data_Memory #	(
							parameter AdressWidth 	= 	32 					,
							parameter WIDTH 		= 	32 					,
							parameter DEPTH			= 	100
						)
						(
							input 	wire 	[AdressWidth-1:0] 	A 			,
							input 	wire 	[WIDTH-1:0] 		WD 			,
							input 	wire 						WE			,
							input 	wire 						CLK 		,
							input 	wire 						RST 		,
							
							output 		 	[WIDTH-1:0] 		RD 			,
							output			[(WIDTH/2)-1:0] 	TestValue	 

						);
	reg  	[WIDTH-1:0] DATA_MEM [DEPTH-1:0] 	;
	integer i	 								;
	
	always @(posedge CLK , negedge RST)
		begin
			if(!RST)
				begin
					for (i = 0 ; i < DEPTH ; i = i+1)
								begin
									DATA_MEM[i] <= 'b0 ;
								end
				end 
			else
				begin
					if(WE)
						begin
							DATA_MEM[A] <= WD ;
						end
				end
		end 
	
	
	assign TestValue = DATA_MEM[0] ;
	
endmodule