`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/01/2023 03:41:43 PM
// Design Name: 
// Module Name: fpu
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


module fpu(
    input        [5:0] instr_sel,
    input       [15:0] a,
    input       [15:0] b,
    output reg  [15:0] o
);

wire [15:0] bb;
wire [15:0] o_add;
wire [15:0] o_mul;

assign bb = instr_sel == 6'b010000 ? {1'b1, b[14:0]} : b;


fpu_adder adder(
    a, bb,
    o_add
);

fpu_multiplier multiplier(
    a, b,
    o_mul
);

always @(*) begin
    case(instr_sel)
        6'b001110: o <= o_add; // FPADD
        6'b001111: o <= o_mul; // FPMUL
        6'b010000: o <= o_add; // FPSUB
        default:   o <= 16'bxxxxxxxxxxxxxxxx;
    endcase
end

endmodule
