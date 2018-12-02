//mux_wr

module mux_wr(
            WB_rd,
            WB_Type,
            WB_ALU_result,
            WB_MEM_result,
            WB_PC,
            WB_RegWrite,
            WB_MemtoReg,
            WB_wr_data);

	input   [3:0]   WB_Type;
    input   [31:0]  WB_ALU_result;
    input   [31:0]  WB_MEM_result;
    input   [31:0]  WB_PC;
    input   [4:0]   WB_rd;
    input   WB_RegWrite;
    input   WB_MemtoReg;

    output  [31:0]  WB_wr_data;

    logic   [31:0]  WB_wr_data;

    always @(*)
    begin
        WB_wr_data =(WB_RegWrite == 1'b0) ? 0 :
                    (WB_MemtoReg == 1'b1) ? WB_MEM_result :
                    (WB_Type == 4'd6||WB_Type == 4'd9) ? WB_PC + 4 :
                    WB_ALU_result;

                    
    end


endmodule