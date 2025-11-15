`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/09/2025 02:23:38 PM
// Design Name: 
// Module Name: program_counter_tb
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


module program_counter_tb;

reg clk;
    reg reset;
    reg [31:0] pc_next;
    wire [31:0] pc;

    program_counter PC_inst(
        .pc_next(pc_next),
        .clk(clk),
        .reset(reset),
        .pc(pc)
    );

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        reset = 1;
        pc_next = 32'h00000000;

        #2 reset = 0;
        #10 reset = 1;

        pc_next = 32'h00000004;
        #10 pc_next = 32'h00000008;
        #10 pc_next = 32'h0000000C;
        #10 pc_next = 32'h00000010;

        #20 $finish;
    end

    initial begin
        $monitor("Time: %0t | reset=%b | pc_next=%h | pc=%h", $time, reset, pc_next, pc);
    end

endmodule