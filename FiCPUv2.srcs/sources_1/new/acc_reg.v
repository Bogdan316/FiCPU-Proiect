`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/28/2022 12:49:20 PM
// Design Name: 
// Module Name: acc_reg
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


module acc_reg(
    input          clk,
    input          reset,
    input          we, 
    input  [15:0]  wd,
    output [15:0]  rd
);

reg [15:0] acc;

always @ (posedge clk, posedge reset) begin
    if(reset) begin
        acc <= 0;
    end else if (we) begin
        acc <= wd;
    end
end
    
assign rd = acc;

endmodule
