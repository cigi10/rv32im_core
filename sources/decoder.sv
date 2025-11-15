`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/14/2025 11:21:28 PM
// Design Name: 
// Module Name: decoder
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


`timescale 1ns / 1ps

module decoder(
    input [31:0] instruction,      
    output reg [4:0] rd,           
    output reg [4:0] rs1,          
    output reg [4:0] rs2,          
    output reg [31:0] imm,         
    output reg [3:0] alu_op,       
    output [6:0] opcode,           
    output [2:0] funct3,           
    output [6:0] funct7            
);

    assign opcode = instruction[6:0];
    assign funct3 = instruction[14:12];
    assign funct7 = instruction[31:25];
    
    always @(*) begin
        rd = 5'b0;
        rs1 = 5'b0;
        rs2 = 5'b0;
        imm = 32'b0;
        alu_op = 4'b0010;
        
        rd = instruction[11:7];
        rs1 = instruction[19:15];
        rs2 = instruction[24:20];
        
        case (opcode)
            7'b0110011: begin // R-type
                case (funct3)
                    3'b000: begin
                        if (funct7 == 7'b0000001)
                            alu_op = 4'b1001;  // MUL
                        else if (funct7[5])
                            alu_op = 4'b0110;  // SUB
                        else
                            alu_op = 4'b0010;  // ADD
                    end
                    3'b001: alu_op = (funct7 == 7'b0000001) ? 4'b1010 : 4'b0100;  // MULH : SLL
                    3'b010: alu_op = (funct7 == 7'b0000001) ? 4'b1011 : 4'b0111;  // MULHSU : SLT
                    3'b011: alu_op = (funct7 == 7'b0000001) ? 4'b1100 : 4'b1000;  // MULHU : SLTU (FIXED!)
                    3'b100: alu_op = (funct7 == 7'b0000001) ? 4'b1101 : 4'b0011;  // DIV : XOR
                    3'b101: alu_op = (funct7 == 7'b0000001) ? 4'b1110 : 4'b0101;  // DIVU : SRL/SRA
                    3'b110: alu_op = (funct7 == 7'b0000001) ? 4'b1111 : 4'b0001;  // REM : OR
                    3'b111: alu_op = (funct7 == 7'b0000001) ? 4'b0000 : 4'b0000;  // REMU : AND (both use same opcode)
                endcase
            end
            
            7'b0010011: begin // I-type: ADDI, ANDI, ORI, XORI, SLTI, SLLI, SRLI, SRAI
                imm = {{20{instruction[31]}}, instruction[31:20]};
                
                case (funct3)
                    3'b000: alu_op = 4'b0010;  // ADDI
                    3'b001: alu_op = 4'b0100;  // SLLI
                    3'b010: alu_op = 4'b0111;  // SLTI (signed)
                    3'b011: alu_op = 4'b1000;  // SLTIU (unsigned) - FIXED!
                    3'b100: alu_op = 4'b0011;  // XORI
                    3'b101: alu_op = 4'b0101;  // SRLI/SRAI
                    3'b110: alu_op = 4'b0001;  // ORI
                    3'b111: alu_op = 4'b0000;  // ANDI
                endcase
            end
            
            7'b0000011: begin // Load: LW, LH, LB, LHU, LBU
                imm = {{20{instruction[31]}}, instruction[31:20]};
                alu_op = 4'b0010;
            end
            
            7'b0100011: begin // Store: SW, SH, SB
                imm = {{20{instruction[31]}}, instruction[31:25], instruction[11:7]};
                alu_op = 4'b0010;
            end
            
            7'b1100011: begin // Branch: BEQ, BNE, BLT, BGE, BLTU, BGEU
                imm = {{19{instruction[31]}}, instruction[31], instruction[7], 
                       instruction[30:25], instruction[11:8], 1'b0};
                alu_op = 4'b0110;
            end
            
            7'b1101111: begin // JAL
                imm = {{11{instruction[31]}}, instruction[31], instruction[19:12],
                       instruction[20], instruction[30:21], 1'b0};
                alu_op = 4'b0010;
            end
            
            7'b1100111: begin // JALR
                imm = {{20{instruction[31]}}, instruction[31:20]};
                alu_op = 4'b0010;
            end
            
            7'b0110111: begin // LUI
                imm = {instruction[31:12], 12'b0};
                alu_op = 4'b0010;
            end
            
            7'b0010111: begin // AUIPC
                imm = {instruction[31:12], 12'b0};
                alu_op = 4'b0010;
            end
            
            default: begin
                alu_op = 4'b0010;
            end
        endcase
    end

endmodule