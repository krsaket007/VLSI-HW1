//top
`include "ADD.sv"
`include "ALU.sv"
`include "Controller.sv"
`include "EX_MEM.sv"
`include "FU.sv"
`include "HDU.sv"
`include "ID_EX.sv"
`include "IF_ID.sv"
`include "MEM_WB.sv"
`include "mux_pc.sv"
`include "mux_src1.sv"
`include "mux_src2.sv"
`include "mux_wr.sv"
`include "PC.sv"
`include "Registers.sv"
`include "SRAM_wrapper.sv"


module top( clk,
            rst);


    parameter	data_size = 32;
    parameter 	pc_size = 	32;
    parameter 	mem_size = 	32;

    input 	clk,rst;

	// Instruction Memory
	//wire 	[mem_size-1:0] 	IM_Address;
	wire  	[data_size-1:0] Instruction;


    
	// Wire Declaration part
    /*-----------------------------------------------------------*/

    // PC
    wire 	[pc_size-1:0] 	PCout;
    wire 	[pc_size-1:0] 	PCin;

    // IF_ID pipe
    /*-----------------------------------------------------------*/
	wire 	[pc_size-1:0]   ID_PC;
	wire 	[data_size-1:0] ID_ir;

    // Hazard Detection Unit
    /*-----------------------------------------------------------*/
	wire 	PCWrite;
	wire 	IF_IDWrite;
	wire 	IF_Flush;
	wire 	ID_Flush;

	//FU
	wire [2:0] status1;
	wire [2:0] status2;

    /*-----------------------------------------------------------*/

	// Controller
	wire [6:0] opcode;
	wire [2:0] funct3;
	wire [6:0] funct7;
	wire MemtoReg;
	wire [4:0] ALUOp;
	wire RegWrite;
	wire MemWrite;
	wire [3:0]Type;

    // Registers
	wire 	[4:0] 	rs1;
	wire 	[4:0] 	rs2;
	wire 	[4:0] 	rd;
	wire	[data_size-1:0] rs1_data;
	wire 	[data_size-1:0] rs2_data;

    // sign_extend	
	//wire 	[11:0] 	I_imm;
	//wire 	[data_size-1:0] I_se_imm;
	//wire 	[11:0] 	S_imm;
	//wire 	[data_size-1:0] S_se_imm;
	//wire 	[12:0] 	B_imm;
	//wire 	[data_size-1:0] B_se_imm;
	//wire 	[31:0] 	U_imm;
	//wire 	[20:0] 	J_imm;
	//wire 	[data_size-1:0] J_se_imm;


	

    // PC
	//assign IM_Address = PCout[pc_size-1:0];	
	//idir
	// Controller
	assign opcode = ID_ir[6:0];
	assign funct7 = ID_ir[31:25];
    assign funct3 = ID_ir[14:12];
	
	// Registers
	assign rs1 = ID_ir[19:15];
	assign rs2 = ID_ir[24:20];
	assign rd  = ID_ir[11:7];
	
	// sign_extend
	//assign I_imm = ID_ir[31:20];
	//assign I_se_imm = {{(20){I_imm[11]}},I_imm};
	//assign S_imm = {ID_ir[31:25],ID_ir[11:7]};
	//assign S_se_imm = {{(20){S_imm[11]}},S_imm};
	//assign B_imm = {ID_ir[31],ID_ir[7],ID_ir[30:25],ID_ir[11:8],1'b0};
	//assign B_se_imm = {{(19){B_imm[12]}},B_imm};
	//assign U_imm = {ID_ir[31:12],12'd0};
	//assign J_imm = {ID_ir[31],ID_ir[19:12],ID_ir[20],ID_ir[30:21],1'bo};
	//assign J_se_imm = {{(11){I_imm[20]}},J_imm};

	
	// shamt to ID_EX pipe
	//assign shamt =ID_ir[24:20];
	
	// pipe

	//EX
	wire [4:0]  EX_ALUOp;
	wire [31:0] EX_src1;
	wire [31:0] EX_src2;
	wire [31:0] EX_ir;
	wire [31:0] EX_ALU_result;
	wire [31:0] EX_PC;
	wire [31:0] EX_rs1_data;
	wire [31:0] EX_rs2_data;
	wire [4:0]  EX_rd;
	wire [4:0]  EX_rs1;
	wire [4:0]  EX_rs2;
	wire [3:0]  EX_Type;
	wire 	Br;
	wire EX_MemtoReg;
	wire EX_RegWrite;
	wire EX_MemWrite;

	//MEM
	wire [31:0] MEM_ALU_result;
	wire [31:0] MEM_PC;
	wire [31:0] MEM_rs2_data;
	wire [31:0] MEM_MEM_result;
	wire [4:0]  MEM_rd;
	wire [3:0]  MEM_Type;
	wire MEM_MemtoReg;
	wire MEM_RegWrite;
	wire MEM_MemWrite;

	//WB
	wire WB_RegWrite;
	wire WB_MemtoReg;
	wire [31:0] WB_ALU_result;
	wire [31:0] WB_MEM_result;
	wire [31:0] WB_PC;
	wire [31:0] WB_wr_data;
	wire [3:0]  WB_Type;
	//wire []
	wire [4:0]  WB_rd;



    // IF stage 
    /*-----------------------------------------------------------*/
	// PC
    PC PC1(
        .clk(clk),
        .rst(rst),
    	.PCWrite(PCWrite),
	    .PCin(PCin), 
	    .PCout(PCout)
    );

	//IM
	SRAM_wrapper IM1(
		.CK(~clk),
        .CS(1'b1),
		.OE(1'b1),
		.WEB(4'b1111),
		.A(PCout[15:2]),
		.DI(32'd0),
		.DO(Instruction)
	);

	// IF_ID pipe
	/*-----------------------------------------------------------*/
	IF_ID IF_ID1(
		.clk(clk),
        .rst(rst),
		// input
		.IF_IDWrite(IF_IDWrite),
		.IF_Flush(IF_Flush),
		.IF_PC(PCout),
		.IF_ir(Instruction),
		// output
		.ID_PC(ID_PC),
		.ID_ir(ID_ir)
	);

	// ID
	/*-----------------------------------------------------------*/	
	// Hazard Detection Unit
	HDU HDU1 ( 
	// input
		.ID_rs1(rs1),
  		.ID_rs2(rs2),
		.EX_rd(EX_rd),
		.EX_MemtoReg(EX_MemtoReg),
		.Br(Br),
		// output
		.PCWrite(PCWrite),			 
		.IF_IDWrite(IF_IDWrite),
		.IF_Flush(IF_Flush),
		.ID_Flush(ID_Flush)
	);

	// Controller
	Controller Controller1 ( 
		.opcode(opcode),
		.funct3(funct3),
		.funct7(funct7),
		.MemtoReg(MemtoReg),
		.ALUOp(ALUOp),
		.RegWrite(RegWrite),
		.MemWrite(MemWrite),
		.Type(Type)
	);

	// Registers
	Registers Registers1 ( 
		.clk(clk), 
		.rst(rst),
		.Read_addr_1(rs1),
		.Read_addr_2(rs2),
		.Read_data_1(rs1_data),
		.Read_data_2(rs2_data),
		.RegWrite(WB_RegWrite),
		.Write_addr(WB_rd),
		.Write_data(WB_wr_data)
	);

	//FU
	FU FU1 ( 
		// input 
		.EX_rs1(EX_rs1),
    	.EX_rs2(EX_rs2),
		.MEM_RegWrite(MEM_RegWrite),
		.WB_RegWrite(WB_RegWrite),
        .MEM_rd(MEM_rd),
        .WB_rd(WB_rd),
        .MEM_Type(MEM_Type),
        .WB_Type(WB_Type),
		// output
		.status1(status1),
		.status2(status2)
	);


	// ID_EX pipe
	/*-----------------------------------------------------------*/	
	ID_EX ID_EX1( 
		.clk(clk),  
    	.rst(rst),
    	 // input 
		.ID_Flush(ID_Flush),
		// WB
		.ID_MemtoReg(MemtoReg),
		.ID_RegWrite(RegWrite),
		// M
		.ID_MemWrite(MemWrite),
		// EX	   
		// pipe
        .ID_ir(ID_ir),
		.ID_PC(ID_PC),
        .ID_Type(Type),
		.ID_ALUOp(ALUOp),
		.rs1_data(rs1_data),
		.rs2_data(rs2_data),
		.rs1(rs1),
		.rs2(rs2),
		.ID_rd(rd),
		// output
		// WB
		.EX_MemtoReg(EX_MemtoReg),
		.EX_RegWrite(EX_RegWrite),
		// M
		.EX_MemWrite(EX_MemWrite),
		// EX
		// pipe
        .EX_ir(EX_ir),
		.EX_PC(EX_PC),
        .EX_Type(EX_Type),
		.EX_ALUOp(EX_ALUOp),
		.EX_rs1_data(EX_rs1_data),
		.EX_rs2_data(EX_rs2_data),
		.EX_rs1(EX_rs1),
		.EX_rs2(EX_rs2),
		.EX_rd(EX_rd)	   			   
	);


	//mux_src1
	mux_src1 u_mux_src1(
		.EX_Type(EX_Type),
		.EX_PC(EX_PC),
        .EX_rs1_data(EX_rs1_data),
        .EX_src1(EX_src1),
        .MEM_ALU_result(MEM_ALU_result),
        .WB_wr_data(WB_wr_data),
        .status1(status1)
	);

	//mux_src2
	mux_src2 u_mux_src2 (
		.EX_ALUOp(EX_ALUOp),
		.EX_Type(EX_Type),
        .EX_ir(EX_ir),
        .EX_rs2_data(EX_rs2_data),
        .EX_src2(EX_src2),
		.MEM_ALU_result(MEM_ALU_result),
		.WB_wr_data(WB_wr_data),
		.status2(status2)
	);





	//EX
	ALU ALU1(
		.ALUOp(EX_ALUOp),
		.src1(EX_src1),
		.src2(EX_src2),
		.ALU_result(EX_ALU_result),
		.Br(Br)
	);


	//mux_pc
	mux_pc mux_pc1( 
		.EX_ir(EX_ir),
		.PC(PCout),
        .EX_PC(EX_PC),
		.EX_Type(EX_Type),
		.Br(Br),
        .EX_ALU_result(EX_ALU_result),
	    .out(PCin)
	);
	




	// EX_MEM pipe
	/*-----------------------------------------------------------*/
	EX_MEM EX_MEM1(
		.clk(clk),
		.rst(rst),
		// input 
		// WB
		.EX_MemtoReg(EX_MemtoReg),
		.EX_RegWrite(EX_RegWrite),
		// M
		.EX_MemWrite(EX_MemWrite),
		// pipe
		.EX_ALU_result(EX_ALU_result),
		.EX_rs2_data((status2==3'd3) ? MEM_ALU_result :(status2==3'd4) ? WB_wr_data :EX_rs2_data),
		.EX_rd(EX_rd),
        .EX_Type(EX_Type),
		.EX_PC(EX_PC),
		// output
		// WB
		.MEM_MemtoReg(MEM_MemtoReg),
		.MEM_RegWrite(MEM_RegWrite),
		// M
		.MEM_MemWrite(MEM_MemWrite),
		// pipe
		.MEM_ALU_result(MEM_ALU_result),
		.MEM_rs2_data(MEM_rs2_data),
		.MEM_rd(MEM_rd),
        .MEM_Type(MEM_Type),
		.MEM_PC(MEM_PC)			  		  			  
	);

	//DM
	SRAM_wrapper DM1(
		.CK(~clk),
        .CS(MEM_MemtoReg||MEM_MemWrite),
		.OE(MEM_MemtoReg),
		.WEB({(4){~MEM_MemWrite}}),
		.A(MEM_ALU_result[15:2]),
		.DI(MEM_rs2_data),
		.DO(MEM_MEM_result)
	);


	// EX_MEM pipe
	/*-----------------------------------------------------------*/

	MEM_WB MEM_WB1(
		.clk(clk),
        .rst(rst),
		// input 
		// WB
		.MEM_MemtoReg(MEM_MemtoReg),
		.MEM_RegWrite(MEM_RegWrite),
		// pipe
		.MEM_ALU_result(MEM_ALU_result),
		.MEM_MEM_result(MEM_MEM_result),
		.MEM_rd(MEM_rd),
        .MEM_Type(MEM_Type),
        .MEM_PC(MEM_PC),
		// output
		// WB
		.WB_MemtoReg(WB_MemtoReg),
		.WB_RegWrite(WB_RegWrite),
		// pipe
		.WB_ALU_result(WB_ALU_result),
		.WB_MEM_result(WB_MEM_result),
		.WB_rd(WB_rd),
        .WB_Type(WB_Type),
        .WB_PC(WB_PC)
	);

	mux_wr mux_wr1(
        .WB_rd(WB_rd),
        .WB_Type(WB_Type),
        .WB_ALU_result(WB_ALU_result),
        .WB_MEM_result(WB_MEM_result),
        .WB_PC(WB_PC),
        .WB_RegWrite(WB_RegWrite),
        .WB_MemtoReg(WB_MemtoReg),
        .WB_wr_data(WB_wr_data)
	);

	endmodule