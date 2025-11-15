`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/15/2025 07:54:06 PM
// Design Name: 
// Module Name: pc_control_tb
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


module pc_control_tb;

    logic [31:0] pc_current;
    logic [31:0] pc_plus_4;
    logic [31:0] imm;
    logic [31:0] rs1_data;
    logic branch_taken;
    logic jump;
    logic [6:0] opcode;
    logic [31:0] pc_next;

    pc_control dut (
        .pc_current(pc_current),
        .pc_plus_4(pc_plus_4),
        .imm(imm),
        .rs1_data(rs1_data),
        .branch_taken(branch_taken),
        .jump(jump),
        .opcode(opcode),
        .pc_next(pc_next)
    );

    initial begin
        pc_current = 100;
        pc_plus_4  = 104;
        rs1_data   = 50;

        $display("Starting PC control tests...");

        // --- Test 1: Normal sequential ---
        jump = 0; branch_taken = 0; imm = 20; opcode = 7'b1101111; #10;
        $display("Seq: pc_next=%0d", pc_next);

        // --- Test 2: Branch taken ---
        branch_taken = 1; jump = 0; imm = 16; #10;
        $display("Branch: pc_next=%0d", pc_next);

        // --- Test 3: JAL ---
        jump = 1; branch_taken = 0; opcode = 7'b1101111; imm = 32; #10;
        $display("JAL: pc_next=%0d", pc_next);

        // --- Test 4: JALR ---
        jump = 1; opcode = 7'b1100111; imm = 4; rs1_data = 200; #10;
        $display("JALR: pc_next=%0d", pc_next);

        // --- Test 5: Priority test (jump overrides branch) ---
        jump = 1; branch_taken = 1; opcode = 7'b1101111; imm = 8; #10;
        $display("Jump overrides branch: pc_next=%0d", pc_next);

        $display("PC control tests done.");
        $finish;
    end

endmodule
