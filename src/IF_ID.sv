//IF_ID

module IF_ID ( clk,
                rst,
			    // input
			    IF_IDWrite,
			    IF_Flush,
			    IF_PC,
			    IF_ir,
			    // output
			    ID_PC,
			    ID_ir);
	
	parameter   pc_size = 32;
	parameter   data_size = 32;
	
	input   clk, rst;
	input   IF_IDWrite, IF_Flush;
	input   [pc_size-1:0]   IF_PC;
	input   [data_size-1:0] IF_ir;
	
	output  logic [pc_size-1:0]   ID_PC;
	output  logic [data_size-1:0] ID_ir;
	
	always_ff @(posedge clk, posedge rst) 
    begin
		if(rst)begin
			ID_PC <= 0;
			ID_ir <= 0;
		end
		else if(IF_Flush)begin
			ID_PC <= 0;
			ID_ir <= 0;
		end
		else begin
			ID_PC <= IF_IDWrite ? IF_PC : ID_PC;
			ID_ir <= IF_IDWrite ? IF_ir : ID_ir;
		end
		/*ID_PC <=(rst||IF_Flush) ? 0 : 
				IF_IDWrite ? IF_PC : ID_PC;
		ID_ir <=(rst||IF_Flush) ? 0 : 
			    IF_IDWrite ? IF_ir : ID_ir;*/
	end

endmodule