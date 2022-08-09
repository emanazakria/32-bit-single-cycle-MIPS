module PC #
(
    parameter   WIDTH      =   32
) 
(
    input wire				CLK						,
    input wire				RST						,
    input wire [WIDTH-1:0]	PC_in					,
    
    output reg [WIDTH-1:0]	PC_out     

);

always @(posedge CLK , negedge RST)
	begin
	
		if(!RST)
			begin
				PC_out <= {(WIDTH){1'b0}}			;
			end
		else
			begin
				PC_out <= PC_in						;
		end
		
	end
endmodule 