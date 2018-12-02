// Forwarding Unit

module FU ( // input 
			EX_rs1,
            EX_rs2,
			MEM_RegWrite,
			WB_RegWrite,
            MEM_rd,
            WB_rd,
            MEM_Type,
            WB_Type,
			// output
			status1,
			status2
			);

	input [4:0] EX_rs1;
   	input [4:0] EX_rs2;
   	input MEM_RegWrite;
   	input WB_RegWrite;
    input [4:0] MEM_rd;
    input [4:0] WB_rd;
    input [3:0] MEM_Type;
    input [3:0] WB_Type;

	output [2:0]status1;
    logic  [2:0]status1;

	output [2:0]status2;
    logic  [2:0]status2;
   	

	always @(*) begin
		// EX_rs1 Forwarding
		/* determine status by input signals*/
		/* ----------------------- */
		status1 = 3'd0;
		status2 = 3'd0;

		if((MEM_RegWrite == 1'b1)  && (EX_rs1 == MEM_rd) && (MEM_rd != 5'd0))
		begin
			status1 = 3'd1;
		end
		else if((WB_RegWrite == 1'b1) && (EX_rs1 == WB_rd) && (WB_rd != 5'd0))
		begin
			status1 = 3'd2;
		end
		/* ----------------------- */
		
		// EX_rs2 Forwarding
		/* determine status by input signals*/
		/* ----------------------- */
		if((MEM_RegWrite == 1'b1)  && (EX_rs2 == MEM_rd) && (MEM_rd != 5'd0))
		begin
			status2 = 3'd3;
		end
		else if((WB_RegWrite == 1'b1) && (EX_rs2 == WB_rd) && (WB_rd != 5'd0))
		begin
			status2 = 3'd4;
		end
		/* ----------------------- */
	end
	
endmodule








