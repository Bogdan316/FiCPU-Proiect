`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/30/2022 03:48:20 PM
// Design Name: 
// Module Name: flopr_en
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


module flopr_en # (parameter WIDTH = 8)(
    input                  clk, 
    input                  reset,
    input                  en,
    input      [WIDTH-1:0] d,
    output reg [WIDTH-1:0] q
);

always @ (posedge clk, posedge reset)
    if (reset)  q <= 0;
    else if(en) q <= d;
    else        q <= q;
    
endmodule
