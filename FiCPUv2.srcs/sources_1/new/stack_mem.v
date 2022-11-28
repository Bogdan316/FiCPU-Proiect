`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/28/2022 03:02:06 PM
// Design Name: 
// Module Name: stack_mem
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


module stack_mem(
    input               clk,
    input               reset,
    input               psh,
    input               pop,
    input        [15:0] wd,
    output  reg  [15:0] rd,
    output  reg  [7:0]   sp
);

reg [15:0]  stack[255:0];

always @(pop, psh, reset) begin
    if(reset) begin
        sp = 8'hFF;
    end else if(pop) begin
        sp = sp + 1;
        rd = stack[sp];
    end else if(psh) begin
        stack[sp] = wd;
        sp = sp - 1;
    end
end


endmodule
