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
    input      [8:0]  imm,
    input      [15:0] src_reg,
    input      [15:0] acc,
    output reg [15:0] alu_result
);

always @(*) begin
    case(alu_op)
        6'b100000: alu_result = acc + src_reg + {{7{imm[8]}}, imm};             // ADD
        6'b100001: alu_result = acc + ~(src_reg + {{7{imm[8]}}, imm}) + 16'b1;  // SUB
        6'b100110: alu_result = src_reg;                                        // MOV
        default:   alu_result = 16'bx;
    endcase
end

//always @(*) begin
//    $display("ALU: %b %h %d %d", alu_op, imm,  src_reg,  alu_result);
//end

endmodule
