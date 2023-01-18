`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/26/2022 06:42:21 PM
// Design Name: 
// Module Name: fpu_multiplier
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


module fpu_multiplier(
    input [15:0] x,
    input [15:0] y,
    output reg [15:0] z
);

reg sign;
reg [4:0] x_exp;
reg [4:0] y_exp;
reg [4:0] exp;

reg [10:0] x_mantissa;
reg [10:0] y_mantissa;

reg [21:0] mul;

always @(*) begin
    sign = x[15] ^ y[15];
    
    x_exp = x[14:10];
    y_exp = y[14:10];
    
    x_mantissa = {1'b1, x[9:0]};
    y_mantissa = {1'b1, y[9:0]};
    
    exp = x_exp + y_exp - 5'hF;
    
    mul = x_mantissa * y_mantissa;
    
    if(mul[21]) begin
       mul = mul >> 1;
       exp = exp + 5'b1;
    end
    
    while(!mul[20]) begin
        mul = mul << 1;
        exp = exp - 5'b1;
    end
    
    z = {sign, exp, mul[19:10]};
end

endmodule
