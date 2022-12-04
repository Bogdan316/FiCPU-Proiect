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
    output       reg_as_addr
);

reg [13:0] controls;

assign {mem_write, reg_write, acc_write, transfer_a, psh, pop, alu_to_reg, update_flags, bra, brz, brn, brc, bro, reg_as_addr} = controls;

always @ (*)
    case(op)
        // MEM OP CODES
        6'b000001: controls <= 14'b01000000000000; //LDR
        6'b000010: controls <= 14'b10000000000000; //STR
        6'b000011: controls <= 14'b00001000000000; //PSH
        6'b000100: controls <= 14'b01000100000000; //POP
        6'b000101: controls <= 14'b01000000000001; //LDR (TREAT REG VALUE AS ADDRESS)
        // BRANCH OP CODE                     
        6'b000110: controls <= 14'b00000000100000; //BRA
        6'b000111: controls <= 14'b00000000010000; //BRZ
        6'b001000: controls <= 14'b00000000001000; //BRN
        6'b001001: controls <= 14'b00000000000100; //BRC
        6'b001010: controls <= 14'b00000000000010; //BRO
        // ALU OP CODE                         
        6'b100000: controls <= 14'b00100001000000; //ADD
        6'b100001: controls <= 14'b00100001000000; //SUB
        6'b100110: controls <= 14'b01010001000000; //TRANSFER A
        6'b100111: controls <= 14'b01000011000000; //MOV TO REG
        6'b101000: controls <= 14'b00100001000000; //MUL
        default:   controls <= 14'bxxxxxxxxxxxxxx; //???
    endcase
    
endmodule

