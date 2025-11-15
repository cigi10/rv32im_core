`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/14/2025 09:56:41 PM
// Design Name: 
// Module Name: reg_file_tb
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


module reg_file_tb;

    
    reg [4:0] register_read_1, register_read_2, write_register, address, address2;
    reg reg_write, clk, reset;
    reg [31:0] write_data;
    wire [31:0] read_data_1, read_data_2;

    reg_file uut (
        .register_read_1(register_read_1),
        .register_read_2(register_read_2),
        .write_register(write_register),
        .write_data(write_data),
        .reg_write(reg_write),
        .clk(clk),
        .reset(reset),
        .read_data_1(read_data_1),
        .read_data_2(read_data_2)
    );

    integer i;
    initial begin
        // Initialize inputs
        clk = 0;
        reset = 1;
        reg_write = 0;
        address = 0;
        address2 = 0;

        #5 reset = 0; 
        #20 reset = 1;

        for (i = 0; i < 32; i = i + 1) begin
            uut.Registers[i] = 32'h00000000; 
        end

        for (i = 0; i < 5; i = i + 1) begin
            write_register = i;
            write_data = i * 10; 
            reg_write = 1;
            #10; 
        end
        reg_write = 0; 

        for (i = 0; i < 5; i = i + 1) begin
            register_read_1 = i;
            register_read_2 = 4 - i;
            #10;
        end

        #100;
        
    end

    always #5 clk = ~clk;

endmodule
