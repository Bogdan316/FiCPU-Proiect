`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/14/2022 12:42:10 AM
// Design Name: 
// Module Name: stack
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


module stack(
    input clk,
    input reset,
    input psh,
    input pop,
    output reg [15:0] sp
);
    
always @(posedge clk, posedge reset) begin
    if(reset) begin
        sp <= 16'h003F;
    end else if(pop) begin
        sp <= sp + 1;
    end else if(psh) begin
        sp <= sp - 1;
    end
end

endmodule
