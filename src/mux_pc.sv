// mux_pc

module mux_pc ( EX_ir,
				PC,
                EX_PC,
				EX_Type,
				Br,
                EX_ALU_result,
			    out);

	parameter bit_size = 32;

	input  [bit_size-1:0] EX_ir;
	input  [bit_size-1:0] PC;
	input  [bit_size-1:0] EX_PC;
	input  [bit_size-1:0] EX_ALU_result;
    input  [3:0] EX_Type;

    input   Br;

	output [bit_size-1:0] out;
	logic  [bit_size-1:0] out;

	wire   [bit_size-1:0] imm1;
	wire   [bit_size-1:0] imm2;
	assign imm2 = {{(11){EX_ir[31]}},EX_ir[31],EX_ir[19:12],EX_ir[20],EX_ir[30:21],1'b0};
	assign imm1 = {{(19){EX_ir[31]}},EX_ir[31],EX_ir[7],EX_ir[30:25],EX_ir[11:8],1'b0};
	
	always@ (*) begin
		out = 0;
		case (EX_Type)
		4'd9 : out = EX_ALU_result;
		4'd4 : out = (Br) ? EX_PC + imm1 : PC + 4;
		4'd6 : out = EX_PC + imm2;
        default : out = PC + 4;
		endcase // S
	end
	
endmodule





