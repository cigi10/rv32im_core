`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/14/2025 11:28:58 PM
// Design Name: 
// Module Name: decoder_tb
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


module decoder_tb;
    reg [31:0] instruction;
    wire [4:0] rd, rs1, rs2;
    wire [31:0] imm;
    wire [3:0] alu_op;
    wire [6:0] opcode, funct7;
    wire [2:0] funct3;
    
    decoder uut(
        .instruction(instruction),
        .rd(rd),
        .rs1(rs1),
        .rs2(rs2),
        .imm(imm),
        .alu_op(alu_op),
        .opcode(opcode),
        .funct3(funct3),
        .funct7(funct7)
    );
    
    initial begin
        $display("Starting Decoder Testbench...");
        $display("Time\tInstruction\t\tOpcode\trd\trs1\trs2\timm\t\talu_op");
        
        // R-type: ADD x1, x2, x3
        instruction = 32'b0000000_00011_00010_000_00001_0110011;
        #10;
        $display("%0t\tADD x%0d,x%0d,x%0d\t\t%b\t%d\t%d\t%d\t%h\t%b", 
                 $time, rd, rs1, rs2, opcode, rd, rs1, rs2, imm, alu_op);
        
        // R-type: SUB x4, x5, x6
        instruction = 32'b0100000_00110_00101_000_00100_0110011;
        #10;
        $display("%0t\tSUB x%0d,x%0d,x%0d\t\t%b\t%d\t%d\t%d\t%h\t%b", 
                 $time, rd, rs1, rs2, opcode, rd, rs1, rs2, imm, alu_op);
        
        // R-type: AND x7, x8, x9
        instruction = 32'b0000000_01001_01000_111_00111_0110011;
        #10;
        $display("%0t\tAND x%0d,x%0d,x%0d\t\t%b\t%d\t%d\t%d\t%h\t%b", 
                 $time, rd, rs1, rs2, opcode, rd, rs1, rs2, imm, alu_op);
        
        // R-type: OR x10, x11, x12
        instruction = 32'b0000000_01100_01011_110_01010_0110011;
        #10;
        $display("%0t\tOR x%0d,x%0d,x%0d\t\t%b\t%d\t%d\t%d\t%h\t%b", 
                 $time, rd, rs1, rs2, opcode, rd, rs1, rs2, imm, alu_op);
        
        // R-type: XOR x13, x14, x15
        instruction = 32'b0000000_01111_01110_100_01101_0110011;
        #10;
        $display("%0t\tXOR x%0d,x%0d,x%0d\t\t%b\t%d\t%d\t%d\t%h\t%b", 
                 $time, rd, rs1, rs2, opcode, rd, rs1, rs2, imm, alu_op);
        
        // R-type: SLL x16, x17, x18
        instruction = 32'b0000000_10010_10001_001_10000_0110011;
        #10;
        $display("%0t\tSLL x%0d,x%0d,x%0d\t\t%b\t%d\t%d\t%d\t%h\t%b", 
                 $time, rd, rs1, rs2, opcode, rd, rs1, rs2, imm, alu_op);
        
        // R-type: SRL x19, x20, x21
        instruction = 32'b0000000_10101_10100_101_10011_0110011;
        #10;
        $display("%0t\tSRL x%0d,x%0d,x%0d\t\t%b\t%d\t%d\t%d\t%h\t%b", 
                 $time, rd, rs1, rs2, opcode, rd, rs1, rs2, imm, alu_op);
        
        // R-type: SLT x22, x23, x24
        instruction = 32'b0000000_11000_10111_010_10110_0110011;
        #10;
        $display("%0t\tSLT x%0d,x%0d,x%0d\t\t%b\t%d\t%d\t%d\t%h\t%b", 
                 $time, rd, rs1, rs2, opcode, rd, rs1, rs2, imm, alu_op);
        
        // R-type: MUL x25, x26, x27
        instruction = 32'b0000001_11011_11010_000_11001_0110011;
        #10;
        $display("%0t\tMUL x%0d,x%0d,x%0d\t\t%b\t%d\t%d\t%d\t%h\t%b", 
                 $time, rd, rs1, rs2, opcode, rd, rs1, rs2, imm, alu_op);
        
        // R-type: DIV x28, x29, x30
        instruction = 32'b0000001_11110_11101_100_11100_0110011;
        #10;
        $display("%0t\tDIV x%0d,x%0d,x%0d\t\t%b\t%d\t%d\t%d\t%h\t%b", 
                 $time, rd, rs1, rs2, opcode, rd, rs1, rs2, imm, alu_op);
        
        // I-type: ADDI x1, x2, 100
        instruction = 32'b000001100100_00010_000_00001_0010011;
        #10;
        $display("%0t\tADDI x%0d,x%0d,%0d\t\t%b\t%d\t%d\t%d\t%h\t%b", 
                 $time, rd, rs1, $signed(imm), opcode, rd, rs1, rs2, imm, alu_op);
        
        // I-type: ANDI x3, x4, 255
        instruction = 32'b000011111111_00100_111_00011_0010011;
        #10;
        $display("%0t\tANDI x%0d,x%0d,%0d\t\t%b\t%d\t%d\t%d\t%h\t%b", 
                 $time, rd, rs1, $signed(imm), opcode, rd, rs1, rs2, imm, alu_op);
        
        // I-type: ORI x5, x6, 128
        instruction = 32'b000010000000_00110_110_00101_0010011;
        #10;
        $display("%0t\tORI x%0d,x%0d,%0d\t\t%b\t%d\t%d\t%d\t%h\t%b", 
                 $time, rd, rs1, $signed(imm), opcode, rd, rs1, rs2, imm, alu_op);
        
        // I-type: XORI x7, x8, -1
        instruction = 32'b111111111111_01000_100_00111_0010011;
        #10;
        $display("%0t\tXORI x%0d,x%0d,%0d\t\t%b\t%d\t%d\t%d\t%h\t%b", 
                 $time, rd, rs1, $signed(imm), opcode, rd, rs1, rs2, imm, alu_op);
        
        // I-type: SLLI x9, x10, 4
        instruction = 32'b0000000_00100_01010_001_01001_0010011;
        #10;
        $display("%0t\tSLLI x%0d,x%0d,%0d\t\t%b\t%d\t%d\t%d\t%h\t%b", 
                 $time, rd, rs1, imm[4:0], opcode, rd, rs1, rs2, imm, alu_op);
        
        // I-type: SRLI x11, x12, 2
        instruction = 32'b0000000_00010_01100_101_01011_0010011;
        #10;
        $display("%0t\tSRLI x%0d,x%0d,%0d\t\t%b\t%d\t%d\t%d\t%h\t%b", 
                 $time, rd, rs1, imm[4:0], opcode, rd, rs1, rs2, imm, alu_op);
        
        // Load: LW x13, 20(x14)
        instruction = 32'b000000010100_01110_010_01101_0000011;
        #10;
        $display("%0t\tLW x%0d,%0d(x%0d)\t\t%b\t%d\t%d\t%d\t%h\t%b", 
                 $time, rd, $signed(imm), rs1, opcode, rd, rs1, rs2, imm, alu_op);
        
        // Store: SW x15, 40(x16)
        instruction = 32'b0000001_01111_10000_010_01000_0100011;
        #10;
        $display("%0t\tSW x%0d,%0d(x%0d)\t\t%b\t%d\t%d\t%d\t%h\t%b", 
                 $time, rs2, $signed(imm), rs1, opcode, rd, rs1, rs2, imm, alu_op);
        
        // Branch: BEQ x17, x18, 8
        instruction = 32'b0_000010_10010_10001_000_0100_0_1100011;
        #10;
        $display("%0t\tBEQ x%0d,x%0d,%0d\t\t%b\t%d\t%d\t%d\t%h\t%b", 
                 $time, rs1, rs2, $signed(imm), opcode, rd, rs1, rs2, imm, alu_op);
        
        // Branch: BNE x19, x20, -16
        instruction = 32'b1_111110_10100_10011_001_0000_0_1100011;
        #10;
        $display("%0t\tBNE x%0d,x%0d,%0d\t\t%b\t%d\t%d\t%d\t%h\t%b", 
                 $time, rs1, rs2, $signed(imm), opcode, rd, rs1, rs2, imm, alu_op);
        
        // JAL x1, 100
        instruction = 32'b0_0000110010_0_00000000_00001_1101111;
        #10;
        $display("%0t\tJAL x%0d,%0d\t\t%b\t%d\t%d\t%d\t%h\t%b", 
                 $time, rd, $signed(imm), opcode, rd, rs1, rs2, imm, alu_op);
        
        // JALR x2, x3, 50
        instruction = 32'b000000110010_00011_000_00010_1100111;
        #10;
        $display("%0t\tJALR x%0d,x%0d,%0d\t\t%b\t%d\t%d\t%d\t%h\t%b", 
                 $time, rd, rs1, $signed(imm), opcode, rd, rs1, rs2, imm, alu_op);
        
        // LUI x4, 0x12345
        instruction = 32'b00010010001101000101_00100_0110111;
        #10;
        $display("%0t\tLUI x%0d,0x%h\t\t%b\t%d\t%d\t%d\t%h\t%b", 
                 $time, rd, imm[31:12], opcode, rd, rs1, rs2, imm, alu_op);
        
        // AUIPC x5, 0xABCDE
        instruction = 32'b10101011110011011110_00101_0010111;
        #10;
        $display("%0t\tAUIPC x%0d,0x%h\t\t%b\t%d\t%d\t%d\t%h\t%b", 
                 $time, rd, imm[31:12], opcode, rd, rs1, rs2, imm, alu_op);
        
        $display("\nTestbench completed!");
        $finish;
    end
    
endmodule
