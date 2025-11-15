`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/09/2025 11:48:32 AM
// Design Name: 
// Module Name: instruction_mem_tb
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


module instruction_mem_tb;

    reg [31:0] addr;
    reg reset;
    wire [31:0] m_code;

    instruction_mem uut (
        .addr(addr),
        .reset(reset),
        .m_code(m_code)
    );

    integer i;
    initial begin
        reset = 0;
        addr = 0;

        for (i = 0; i < 1024; i = i + 1) begin
            uut.immem_block[i] = i * 4; 
        end
        #10;
        
        #10 reset = 0; addr = 32'h00000004; #10;
        #10 reset = 0; addr = 32'h00000008; #10;
        
        reset = 1; #10;
        addr = 32'h00000000; #10;
        addr = 32'h00000004; #10;
        addr = 32'h00000008; #10;

        $finish;
    end

endmodule
