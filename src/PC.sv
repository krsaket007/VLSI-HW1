// Program Counter

module PC ( clk, 
			rst,
			PCWrite,
			PCin, 
			PCout);
	
	parameter pc_size = 32;
	
	input   clk, rst;
	input   PCWrite;
	input   [pc_size-1:0] PCin;
	output  [pc_size-1:0] PCout;	   
	logic   [pc_size-1:0] PCout;
	
	logic   [pc_size-1:0] temp_PCout;
	
	always @(*) temp_PCout = PCWrite ? PCin : PCout;
	
	always @(posedge clk, posedge rst)
		PCout <= rst ? 0 : temp_PCout;
		   
endmodule

