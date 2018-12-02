// ALU

module ALU ( ALUOp,
			 src1,
			 src2,
			 ALU_result,
			 Br);
	
	parameter bit_size = 32;
	
	input   [4:0] ALUOp;
	input   [bit_size-1:0] src1;
	input   [bit_size-1:0] src2;
	
	output  [bit_size-1:0] ALU_result;
	output  Br;
	logic   [bit_size-1:0] ALU_result;
	logic   Br;
	
	wire    [bit_size:0] sub_result;

    wire    [bit_size*2-1:0] se_m_src1; //sign extend 
	logic    [bit_size*2-1:0] temp;


	assign sub_result = src1 - src2;
    assign se_m_src1= {32'hffffffff,src1};
	assign temp = (src1[31]) ? (se_m_src1 >> src2[4:0]) : (src1 >> src2[4:0]);



	parameter //op_nop = 0,
			  op_add = 1,
	          op_sub = 2,
	          op_sll = 3,
	          op_slt = 4,
	          op_sltu= 5,
	          op_xor = 6,
	          op_srl = 7,
	          op_sra = 8,
	          op_or  = 9,
	          op_and = 10,
	          op_beq = 11,
              op_bne = 12,
              op_blt = 13,
              op_bge = 14,
              op_bltu= 15,
              op_bgeu= 16,
              op_auipc=17,
              op_lui = 18,
              op_jalr= 19,
			  op_j	 = 20;

			
	always@ (*) 
    begin
		ALU_result	 = 0;
		Br  		 = 1'b0;
		case (ALUOp)
		//op_nop : 
		5'd1 	: ALU_result = src1 + src2;
		5'd2 	: ALU_result = sub_result[31:0];
		5'd3 	: ALU_result = src1 << (src2[4:0]);
        5'd4 	: ALU_result = (src1[31] == src2[31]) ? ((sub_result[32]) ? 1 : 0) :
                              (src1[31] == 1'b0) ? 0 : 1 ;
		5'd5	: ALU_result = (sub_result[32]) ? 1 : 0 ;
		5'd6	: ALU_result = src1 ^ src2;
		5'd7	: ALU_result = src1 >> (src2[4:0]);
        5'd8 	: ALU_result = temp[31:0]; 
		5'd9	: ALU_result = src1 | src2;
		5'd10	: ALU_result = src1 & src2;
		5'd11	: Br = (src1==src2) ? 1'b1 : 1'b0;
		5'd12	: Br = (src1!=src2) ? 1'b1 : 1'b0;
        5'd15	: Br = (sub_result[32]) ? 1'b1 : 1'b0;
        5'd16	: Br = (sub_result[32]) ? 1'b0 : 1'b1;
        5'd13	: Br = (src1[31] == src2[31]) ? ((sub_result[32]) ? 1'b1 : 1'b0) :
                      (src1[31] == 1'b0) ? 1'b0 : 1'b1 ;
        5'd14	: Br = (src1[31] == src2[31]) ? ((sub_result[32]) ? 1'b0 : 1'b1) :
                      (src1[31] == 1'b0) ? 1'b1 : 1'b0 ;
        5'd19	: begin Br = 1'b1; ALU_result = src1 + src2; end
		5'd20: Br = 1'b1;
        default: begin Br = 1'b0; ALU_result = 0;end
		endcase // ALUOp
	end

endmodule





