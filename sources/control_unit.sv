`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/15/2025 06:31:33 PM
// Design Name: 
// Module Name: control_unit
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


// R-type instructions (both standard and M-extension)
// Standard: ADD, SUB, AND, OR, XOR, SLL, SRL, SRA, SLT, SLTU
// M-extension: MUL, MULH, MULHU, MULHSU, DIV, DIVU, REM, REMU
// Decoder differentiates via funct7 field

`timescale 1ns / 1ps

module control_unit(
    input logic [6:0] opcode,
    output logic reg_write,
    output logic mem_to_reg,
    output logic mem_read,
    output logic mem_write,
    output logic alu_src,      // 0 = rs2, 1 = immediate
    output logic branch,
    output logic jump,
    output logic [1:0] result_src  // 00=ALU, 01=Mem, 10=PC+4
);

    always_comb begin
        // Default values
        reg_write = 1'b0;
        mem_to_reg = 1'b0;
        mem_read = 1'b0;
        mem_write = 1'b0;
        alu_src = 1'b0;
        branch = 1'b0;
        jump = 1'b0;
        result_src = 2'b00;
        
        case(opcode)
            7'b0110011: begin  // R-type (includes M-extension)
                reg_write = 1'b1;
                alu_src = 1'b0;    // Use rs2
                result_src = 2'b00; // ALU result
            end
            
            7'b0010011: begin  // I-type arithmetic
                reg_write = 1'b1;
                alu_src = 1'b1;    // Use immediate
                result_src = 2'b00; // ALU result
            end
            
            7'b0000011: begin  // Load
                reg_write = 1'b1;
                mem_read = 1'b1;
                alu_src = 1'b1;
                result_src = 2'b01; // Memory data
            end
            
            7'b0100011: begin  // Store
                mem_write = 1'b1;
                alu_src = 1'b1;
            end
            
            7'b1100011: begin  // Branch
                branch = 1'b1;
                alu_src = 1'b0;
            end
            
            7'b1101111: begin  // JAL
                jump = 1'b1;
                reg_write = 1'b1;
                result_src = 2'b10; // PC+4 (return address)
            end
            
            7'b1100111: begin  // JALR
                jump = 1'b1;
                reg_write = 1'b1;
                alu_src = 1'b1;
                result_src = 2'b10; // PC+4 (return address)
            end
            
            7'b0110111: begin  // LUI
                reg_write = 1'b1;
                alu_src = 1'b1;
                result_src = 2'b00;
            end
            
            7'b0010111: begin  // AUIPC
                reg_write = 1'b1;
                alu_src = 1'b1;
                result_src = 2'b00;
            end
            
            default: begin
                // All signals remain at default
            end
        endcase
    end

endmodule