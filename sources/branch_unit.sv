`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/15/2025 07:28:52 PM
// Design Name: 
// Module Name: branch_unit
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

module branch_unit(
    input logic [31:0] rs1_data,
    input logic [31:0] rs2_data,
    input logic [2:0] funct3,
    input logic branch,              // Branch enable from control unit
    output logic branch_taken
);

    logic comparison_result;
    
    // Branch comparison logic
    always_comb begin
        case(funct3)
            3'b000: comparison_result = (rs1_data == rs2_data);                    // BEQ
            3'b001: comparison_result = (rs1_data != rs2_data);                    // BNE
            3'b100: comparison_result = ($signed(rs1_data) < $signed(rs2_data));  // BLT
            3'b101: comparison_result = ($signed(rs1_data) >= $signed(rs2_data)); // BGE
            3'b110: comparison_result = (rs1_data < rs2_data);                     // BLTU
            3'b111: comparison_result = (rs1_data >= rs2_data);                    // BGEU
            default: comparison_result = 1'b0;
        endcase
        
        // Branch taken = branch instruction AND condition met
        branch_taken = branch & comparison_result;
    end

endmodule