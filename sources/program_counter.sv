`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/09/2025 02:17:14 PM
// Design Name: 
// Module Name: program_counter
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


module program_counter(
    input [31:0] pc_next,
    input clk,reset,
    output reg [31:0] pc
    );
    
     always @(posedge clk)
    begin
        pc <= (reset == 1'b0)? 32'h00000000 : pc_next;
    end
    
endmodule
