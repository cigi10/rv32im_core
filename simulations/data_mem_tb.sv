`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/09/2025 12:31:50 PM
// Design Name: 
// Module Name: data_mem_tb
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


module data_mem_tb;

    reg [31:0] alu_out;
    reg [31:0] data_in;
    reg mem_read;
    reg mem_write;
    reg clk;

    wire [31:0] data_out;

    data_mem DUT (
        .alu_out(alu_out),
        .data_in(data_in),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .data_out(data_out),
        .clk(clk) 
    );

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        alu_out = 0;
        data_in = 0;
        mem_read = 0;
        mem_write = 0;

        #10;

        alu_out = 32'd0;
        data_in = 32'hDEADBEEF;
        mem_write = 1;
        #10;
        mem_write = 0;

        mem_read = 1;
        #1;
        $display("%h", data_out);
        mem_read = 0;

        alu_out = 32'd4;
        data_in = 32'hCAFEBABE;
        mem_write = 1;
        #10;
        mem_write = 0;

        mem_read = 1;
        #1;
        $display("%h", data_out);
        mem_read = 0;

        alu_out = 32'd0;
        #1;
        $display("%h", data_out);

        #10;
        $finish;
    end

endmodule

