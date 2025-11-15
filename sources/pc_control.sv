`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/15/2025 07:43:24 PM
// Design Name: 
// Module Name: pc_control
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


module pc_control(
    input logic [31:0] pc_current,
    input logic [31:0] pc_plus_4,
    input logic [31:0] imm,           // Branch/Jump offset
    input logic [31:0] rs1_data,      // For JALR
    input logic branch_taken,
    input logic jump,
    input logic [6:0] opcode,
    output logic [31:0] pc_next
);

    logic [31:0] branch_target;
    logic [31:0] jump_target;
    logic [31:0] jalr_target;
    
    always_comb begin
        // Calculate branch target: PC + imm
        branch_target = pc_current + imm;
        
        // Calculate jump target (JAL): PC + imm
        jump_target = pc_current + imm;
        
        // Calculate JALR target: (rs1 + imm) & ~1 (clear LSB)
        jalr_target = (rs1_data + imm) & 32'hFFFFFFFE;
        
        // PC Source Selection (Priority: Jump > Branch > Sequential)
        if (jump) begin
            if (opcode == 7'b1100111)  // JALR
                pc_next = jalr_target;
            else                        // JAL
                pc_next = jump_target;
        end
        else if (branch_taken)
            pc_next = branch_target;
        else
            pc_next = pc_plus_4;
    end

endmodule
