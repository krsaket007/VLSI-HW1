// ID_EX

module ID_EX ( clk,  
               rst,
               // input 
			   ID_Flush,
			   // WB
			   ID_MemtoReg,
			   ID_RegWrite,
			   // M
			   ID_MemWrite,  
			   // pipe
               ID_ir,
			   ID_PC,
               ID_Type,
			   ID_ALUOp,
               rs1_data,
               rs2_data,
			   rs1,
			   rs2,
			   ID_rd,
			   // output
			   // WB
			   EX_MemtoReg,
			   EX_RegWrite,
			   // M
			   EX_MemWrite,
			   // pipe
               EX_ir,
			   EX_PC,
               EX_Type,
			   EX_ALUOp,
               EX_rs1_data,
               EX_rs2_data,
			   EX_rs1,
			   EX_rs2,
			   EX_rd	   			   
			   );
	
	parameter pc_size = 32;			   
	parameter data_size = 32;
	
	input clk, rst;
	input ID_Flush;
	
	// WB
	input ID_MemtoReg;
	input ID_RegWrite;
	// M
	input ID_MemWrite;
	// pipe
    input [data_size-1:0] ID_ir;
    input [pc_size-1:0] ID_PC;
    input [3:0] ID_Type;
    input [4:0] ID_ALUOp;
    input [data_size-1:0] rs1_data;
    input [data_size-1:0] rs2_data;
	input [4:0] rs1;
	input [4:0] rs2;
    input [4:0] ID_rd;
	
	// WB
	output EX_MemtoReg;
	output EX_RegWrite;
	// M
	output EX_MemWrite;	
	// pipe
    output [data_size-1:0] EX_ir;
	output [pc_size-1:0] EX_PC;
    output [3:0] EX_Type;
	output [4:0] EX_ALUOp;
	output [data_size-1:0] EX_rs1_data;
	output [data_size-1:0] EX_rs2_data;
	output [4:0] EX_rs1;
	output [4:0] EX_rs2;
	output [4:0] EX_rd;
	
	// WB
	logic EX_MemtoReg;
	logic EX_RegWrite;
	// M
	logic EX_MemWrite;
	// pipe
    logic [data_size-1:0] EX_ir;
	logic [pc_size-1:0] EX_PC;
    logic [3:0] EX_Type;
	logic [4:0] EX_ALUOp;
	logic [data_size-1:0] EX_rs1_data;
	logic [data_size-1:0] EX_rs2_data;
	logic [4:0] EX_rs1;
	logic [4:0] EX_rs2;
	logic [4:0] EX_rd;
	
	always @(posedge clk or posedge rst) begin
		if (rst) begin
			// WB
		    EX_MemtoReg	 <= 1'b0;
			EX_RegWrite	 <= 1'b0;
			// M
			EX_MemWrite	 <= 1'b0;
		    // pipe
            EX_ir        <= 32'd0;
		    EX_PC		 <= 32'd0;
            EX_Type      <= 4'd0;
		    EX_ALUOp	 <= 5'd0;
		    EX_rs1_data	 <= 32'd0;
		    EX_rs2_data	 <= 32'd0;
			EX_rs1		 <= 5'd0;
			EX_rs2		 <= 5'd0;
		    EX_rd		 <= 5'd0;
		end
		else if (ID_Flush) begin
			// WB
		    EX_MemtoReg	 <= 1'b0;
			EX_RegWrite	 <= 1'b0;
			// M
			EX_MemWrite	 <= 1'b0;
		    // pipe
            EX_ir        <= 32'd0;
		    EX_PC		 <= 32'd0;
            EX_Type      <= 4'd0;
		    EX_ALUOp	 <= 5'd0;
		    EX_rs1_data	 <= 32'd0;
		    EX_rs2_data	 <= 32'd0;
			EX_rs1		 <= 5'd0;
			EX_rs2		 <= 5'd0;
		    EX_rd		 <= 5'd0;
		end
		else begin
			// WB
			EX_MemtoReg	 <= ID_MemtoReg;
		    EX_RegWrite	 <= ID_RegWrite;
		    // M            
		    EX_MemWrite	 <= ID_MemWrite;
		    // pipe
            EX_ir        <= ID_ir;         
		    EX_PC		 <= ID_PC;
            EX_Type      <= ID_Type;
		    EX_ALUOp	 <= ID_ALUOp;
            EX_rs1_data  <= rs1_data;
            EX_rs2_data  <= rs2_data;
			EX_rs1		 <= rs1;
			EX_rs2		 <= rs2;
		    EX_rd		 <= ID_rd;
		end		
	end			
	
endmodule










