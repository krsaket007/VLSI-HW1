//mux_src2

module mux_src2(    
                EX_ALUOp,
                EX_Type,
                EX_ir,
                EX_rs2_data,
                EX_src2,
                MEM_ALU_result,
                WB_wr_data,
                status2);

    input   [4:0]   EX_ALUOp;
    input   [3:0]   EX_Type;
    input   [31:0]  EX_ir;
    input   [31:0]  EX_rs2_data;
    input   [31:0]  MEM_ALU_result;
    input   [31:0]  WB_wr_data;
    input   [2:0]   status2;

    output  [31:0]  EX_src2;

    logic   [31:0]  EX_src2;

    always @(*)
    begin
        case(EX_Type)
        4'd1 : EX_src2 =   (status2==3'd3) ? MEM_ALU_result : 
                        (status2==3'd4) ? WB_wr_data :    
                        EX_rs2_data;
        4'd2 : EX_src2 = {{(20){EX_ir[31]}},EX_ir[31:20]};
        4'd3 : EX_src2 = {{(20){EX_ir[31]}},EX_ir[31:25],EX_ir[11:7]};
        4'd4 : EX_src2 =   (status2==3'd3) ? MEM_ALU_result : 
                        (status2==3'd4) ? WB_wr_data :    
                        EX_rs2_data;
        4'd5 : EX_src2 = {EX_ir[31:12],12'd0};
        4'd6 : EX_src2 = 4;
        4'd7 : EX_src2 = {27'd0,EX_ir[24:20]};
        4'd8 : EX_src2 = {EX_ir[31:12],12'd0};
        4'd9 : EX_src2 = {{(20){EX_ir[31]}},EX_ir[31:20]};
        default : EX_src2 =0;
        endcase
    end


endmodule