`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/15/2025 10:19:58 PM
// Design Name: 
// Module Name: top
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


module top(
    input logic clk,
    input logic reset
);

    logic [31:0] pc;
    logic [31:0] pc_plus_4;
    logic [31:0] pc_next;

    logic [31:0] instruction;

    logic [4:0] rd;
    logic [4:0] rs1;
    logic [4:0] rs2;

    logic [31:0] imm;
    logic [3:0] alu_op;

    logic [6:0] opcode;
    logic [2:0] funct3;
    logic [6:0] funct7;

    logic reg_write;
    logic mem_to_reg;
    logic mem_read;
    logic mem_write;
    logic alu_src;
    logic branch;
    logic jump;
    logic [1:0] result_src;

    logic [31:0] rs1_data;
    logic [31:0] rs2_data;

    logic [31:0] alu_in2;
    logic [31:0] alu_result;
    logic alu_zero;

    logic branch_taken;

    logic [31:0] mem_data;

    logic [31:0] wb_data;

    program_counter ProgramCounter(
        .pc_next(pc_next),
        .clk(clk),
        .reset(reset),
        .pc(pc)
    );

    pc_adder PC_adder(
        .addr(pc),
        .pc_plus_4(pc_plus_4)
    );

    instruction_mem Intruction_Memory(
        .addr(pc),
        .m_code(instruction),
        .reset(reset)
    );

    decoder Decoder(
        .instruction(instruction),
        .rd(rd),
        .rs1(rs1),
        .rs2(rs2),
        .imm(imm),
        .alu_op(alu_op),
        .opcode(opcode),
        .funct3(funct3),
        .funct7(funct7)
    );

    control_unit Control_Unit(
        .opcode(opcode),
        .reg_write(reg_write),
        .mem_to_reg(mem_to_reg),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .alu_src(alu_src),
        .branch(branch),
        .jump(jump),
        .result_src(result_src)
    );

    reg_file Register_File(
        .rs1(rs1),
        .rs2(rs2),
        .write_register(rd),
        .write_data(wb_data),
        .reg_write(reg_write),
        .clk(clk),
        .reset(reset),
        .read_data_1(rs1_data),
        .read_data_2(rs2_data)
    );

    assign alu_in2 = alu_src ? imm : rs2_data;

    alu ALU(
        .op1(rs1_data),
        .op2(alu_in2),
        .alu_op(alu_op),
        .funct7(funct7),
        .funct3(funct3),
        .zero(alu_zero),
        .alu_result(alu_result)
    );

    branch_unit Branch_Unit(
        .rs1_data(rs1_data),
        .rs2_data(rs2_data),
        .funct3(funct3),
        .branch(branch),
        .branch_taken(branch_taken)
    );

    data_mem Data_Memory(
        .alu_out(alu_result),
        .data_in(rs2_data),
        .mem_read(mem_read),
        .clk(clk),
        .mem_write(mem_write),
        .data_out(mem_data)
    );

    always_comb begin
        case (result_src)
            2'b00: wb_data = alu_result;
            2'b01: wb_data = mem_data;
            2'b10: wb_data = pc_plus_4;
            default: wb_data = 32'b0;
        endcase
    end

    pc_control PC_Control(
        .pc_current(pc),
        .pc_plus_4(pc_plus_4),
        .imm(imm),
        .rs1_data(rs1_data),
        .branch_taken(branch_taken),
        .jump(jump),
        .opcode(opcode),
        .pc_next(pc_next)
    );

endmodule
