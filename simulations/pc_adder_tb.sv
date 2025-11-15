`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/09/2025 03:48:32 PM
// Design Name: 
// Module Name: pc_adder_tb
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


module pc_adder_tb;
 reg [31:0] addr;
    wire [31:0] pc_plus_4;

    pc_adder UUT(
        .addr(addr),
        .pc_plus_4(pc_plus_4)
    );

    initial begin
        addr = 32'h00000000;
        #10 addr = 32'h00000004;
        #10 addr = 32'h00000008;
        #10 addr = 32'h0000000C;
        #10 addr = 32'h00000010;

        #10 $finish;
    end

    initial begin
        $monitor("Time: %0t | addr=%h | pc_plus_4=%h", $time, addr, pc_plus_4);
    end

endmodule


