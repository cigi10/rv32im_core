`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/14/2025 10:31:21 PM
// Design Name: 
// Module Name: alu
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


module alu(
    input [31:0] op1,
    input [31:0] op2,
    input [2:0] funct3,      
    input [6:0] funct7,      
    input [3:0] alu_op,
    output reg zero,
    output reg [31:0] alu_result
);
    reg signed [63:0] mul_result_signed;
    reg [63:0] mul_result_unsigned;
    reg signed [63:0] mul_result_mixed;
    
    always @(*) begin
        case (alu_op)
            4'b0000: begin
                // Check if this is REMU (funct7=0000001, funct3=111) or AND
                if (funct7 == 7'b0000001 && funct3 == 3'b111) begin
                    // REMU (remainder unsigned)
                    if (op2 == 0)
                        alu_result = op1;
                    else
                        alu_result = op1 % op2;
                end else begin
                    // AND
                    alu_result = op1 & op2;
                end
            end
            4'b0001: alu_result = op1 | op2;           // OR
            4'b0010: alu_result = op1 + op2;           // ADD
            4'b0011: alu_result = op1 ^ op2;           // XOR
            4'b0100: alu_result = op1 << op2[4:0];     // SLL (shift left logical)
            4'b0101: begin                             // SRL/SRA based on funct7
                if (funct7 == 7'b0100000)              // SRA (arithmetic)
                    alu_result = $signed(op1) >>> op2[4:0];
                else                                    // SRL (logical)
                    alu_result = op1 >> op2[4:0];
            end
            4'b0110: alu_result = op1 - op2;           // SUB
            4'b0111: alu_result = ($signed(op1) < $signed(op2)) ? 32'd1 : 32'd0;  // SLT (signed)
            4'b1000: alu_result = (op1 < op2) ? 32'd1 : 32'd0;  // SLTU (unsigned)
            4'b1001: begin                             // MUL (multiply lower 32 bits)
                mul_result_signed = $signed(op1) * $signed(op2);
                alu_result = mul_result_signed[31:0];
            end
            4'b1010: begin                             // MULH (multiply high signed)
                mul_result_signed = $signed(op1) * $signed(op2);
                alu_result = mul_result_signed[63:32];
            end
            4'b1011: begin                             // MULHSU (multiply high signed × unsigned)
                mul_result_mixed = $signed(op1) * $signed({1'b0, op2});
                alu_result = mul_result_mixed[63:32];
            end
            4'b1100: begin                             // MULHU (multiply high unsigned)
                mul_result_unsigned = op1 * op2;
                alu_result = mul_result_unsigned[63:32];
            end
            4'b1101: begin                             // DIV (divide signed)
                if (op2 == 0)
                    alu_result = 32'hFFFFFFFF;
                else if (op1 == 32'h80000000 && op2 == 32'hFFFFFFFF)
                    alu_result = 32'h80000000;
                else
                    alu_result = $signed(op1) / $signed(op2);
            end
            4'b1110: begin                             // DIVU (divide unsigned)
                if (op2 == 0)
                    alu_result = 32'hFFFFFFFF;
                else
                    alu_result = op1 / op2;
            end
            4'b1111: begin                             // REM (remainder signed)
                if (op2 == 0)
                    alu_result = op1;
                else if (op1 == 32'h80000000 && op2 == 32'hFFFFFFFF)
                    alu_result = 0;
                else
                    alu_result = $signed(op1) % $signed(op2);
            end
            default: alu_result = 0;
        endcase
        
        zero = (alu_result == 0);
    end
    
endmodule