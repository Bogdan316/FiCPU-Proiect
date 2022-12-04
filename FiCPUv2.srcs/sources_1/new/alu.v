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
    input      [15:0] src_a,
    input      [15:0] src_b,
    output            zero,
    output            negative,
    output            carry,
    output            overflow,
    output reg [15:0] alu_result
);

reg cout;

always @(*) begin
    cout = 1'b0;
    
    case(alu_op)
        6'b100000: {cout, alu_result} = src_b + src_a;     // ADD
        6'b100001: alu_result = src_b + ~src_a + 16'b1;    // SUB
        6'b100110: alu_result = src_a;                     // TRANSFER A
        6'b100111: alu_result = src_b;                     // MOV TO REG 
        6'b101000: alu_result = src_b * src_a;             // MUL
        default:   alu_result = 16'bx;
    endcase
end

assign zero     = ~(|alu_result);
assign negative = alu_result[15];
assign carry    = cout;
assign overflow = (~(src_b[15] ^ src_a[15])) & (alu_result[15] ^ src_b[15]);

endmodule
