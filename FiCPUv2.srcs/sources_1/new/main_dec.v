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
    output       update_flags
);

reg [7:0] controls;

assign {mem_write, reg_write, acc_write, transfer_a, psh, pop, alu_to_reg, update_flags} = controls;

always @ (*)
    case(op)
        // MEM OP CODES
        6'b000001: controls <= 8'b01000000; //LDR
        6'b000010: controls <= 8'b10000000; //STR
        6'b000011: controls <= 8'b00001000; //PSH
        6'b000100: controls <= 8'b01000100; //POP
        // ALU OP CODE         
        6'b100000: controls <= 8'b00100001; //ADD
        6'b100001: controls <= 8'b00100001; //SUB
        6'b100110: controls <= 8'b01010000; //TRANSFER A
        6'b100111: controls <= 8'b01000011; //MOV TO REG
        default:   controls <= 8'bxxxxxxxx; //???
    endcase
    
endmodule

