`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/27/2022 06:00:29 PM
// Design Name: 
// Module Name: data_mem
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


module data_mem (
    input         clk, 
    input         we,
    input  [15:0] a,
    input  [15:0] wd,
    output [15:0] rd
);

reg [15:0] RAM[31:0];


assign rd = RAM[a[15:1]];

integer i;


// for testing
initial begin
  for (i=0;i<=31;i=i+1)
    RAM[i] = i;
end

always @ (posedge clk)
    if (we)
        RAM[a[15:1]] <= wd;

endmodule
