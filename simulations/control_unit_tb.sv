`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/15/2025 06:46:21 PM
// Design Name: 
// Module Name: control_unit_tb
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


module control_unit_tb;

    logic [6:0] opcode;
    logic reg_write;
    logic mem_to_reg;
    logic mem_read;
    logic mem_write;
    logic alu_src;
    logic branch;
    logic jump;
    logic [1:0] result_src;

    control_unit dut (
        .opcode(opcode),
        .reg_write(reg_write),
        .mem_to_reg(mem_to_reg),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .alu_src(alu_src),
        .branch(branch),
        .jump(jump),
        .result_src(result_src)
    );

    task show(string name);
        $display("%s: RW=%0b MR=%0b MW=%0b B=%0b J=%0b RS=%0b%0b",
                 name, reg_write, mem_read, mem_write, branch, jump,
                 result_src[1], result_src[0]);
    endtask

    initial begin
        $display("Starting control unit tests...\n");

        // R-type
        opcode = 7'b0110011; #5;
        show("R-type");

        // I-type arithmetic
        opcode = 7'b0010011; #5;
        show("I-type");

        // Load
        opcode = 7'b0000011; #5;
        show("Load");

        // Store
        opcode = 7'b0100011; #5;
        show("Store");

        // Branch
        opcode = 7'b1100011; #5;
        show("Branch");

        // JAL
        opcode = 7'b1101111; #5;
        show("JAL");

        // JALR
        opcode = 7'b1100111; #5;
        show("JALR");

        // LUI
        opcode = 7'b0110111; #5;
        show("LUI");

        // AUIPC
        opcode = 7'b0010111; #5;
        show("AUIPC");

        // Default / unknown
        opcode = 7'b0000000; #5;
        show("Default");

        $display("\nControl unit tests done.");
        $finish;
    end

endmodule
