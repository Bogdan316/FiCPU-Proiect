`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/27/2022 05:43:46 PM
// Design Name: 
// Module Name: reg_file
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


module reg_file(
    input          clk,
    input          we3, 
    input          wa3,
    input  [15:0]  wd3,
    output [15:0]  rd1,
    output [15:0]  rd2
);

reg [15:0] x;
reg [15:0] y;

always @ (posedge clk) begin
    if (we3) begin
        if(wa3) begin
            y <= wd3;
        end else begin
            x <= wd3;
        end
    end
end
    
assign rd1 = x;
assign rd2 = y;

endmodule
