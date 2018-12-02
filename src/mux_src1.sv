//mux_src1

module mux_src1(EX_Type,
                EX_PC,
                EX_rs1_data,
                EX_src1,
                MEM_ALU_result,
                WB_wr_data,
                status1);

    input   [3:0]   EX_Type;
    input   [31:0]  EX_PC;
    input   [31:0]  MEM_ALU_result;
    input   [31:0]  WB_wr_data;
    input   [31:0]  EX_rs1_data;
    input   [2:0]   status1;

    output  [31:0]  EX_src1;

    logic   [31:0]  EX_src1;

    always @(*)
    begin
        EX_src1 =   (EX_Type == 4'd5||EX_Type == 4'd6) ? EX_PC :
                    (EX_Type == 4'd8) ? 0 :
                    (status1 == 3'd1) ? MEM_ALU_result :
                    (status1 == 3'd2) ? WB_wr_data :
                    EX_rs1_data;
    end


endmodule