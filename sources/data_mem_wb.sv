`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/09/2025 12:17:35 PM
// Design Name: 
// Module Name: data_mem_wb
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


module data_mem(
    input [31:0] alu_out,
    input [31:0] data_in,
    input mem_read, clk,
    input mem_write,
    output [31:0] data_out
    );
    
    reg [31:0] data_mem_block [1023:0];
    assign data_out = (mem_read)? data_mem_block[alu_out[31:2]] : 32'h00000000;
    always @(posedge clk) begin
        if (mem_write) begin
            data_mem_block[alu_out[31:2]] <= data_in;
        end
    end
    
endmodule
