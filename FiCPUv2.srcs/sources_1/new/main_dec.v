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
    output       bra
);

reg [8:0] controls;

assign {mem_write, reg_write, acc_write, transfer_a, psh, pop, alu_to_reg, update_flags, bra} = controls;

always @ (*)
    case(op)
        // MEM OP CODES
        6'b000001: controls <= 9'b010000000; //LDR
        6'b000010: controls <= 9'b100000000; //STR
        6'b000011: controls <= 9'b000010000; //PSH
        6'b000100: controls <= 9'b010001000; //POP
        6'b000101: controls <= 9'b000000001; //BRA
        // ALU OP CODE         
        6'b100000: controls <= 9'b001000010; //ADD
        6'b100001: controls <= 9'b001000010; //SUB
        6'b100110: controls <= 9'b010100000; //TRANSFER A
        6'b100111: controls <= 9'b010000110; //MOV TO REG
        default:   controls <= 9'bxxxxxxxxx; //???
    endcase
    
endmodule

