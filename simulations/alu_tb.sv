`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/14/2025 10:54:55 PM
// Design Name: 
// Module Name: alu_tb
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


module alu_unit_tb;
    reg [31:0] op1, op2;
    reg [3:0] alu_op;
    wire [31:0] alu_result;
    wire zero;
    
    alu uut(
        .op1(op1),
        .op2(op2),
        .alu_op(alu_op),
        .zero(zero),
        .alu_result(alu_result)
    );
    
    initial begin
        $display("Starting ALU testbench...");
        $display("Time\tOp\tOP1\t\tOP2\t\tResult\t\tZero");
        $monitor("%0t\t%b\t%d\t%d\t%d\t%b", $time, alu_op, op1, op2, alu_result, zero);
        
        op1 = 32'd200;
        op2 = 32'd100;
        
        alu_op = 4'b0000;
        #20;
        
        alu_op = 4'b0001;
        #20;
        
        alu_op = 4'b0010;
        #20;
        
        alu_op = 4'b0011;
        #20;
        
        alu_op = 4'b0100;
        op1 = 32'd16;
        op2 = 32'd2;
        #20;
        
        alu_op = 4'b0101;
        #20;
        
        alu_op = 4'b0110;
        op1 = 32'd200;
        op2 = 32'd100;
        #20;
        
        alu_op = 4'b0111;
        #20;
        
        op1 = 32'd15;
        op2 = 32'd3;
        alu_op = 4'b1000;
        #20;
        
        op1 = 32'hFFFFFFFF;
        op2 = 32'hFFFFFFFF;
        alu_op = 4'b1001;
        #20;
        
        op1 = 32'hFFFFFFFF;
        op2 = 32'h00000002;
        alu_op = 4'b1010;
        #20;
        
        op1 = 32'hFFFFFFFF;
        op2 = 32'hFFFFFFFF;
        alu_op = 4'b1011;
        #20;
        
        op1 = 32'd100;
        op2 = 32'd10;
        alu_op = 4'b1100;
        #20;
        
        op1 = 32'd100;
        op2 = 32'd0;
        alu_op = 4'b1100;
        #20;
        
        op1 = 32'h80000000;
        op2 = 32'hFFFFFFFF;
        alu_op = 4'b1100;
        #20;
        
        op1 = 32'd100;
        op2 = 32'd10;
        alu_op = 4'b1101;
        #20;
        
        op1 = 32'd100;
        op2 = 32'd0;
        alu_op = 4'b1101;
        #20;
        
        op1 = 32'd107;
        op2 = 32'd10;
        alu_op = 4'b1110;
        #20;
        
        op1 = 32'd107;
        op2 = 32'd0;
        alu_op = 4'b1110;
        #20;
        
        op1 = 32'h80000000;
        op2 = 32'hFFFFFFFF;
        alu_op = 4'b1110;
        #20;
        
        op1 = 32'd107;
        op2 = 32'd10;
        alu_op = 4'b1111;
        #20;
        
        op1 = 32'd107;
        op2 = 32'd0;
        alu_op = 4'b1111;
        #20;
        
        op1 = 32'd100;
        op2 = 32'd100;
        alu_op = 4'b0110;
        #20;
        
        $display("Testbench completed!");
        $finish;
    end
    
endmodule