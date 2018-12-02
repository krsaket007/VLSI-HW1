// MEM_WB

module MEM_WB (clk,
              rst,
			  // input 
			  // WB
			  MEM_MemtoReg,
			  MEM_RegWrite,
			  // pipe
			  MEM_ALU_result,
			  MEM_MEM_result,
			  MEM_rd,
              MEM_Type,
              MEM_PC,
			  // output
			  // WB
			  WB_MemtoReg,
			  WB_RegWrite,
			  // pipe
			  WB_ALU_result,
			  WB_MEM_result,
			  WB_rd,
              WB_Type,
              WB_PC
			  );
	
	parameter data_size = 32;
	
	input clk, rst;
	
	// WB
    input MEM_MemtoReg;	
    input MEM_RegWrite;	
	// pipe
	input [data_size-1:0] MEM_ALU_result;
    input [data_size-1:0] MEM_MEM_result;
    input [4:0] MEM_rd;
	input [3:0] MEM_Type;
    input [31:0] MEM_PC;

	// WB
	output WB_MemtoReg;
	output WB_RegWrite;
	// pipe
    output [data_size-1:0] WB_ALU_result;
    output [data_size-1:0] WB_MEM_result;
    output [4:0] WB_rd;
    output [3:0] WB_Type;
	output [31:0] WB_PC;
	
	// WB
	logic WB_MemtoReg;
	logic WB_RegWrite;
	// pipe
	logic [data_size-1:0] WB_ALU_result;
	logic [data_size-1:0] WB_MEM_result;
	logic [4:0] WB_rd;
	logic [3:0] WB_Type;
	logic [31:0] WB_PC;

	always @(posedge clk or posedge rst) begin
		if (rst) begin
			// WB
			WB_MemtoReg		 <= 1'b0;
			WB_RegWrite		 <= 1'b0;
			// pipe
			WB_ALU_result	 <= 32'd0;
			WB_MEM_result	 <= 32'd0;
			WB_rd   		 <= 5'd0;
			WB_Type			 <= 4'd0;
			WB_PC   		 <= 32'd0;		
		end
		else begin
			// WB
			WB_MemtoReg		 <= MEM_MemtoReg;
			WB_RegWrite		 <= MEM_RegWrite;
			// pipe
			WB_ALU_result 	 <= MEM_ALU_result;
			WB_MEM_result	 <= MEM_MEM_result;
			WB_rd	    	 <= MEM_rd;
			WB_Type			 <= MEM_Type;
			WB_PC   		 <= MEM_PC;		
		end
	end	

endmodule
