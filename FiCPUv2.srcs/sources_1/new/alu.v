`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/28/2022 12:27:41 PM
// Design Name: 
// Module Name: alu
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


module alu(
    input      [5:0]  alu_op,
    input      [15:0] imm,
    input      [15:0] src_reg,
    input      [15:0] acc,
    output            zero,
    output            negative,
    output            carry,
    output            overflow,
    output reg [15:0] alu_result
);

reg cout;
reg borrow;

always @(*) begin
    cout = 1'b0;
    borrow = 1'b0;
    
    case(alu_op)
        6'b100000: alu_result = acc + src_reg + imm;             // ADD
        6'b100001: alu_result = acc + ~(src_reg + imm) + 16'b1;  // SUB
        6'b100110: alu_result = src_reg;                         // TRANSFER A
        6'b100111: alu_result = imm;                             // MOV TO REG 
        default:   alu_result = 16'bx;
    endcase
end

assign zero     = (alu_result == 16'b0);
assign negative = (alu_result[15] == 1'b1);
assign carry    = (cout == 1'b1);
assign overflow = (borrow == 1'b1);

endmodule
