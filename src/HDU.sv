// Hazard Detection Unit

module HDU ( // input
			ID_rs1,
            ID_rs2,
			EX_rd,
			EX_MemtoReg,
			Br,
			// output
			PCWrite,			 
			IF_IDWrite,
			IF_Flush,
			ID_Flush
			);
	
	parameter bit_size = 32;
	
	input [4:0] ID_rs1;
	input [4:0] ID_rs2;
	input [4:0] EX_rd;
	input EX_MemtoReg;
	input Br;
	
	output PCWrite;
	output IF_IDWrite;
	output IF_Flush;
	output ID_Flush;
	logic PCWrite;
	logic IF_IDWrite;
	logic IF_Flush;
	logic ID_Flush;
	
	always @(*) begin
		//default signal value
		PCWrite		 = 1'b1;
		IF_IDWrite	 = 1'b1;
		IF_Flush	 = 1'b0;
		ID_Flush	 = 1'b0;
		
		// Branch or Jump
		if (Br != 1'b0) begin
			/* write the signal change */
			/* ----------------------- */

			PCWrite	= 1'b1;
			IF_IDWrite= 1'b0;
			IF_Flush= 1'b1;
			ID_Flush= 1'b1;

			/* ----------------------- */
		end
		
		// Load
		if ((EX_MemtoReg == 1'b1) && ((EX_rd == ID_rs1)||(EX_rd == ID_rs2))) begin
			/* write the signal change */
			/* ----------------------- */

			PCWrite	= 1'b0;
			IF_IDWrite= 1'b0;
			IF_Flush= 1'b0;
			ID_Flush= 1'b1;

			/* ----------------------- */
		end
	end
	
endmodule