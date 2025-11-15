`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/09/2025 11:32:53 AM
// Design Name: 
// Module Name: instruction_mem
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


module instruction_mem(
    input [31:0] addr,
    output [31:0] m_code,
    input reset
    );
    
    reg [31:0] immem_block [1023:0];
    assign m_code = (reset == 1'b0) ? 32'h00000000 : immem_block[addr[31:2]];
    
endmodule 

