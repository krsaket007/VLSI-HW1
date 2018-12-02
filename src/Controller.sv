// Controller

module Controller ( opcode,
					funct3,
                    funct7,
					MemtoReg,
					ALUOp,
					RegWrite,
					MemWrite,
                    Type
					);

	input   [6:0] opcode;
    input   [2:0] funct3;
    input   [6:0] funct7;

	output MemtoReg;
	output [4:0] ALUOp;
	output RegWrite;
	output MemWrite;
    output [3:0] Type;
	
	logic MemtoReg;
	logic [4:0] ALUOp;
	logic RegWrite;
	logic MemWrite;
    logic [3:0] Type;
	
	// ALU
	/*parameter op_nop = 0,
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
			  op_j	 = 20;*/
			  
	// controller
	always@ (*) 
    begin
		MemtoReg = 1'b0;
		ALUOp	 = 5'd0;
		RegWrite = 1'b0;
		MemWrite = 1'b0;
		Type	 = 4'd0;
		case (opcode)
        // R type
        /*-----------------------------------------------------------*/
		7'b011_0011 : 
        begin 
            Type = 4'd1;
			case (funct3)
			3'b000 : 
            begin 
				ALUOp	 = funct7[5] ? 5'd2 : 5'd1 ;
				RegWrite = 1'b1 ;
			end
			3'b001 : 
            begin 
				ALUOp	 = 5'd3;
				RegWrite = 1'b1;
			end
			3'b010 : 
            begin 
				ALUOp	 = 5'd4;
			 	RegWrite = 1'b1;
			end
			3'b011 : 
            begin 
				ALUOp	 = 5'd5;
				RegWrite = 1'b1;
			end
			3'b100 : 
            begin 
				ALUOp	 = 5'd6;
				RegWrite = 1'b1;
			end
			3'b101 : 
            begin 
				ALUOp	 = funct7[5] ? 5'd8 : 5'd7;
				RegWrite = 1'b1;
			end
			3'b110 : 
            begin 
				ALUOp	 = 5'd9;
				RegWrite = 1'b1;
			end
			3'b111 : 
            begin 
				ALUOp	 = 5'd10;
				RegWrite = 1'b1;
			end	
			endcase // funct
		end
		// I type
        /*-----------------------------------------------------------*/
		7'b001_0011 : 
        begin
            Type = 4'd2;
            case(funct3)
            3'b000 :
            begin
			    ALUOp	 = 5'd1;
			    RegWrite = 1'b1;
            end
            3'b010 :
            begin
			    ALUOp	 = 5'd4;
			    RegWrite = 1'b1;
            end
            3'b011 :
            begin
			    ALUOp	 = 5'd5;
			    RegWrite = 1'b1;
            end
            3'b100 :
            begin
			    ALUOp	 = 5'd6;
			    RegWrite = 1'b1;
            end
            3'b110 :
            begin
			    ALUOp	 = 5'd9;
			    RegWrite = 1'b1;
            end
            3'b111 :
            begin
			    ALUOp	 = 5'd10;
			    RegWrite = 1'b1;
            end
            3'b001 :
            begin
			    ALUOp	 = 5'd3;
			    RegWrite = 1'b1;
                Type = 4'd7;
            end
            3'b101 :
            begin
                ALUOp	 = funct7[5] ? 5'd8 : 5'd7;
				RegWrite = 1'b1;
                Type = 4'd7;
            end
            endcase
		end
		7'b000_0011 : 
        begin // lw
            Type = 4'd2;
			MemtoReg = 1'b1;
			ALUOp	 = 5'd1;
		  	RegWrite = 1'b1;
		end
        7'b110_0111 : 
        begin // jalr
            Type = 4'd9;
		  	RegWrite = 1'b1;
			ALUOp	 = 5'd19;
		end
        // S type
        /*-----------------------------------------------------------*/
		7'b010_0011 : 
        begin // sw
            Type = 4'd3;
		  	ALUOp	 = 5'd1;
			MemWrite = 1'b1;
		end
        // B type
        /*-----------------------------------------------------------*/
        7'b110_0011 :
        begin
            Type = 4'd4;
            case(funct3)
			3'b000 : 
            begin 
				ALUOp	 = 5'd11 ;
			end
            3'b001 : 
            begin 
				ALUOp	 = 5'd12 ;
			end
            3'b100 : 
            begin 
				ALUOp	 = 5'd13 ;
			end
            3'b101 : 
            begin 
				ALUOp	 = 5'd14 ;
			end
            3'b110 : 
            begin 
				ALUOp	 = 5'd15 ;
			end
            3'b111 : 
            begin 
				ALUOp	 = 5'd16 ;
			end
			endcase
        end
        // U type
        /*-----------------------------------------------------------*/
        7'b001_0111 : 
        begin 
            Type = 4'd5;
			RegWrite = 1'b1;	
            ALUOp	 = 5'd1;	
		end
        7'b011_0111 : 
        begin 
            Type = 4'd8;
			RegWrite = 1'b1;		
            ALUOp	 = 5'd1;
		end

		// J Type
		7'b110_1111 : 
        begin 
            Type = 4'd6;
			RegWrite = 1'b1;	
			ALUOp	 = 5'd20;	
		end
		endcase // opcode
	end
	
endmodule





