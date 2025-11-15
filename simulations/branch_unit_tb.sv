`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/15/2025 07:37:02 PM
// Design Name: 
// Module Name: branch_unit_tb
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


module branch_unit_tb;
    logic [31:0] rs1_data;
    logic [31:0] rs2_data;
    logic [2:0] funct3;
    logic branch;
    logic branch_taken;
    
    branch_unit dut(
        .rs1_data(rs1_data),
        .rs2_data(rs2_data),
        .funct3(funct3),
        .branch(branch),
        .branch_taken(branch_taken)
    );
    
    initial begin

    branch = 1'b1;

    funct3 = 3'b000; rs1_data = 32'd10; rs2_data = 32'd10; #10;
    $display("BEQ equal: taken=%b", branch_taken);

    funct3 = 3'b000; rs1_data = 32'd10; rs2_data = 32'd5; #10;
    $display("BEQ not equal: taken=%b", branch_taken);

    funct3 = 3'b001; rs1_data = 32'd10; rs2_data = 32'd5; #10;
    $display("BNE not equal: taken=%b", branch_taken);

    funct3 = 3'b001; rs1_data = 32'd10; rs2_data = 32'd10; #10;
    $display("BNE equal: taken=%b", branch_taken);

    funct3 = 3'b100; rs1_data = 32'd5; rs2_data = 32'd10; #10;
    $display("BLT less: taken=%b", branch_taken);

    funct3 = 3'b100; rs1_data = 32'd10; rs2_data = 32'd5; #10;
    $display("BLT greater: taken=%b", branch_taken);

    funct3 = 3'b101; rs1_data = 32'd10; rs2_data = 32'd5; #10;
    $display("BGE greater: taken=%b", branch_taken);

    funct3 = 3'b101; rs1_data = 32'd5; rs2_data = 32'd10; #10;
    $display("BGE less: taken=%b", branch_taken);

    funct3 = 3'b110; rs1_data = 32'd5; rs2_data = 32'd10; #10;
    $display("BLTU less: taken=%b", branch_taken);

    funct3 = 3'b111; rs1_data = 32'd10; rs2_data = 32'd5; #10;
    $display("BGEU greater: taken=%b", branch_taken);

    branch = 1'b0;
    funct3 = 3'b000; rs1_data = 32'd10; rs2_data = 32'd10; #10;
    $display("Branch disabled: taken=%b", branch_taken);
        
        $display("\nTest complete");
        $finish;
    end
    
endmodule
