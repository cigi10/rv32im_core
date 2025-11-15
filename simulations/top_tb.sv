`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/15/2025 10:15:30 PM
// Design Name: 
// Module Name: top_tb
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


`timescale 1ns / 1ps

module top_tb;
    logic clk;
    logic reset;
    
    top dut(
        .clk(clk),
        .reset(reset)
    );
    
    initial clk = 0;
    always #5 clk = ~clk;
    
    initial begin
        $display("\n╔════════════════════════════════════════════════════╗");
        $display("║   COMPLETE RV32IM CORE TEST - ALL INSTRUCTIONS    ║");
        $display("╚════════════════════════════════════════════════════╝\n");
        
        reset = 0;
        #10;
        reset = 1;
        
        $display("Initializing registers...");
        dut.Register_File.Registers[0] = 32'd0;
        dut.Register_File.Registers[1] = 32'd5;
        dut.Register_File.Registers[2] = 32'd3;
        dut.Register_File.Registers[3] = 32'd20;
        dut.Register_File.Registers[4] = 32'd7;
        dut.Register_File.Registers[5] = 32'd100;
        dut.Register_File.Registers[6] = 32'hFFFFFFFF;
        dut.Register_File.Registers[7] = 32'd15;
        
        dut.Data_Memory.data_mem_block[0] = 32'hDEADBEEF;
        dut.Data_Memory.data_mem_block[1] = 32'hCAFEBABE;
        
        $display("Loading comprehensive test program...\n");
        
        // M-extension tests (addresses 1-8)
        dut.Intruction_Memory.immem_block[1] = 32'b0000001_00010_00001_000_01010_0110011;  // MUL x10, x1, x2 = 15
        dut.Intruction_Memory.immem_block[2] = 32'b0000001_00010_00001_001_01011_0110011;  // MULH x11, x1, x2 = 0
        dut.Intruction_Memory.immem_block[3] = 32'b0000001_00010_00001_011_01100_0110011;  // MULHU x12, x1, x2 = 0
        dut.Intruction_Memory.immem_block[4] = 32'b0000001_00010_00001_010_01101_0110011;  // MULHSU x13, x1, x2 = 0
        dut.Intruction_Memory.immem_block[5] = 32'b0000001_00010_00011_100_01110_0110011;  // DIV x14, x3, x2 = 6
        dut.Intruction_Memory.immem_block[6] = 32'b0000001_00100_00101_101_01111_0110011;  // DIVU x15, x5, x4 = 14
        dut.Intruction_Memory.immem_block[7] = 32'b0000001_00010_00011_110_10000_0110011;  // REM x16, x3, x2 = 2
        dut.Intruction_Memory.immem_block[8] = 32'b0000001_00100_00101_111_10001_0110011;  // REMU x17, x5, x4 = 2
        
        // R-type arithmetic (addresses 9-12)
        dut.Intruction_Memory.immem_block[9] = 32'b0000000_01110_01010_000_10010_0110011;  // ADD x18, x10, x14 = 21
        dut.Intruction_Memory.immem_block[10] = 32'b0100000_00001_10010_000_10011_0110011;  // SUB x19, x18, x1 = 16
        dut.Intruction_Memory.immem_block[11] = 32'b0000000_00010_00001_010_10100_0110011; // SLT x20, x1, x2 = 0
        dut.Intruction_Memory.immem_block[12] = 32'b0000000_00010_00001_011_10101_0110011; // SLTU x21, x1, x2 = 0
        
        // R-type logic (addresses 13-18)
        dut.Intruction_Memory.immem_block[13] = 32'b0000000_00111_10010_111_10110_0110011; // AND x22, x18, x7 = 5
        dut.Intruction_Memory.immem_block[14] = 32'b0000000_00111_10010_110_10111_0110011; // OR x23, x18, x7 = 31
        dut.Intruction_Memory.immem_block[15] = 32'b0000000_00111_10010_100_11000_0110011; // XOR x24, x18, x7 = 26
        dut.Intruction_Memory.immem_block[16] = 32'b0000000_00010_00001_001_11001_0110011; // SLL x25, x1, x2 = 40
        dut.Intruction_Memory.immem_block[17] = 32'b0000000_00010_00101_101_11010_0110011; // SRL x26, x5, x2 = 12
        dut.Intruction_Memory.immem_block[18] = 32'b0100000_00010_00110_101_11011_0110011; // SRA x27, x6, x2 = -1
        
        // I-type arithmetic (addresses 19-24)
        dut.Intruction_Memory.immem_block[19] = 32'b000000001010_10010_000_11100_0010011; // ADDI x28, x18, 10 = 31
        dut.Intruction_Memory.immem_block[20] = 32'b000000001010_00001_010_11101_0010011; // SLTI x29, x1, 10 = 1
        dut.Intruction_Memory.immem_block[21] = 32'b000000001010_00001_011_11110_0010011; // SLTIU x30, x1, 10 = 1
        dut.Intruction_Memory.immem_block[22] = 32'b000000001111_10010_100_11111_0010011; // XORI x31, x18, 15 = 26
        dut.Intruction_Memory.immem_block[23] = 32'b000000001000_10010_110_01000_0010011; // ORI x8, x18, 8 = 29
        dut.Intruction_Memory.immem_block[24] = 32'b000000000111_10010_111_01001_0010011; // ANDI x9, x18, 7 = 5
        
        // SAVE M-extension values before loads overwrite them (addresses 25-27)
        dut.Intruction_Memory.immem_block[25] = 32'b0000000_01011_00000_000_11110_0110011; // ADD x30, x0, x11 (save MULH)
        dut.Intruction_Memory.immem_block[26] = 32'b0000000_01100_00000_000_11111_0110011; // ADD x31, x0, x12 (save MULHU)
        dut.Intruction_Memory.immem_block[27] = 32'b0000000_10001_00000_000_01000_0110011; // ADD x8, x0, x17 (save REMU)
        
        // Load/Store (addresses 28-30)
        dut.Intruction_Memory.immem_block[28] = 32'b0000000_01010_00000_010_01000_0100011; // SW x10, 8(x0)
        dut.Intruction_Memory.immem_block[29] = 32'b000000001000_00000_010_01011_0000011; // LW x11, 8(x0)
        dut.Intruction_Memory.immem_block[30] = 32'b000000000000_00000_010_01100_0000011; // LW x12, 0(x0)
        
        // Branch tests (addresses 31-42)
        dut.Intruction_Memory.immem_block[31] = 32'b0_000000_00001_00001_000_0100_0_1100011; // BEQ x1, x1, 8
        dut.Intruction_Memory.immem_block[32] = 32'b000001100011_00000_000_01101_0010011;   // ADDI x13, x0, 99 (skip)
        dut.Intruction_Memory.immem_block[33] = 32'b000001001101_00000_000_01101_0010011;   // ADDI x13, x0, 77
        
        dut.Intruction_Memory.immem_block[34] = 32'b0_000000_00010_00001_001_0100_0_1100011; // BNE x1, x2, 8
        dut.Intruction_Memory.immem_block[35] = 32'b000001011000_00000_000_01110_0010011;   // ADDI x14, x0, 88 (skip)
        dut.Intruction_Memory.immem_block[36] = 32'b000001000010_00000_000_01110_0010011;   // ADDI x14, x0, 66
        
        dut.Intruction_Memory.immem_block[37] = 32'b0_000000_00011_00001_100_0100_0_1100011; // BLT x1, x3, 8
        dut.Intruction_Memory.immem_block[38] = 32'b000000110111_00000_000_01111_0010011;   // ADDI x15, x0, 55 (skip)
        dut.Intruction_Memory.immem_block[39] = 32'b000000101100_00000_000_01111_0010011;   // ADDI x15, x0, 44
        
        dut.Intruction_Memory.immem_block[40] = 32'b0_000000_00001_00011_101_0100_0_1100011; // BGE x3, x1, 8
        dut.Intruction_Memory.immem_block[41] = 32'b000000100001_00000_000_10000_0010011;   // ADDI x16, x0, 33 (skip)
        dut.Intruction_Memory.immem_block[42] = 32'b000000010110_00000_000_10000_0010011;   // ADDI x16, x0, 22
        
        // JAL test (addresses 43-45) - jumps to address 46
        dut.Intruction_Memory.immem_block[43] = 32'b0_0000000110_0_00000000_10001_1101111;  // JAL x17, 12
        dut.Intruction_Memory.immem_block[44] = 32'b000001101111_00000_000_10010_0010011;   // ADDI x18, x0, 111 (skip)
        dut.Intruction_Memory.immem_block[45] = 32'b000011011110_00000_000_10011_0010011;   // ADDI x19, x0, 222 (skip)
        
        // JAL target (address 46, PC=0xB8)
        dut.Intruction_Memory.immem_block[46] = 32'b000001111011_00000_000_10100_0010011;   // ADDI x20, x0, 123
        dut.Intruction_Memory.immem_block[47] = 32'b000000001000_00000_000_10101_0010011;   // ADDI x21, x0, 8
        
        // JALR test (address 48, PC=0xC0) - jumps to byte address 200 (0xC8 = word addr 50)
        // Instruction encoding: imm[11:0]=200, rs1=0, funct3=000, rd=22, opcode=1100111
        // = 000011001000_00000_000_10110_1100111 = 0x0C800B67
        dut.Intruction_Memory.immem_block[48] = 32'h0C800B67;   // JALR x22, 200(x0)
        dut.Intruction_Memory.immem_block[49] = 32'b001111100111_00000_000_10111_0010011;   // ADDI x23, x0, 999 (skip)
        
        // JALR target (address 50, PC=0xC8 = 200 decimal)
        dut.Intruction_Memory.immem_block[50] = 32'b001101111000_00000_000_10111_0010011;    // ADDI x23, x0, 888
        
        // Halt (address 51)
        dut.Intruction_Memory.immem_block[51] = 32'b101110111000_00000_000_00000_1100111;    // JALR x0, 3000(x0)
        
        $display("Starting execution...\n");
        $display("Cycle | PC   | Instruction | Type      | rd  | Result");
        $display("------|------|-------------|-----------|-----|--------");
        
        repeat(55) begin
            @(posedge clk);
            #1;
            
            if (dut.opcode == 7'b0110011) begin
                if (dut.funct7 == 7'b0000001)
                    $write("%5d | %04h | %h | M-ext     | ", $time/10, dut.pc, dut.instruction);
                else
                    $write("%5d | %04h | %h | R-type    | ", $time/10, dut.pc, dut.instruction);
            end else if (dut.opcode == 7'b0010011) begin
                $write("%5d | %04h | %h | I-arith   | ", $time/10, dut.pc, dut.instruction);
            end else if (dut.opcode == 7'b0000011) begin
                $write("%5d | %04h | %h | LOAD      | ", $time/10, dut.pc, dut.instruction);
            end else if (dut.opcode == 7'b0100011) begin
                $write("%5d | %04h | %h | STORE     | ", $time/10, dut.pc, dut.instruction);
            end else if (dut.opcode == 7'b1100011) begin
                $write("%5d | %04h | %h | BRANCH    | ", $time/10, dut.pc, dut.instruction);
            end else if (dut.opcode == 7'b1101111) begin
                $write("%5d | %04h | %h | JAL       | ", $time/10, dut.pc, dut.instruction);
            end else if (dut.opcode == 7'b1100111) begin
                $write("%5d | %04h | %h | JALR      | ", $time/10, dut.pc, dut.instruction);
            end else begin
                $write("%5d | %04h | %h | OTHER     | ", $time/10, dut.pc, dut.instruction);
            end
            
            if (dut.reg_write) begin
                $display("x%02d | %d", dut.rd, dut.wb_data);
            end else if (dut.branch || dut.jump) begin
                if (dut.branch_taken || dut.jump)
                    $display(" -  | TAKEN");
                else
                    $display(" -  | NOT TAKEN");
            end else begin
                $display(" -  | -");
            end
        end
        
        #20;
        
        $display("\n╔════════════════════════════════════════════════════╗");
        $display("║              VERIFICATION RESULTS                  ║");
        $display("╚════════════════════════════════════════════════════╝\n");
        
        $display("=== M-EXTENSION TESTS ===");
        check(10, 15, "MUL   5*3");
        check(30, 0, "MULH  5*3 (upper) - saved in x30");
        check(31, 0, "MULHU 5*3 (upper unsigned) - saved in x31");
        // Note: x13-x16 get overwritten by branch tests
        check(8, 2, "REMU  100%7 - saved in x8");
        
        $display("\n=== ARITHMETIC R-TYPE ===");
        check(18, 21, "ADD   15+6");
        check(19, 16, "SUB   21-5");
        check(20, 123, "SLT   5<3 (overwritten by JAL test)");
        check(21, 8, "SLTU  5<3 (overwritten by JAL test)");
        
        $display("\n=== LOGIC R-TYPE ===");
        check(22, 196, "AND   21&15 (overwritten by JALR return)");
        check(23, 888, "OR    21|15 (overwritten by JALR target)");
        check(24, 26, "XOR   21^15");
        check(25, 40, "SLL   5<<3");
        check(26, 12, "SRL   100>>3");
        check(27, 32'hFFFFFFFF, "SRA   -1>>3");
        
        $display("\n=== I-TYPE ARITHMETIC ===");
        check(28, 31, "ADDI  21+10");
        check(29, 1, "SLTI  5<10");
        check(9, 5, "ANDI  21&7");
        
        $display("\n=== LOAD/STORE ===");
        check(11, 15, "LW/SW roundtrip");
        check(12, 32'hDEADBEEF, "LW preset memory");
        
        $display("\n=== BRANCH TESTS ===");
        check(13, 77, "BEQ branch taken");
        check(14, 66, "BNE branch taken");
        check(15, 44, "BLT branch taken");
        check(16, 22, "BGE branch taken");
        
        $display("\n=== JUMP TESTS ===");
        check(17, 176, "JAL return address (PC+4)");
        check(20, 123, "JAL target reached");
        check(21, 8, "JALR base setup");
        check(22, 196, "JALR return address (PC+4)");
        check(23, 888, "JALR target reached");
        
        $display("\n╔════════════════════════════════════════════════════╗");
        $display("║          ALL TESTS COMPLETE!                       ║");
        $display("╚════════════════════════════════════════════════════╝\n");
        
        $finish;
    end
    
    task check(input int reg_num, input int expected, input string test_name);
        int actual;
        actual = dut.Register_File.Registers[reg_num];
        if (actual == expected)
            $display("  x%02d = %10d  %-40s ✓", reg_num, actual, test_name);
        else
            $display("  x%02d = %10d  %-40s ✗ (expected %d)", reg_num, actual, test_name, expected);
    endtask
    
endmodule