// EX_MEM

module EX_MEM (clk,
			  rst,
			  // input 
			  // WB
			  EX_MemtoReg,
			  EX_RegWrite,
			  // M
			  EX_MemWrite,
			  // pipe
			  EX_ALU_result,
			  EX_rs2_data,
			  EX_rd,
			  EX_Type,
			  EX_PC,
			  // output
			  // WB
			  MEM_MemtoReg,
			  MEM_RegWrite,
			  // M
			  MEM_MemWrite,
			  // pipe
			  MEM_ALU_result,
			  MEM_rs2_data,
			  MEM_rd,
			  MEM_Type,
			  MEM_PC		  		  			  
			  );
	
	parameter pc_size = 32;	
	parameter data_size = 32;
	
	input clk, rst;		  
			  
	// WB		  
	input EX_MemtoReg;
    input EX_RegWrite;
    // M
    input EX_MemWrite;
	// pipe		  
	input [data_size-1:0] EX_ALU_result;
    input [data_size-1:0] EX_rs2_data;
    input [4:0] EX_rd;
    input [3:0] EX_Type;
	input [pc_size-1:0] EX_PC;
	
	// WB
	output MEM_MemtoReg;	
	output MEM_RegWrite;	
	// M	
	output MEM_MemWrite;	
	// pipe		  
	output [data_size-1:0] MEM_ALU_result;
	output [data_size-1:0] MEM_rs2_data;
	output [4:0] MEM_rd;
	output [3:0] MEM_Type;
	output [pc_size-1:0] MEM_PC;
	

	// WB
	logic MEM_MemtoReg;	
	logic MEM_RegWrite;	
	// M	
	logic MEM_MemWrite;	
	// pipe		  
	logic [data_size-1:0] MEM_ALU_result;
	logic [data_size-1:0] MEM_rs2_data;
    logic [4:0] MEM_rd;
    logic [3:0] MEM_Type;
	logic [pc_size-1:0] MEM_PC;

	
	always @(posedge clk or posedge rst) begin
		if (rst) begin
			// WB
		    MEM_MemtoReg		 <= 1'b0;	
		    MEM_RegWrite		 <= 1'b0;	
		    // M	
		    MEM_MemWrite		 <= 1'b0;		
		    // pipe		  
		    MEM_ALU_result		 <= 32'd0;
		    MEM_rs2_data		 <= 32'd0;
		    MEM_rd		 		 <= 5'd0;
			MEM_Type			 <= 4'd0;
			MEM_PC				 <= 32'd0;
		end
		else begin
			// WB
			MEM_MemtoReg		 <= EX_MemtoReg;
		    MEM_RegWrite		 <= EX_RegWrite;
		    // M	
		    MEM_MemWrite		 <= EX_MemWrite;
		    // pipe		  
		    MEM_ALU_result	 	 <= EX_ALU_result;
		    MEM_rs2_data		 <= EX_rs2_data;
		    MEM_rd		 		 <= EX_rd;
			MEM_Type			 <= EX_Type;
			MEM_PC				 <= EX_PC;
		end
	end
	
endmodule


























