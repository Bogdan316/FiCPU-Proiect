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
    output       mov,
    output       psh,
    output       pop
);

reg [5:0] controls;

assign {mem_write, reg_write, acc_write, mov, psh, pop} = controls;

always @ (*)
    case(op)
        // MEM OP CODES
        6'b000001: controls <= 6'b010000; //LDR
        6'b000010: controls <= 6'b100000; //STR
        6'b000011: controls <= 6'b000010; //PSH
        6'b000100: controls <= 6'b010001; //POP
        // ALU OP CODES
        6'b100000: controls <= 6'b001000; //ADD
        6'b100001: controls <= 6'b001000; //SUB
        6'b100110: controls <= 6'b010100; //MOV FROM A
        default:   controls <= 6'bxxxxxx; //???
    endcase
    
endmodule

