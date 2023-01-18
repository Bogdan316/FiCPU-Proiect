`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/27/2022 07:41:05 PM
// Design Name: 
// Module Name: main_dec
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


module main_dec(
    input  [5:0] op,
    output       mem_write,
    output       reg_write,
    output       acc_write,
    output       transfer_a,
    output       psh,
    output       pop,
    output       alu_to_reg,
    output       update_flags,
    output       bra,
    output       brz,
    output       brn,
    output       brc,
    output       bro,
    output       reg_as_addr,
    output       hlt,
    output       psh_pc,
    output       pop_pc,
    output       fpu_to_acc
);

reg [17:0] controls;

assign {mem_write, reg_write, acc_write, transfer_a, psh, pop, alu_to_reg, update_flags, bra, brz, brn, brc, bro, reg_as_addr, hlt, psh_pc, pop_pc, fpu_to_acc} = controls;

always @ (*)
    case(op)
        6'b000000: controls <= 18'b000000000000001000; // HLT
        // MEM OP CODES                          
        6'b000001: controls <= 18'b010000000000000000; // LDR
        6'b000010: controls <= 18'b100000000000000000; // STR
        6'b000011: controls <= 18'b000010000000000000; // PSH
        6'b000100: controls <= 18'b010001000000000000; // POP
        6'b000101: controls <= 18'b010000000000010000; // LDR (TREAT REG VALUE AS ADDRESS)
        6'b001011: controls <= 18'b100000000000010000; // STR (TREAT REG VALUE AS ADDRESS)
        // BRANCH OP CODE                         
        6'b000110: controls <= 18'b000000001000000000; // BRA
        6'b000111: controls <= 18'b000000000100000000; // BRZ
        6'b001000: controls <= 18'b000000000010000000; // BRN
        6'b001001: controls <= 18'b000000000001000000; // BRC
        6'b001010: controls <= 18'b000000000000100000; // BRO
        6'b001100: controls <= 18'b000000001000000100; // JMP
        6'b001101: controls <= 18'b000000000000000010; // RET
        // FPU                                     
        6'b001110: controls <= 18'b001000000000000001; // FPADD
        6'b001111: controls <= 18'b001000000000000001; // FPMUL
        6'b010000: controls <= 18'b001000000000000001; // FPSUB
        // ALU OP CODES                          
        6'b100000: controls <= 18'b001000010000000000; // ADD
        6'b100001: controls <= 18'b001000010000000000; // SUB
        6'b100110: controls <= 18'b010100010000000000; // TRANSFER A
        6'b100111: controls <= 18'b010000110000000000; // MOV TO REG
        6'b101000: controls <= 18'b001000010000000000; // MUL
        6'b101001: controls <= 18'b001000010000000000; // LSR
        6'b101010: controls <= 18'b001000010000000000; // LSL
        6'b101011: controls <= 18'b001000010000000000; // RSR
        6'b101100: controls <= 18'b001000010000000000; // RSL
        6'b101101: controls <= 18'b001000010000000000; // DIV
        6'b101110: controls <= 18'b001000010000000000; // MOD
        6'b101111: controls <= 18'b001000010000000000; // AND
        6'b110000: controls <= 18'b001000010000000000; // OR
        6'b110001: controls <= 18'b001000010000000000; // XOR
        6'b110010: controls <= 18'b001000010000000000; // NOT
        6'b110011: controls <= 18'b010000110000000000; // INC
        6'b110100: controls <= 18'b010000110000000000; // DEC
        6'b110101: controls <= 18'b000000010000000000; // CMP
        6'b110110: controls <= 18'b000000010000000000; // TST
        6'b110111: controls <= 18'b001000010000000000; // TRANSFER REG TO ACC
        6'b111000: controls <= 18'b010000110000000000; // ADDI
        6'b111001: controls <= 18'b010000110000000000; // SUBI
        6'b111010: controls <= 18'b010000110000000000; // MULI
        6'b111011: controls <= 18'b010000110000000000; // LSRI
        6'b111100: controls <= 18'b010000110000000000; // LSLI
        6'b111101: controls <= 18'b010000110000000000; // DIVI
        6'b111110: controls <= 18'b010000110000000000; // MODI
        default:   controls <= 18'bxxxxxxxxxxxxxxxxxx; // ???
    endcase
    
endmodule

