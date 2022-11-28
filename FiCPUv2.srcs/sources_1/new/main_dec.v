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
    output       mov
);

reg [3:0] controls;

assign {mem_write, reg_write, acc_write, mov} = controls;

always @ (*)
    case(op)
        6'b000001: controls <= 4'b0100; //LDR
        6'b000010: controls <= 4'b1000; //STR
        6'b100000: controls <= 4'b0010; //ADD
        6'b100001: controls <= 4'b0010; //SUB
        6'b100110: controls <= 4'b0101; //MOV FROM A
        default:   controls <= 4'bxx; //???
    endcase
    
endmodule

