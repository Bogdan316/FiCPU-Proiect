`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/30/2022 02:02:48 PM
// Design Name: 
// Module Name: one_hot_encoder
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


module one_hot_encoder (
    input      [15:0] d0,
    input      [15:0] d1,
    input      [15:0] d2,
    input      [15:0] d3,
    input      [2:0]  s,
    output reg [15:0] y
);

always @(*) begin
    case(s)
        3'b000:   y = d0;
        3'b001:   y = d1;
        3'b010:   y = d2;
        3'b100:   y = d3;
        default: y = 16'bx;
    endcase
end

endmodule
