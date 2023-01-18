`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/26/2022 03:14:40 PM
// Design Name: 
// Module Name: fpu_adder
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


module fpu_adder(
    input [15:0] a, 
    input [15:0] b,
    output reg [15:0] o
);

reg sign;
reg a_sign;
reg b_sign;
reg compl;
reg swp;

reg [4:0] a_exponent;
reg [4:0] b_exponent;
reg [4:0] sht_amount;
reg [4:0] exp;

reg [10:0] a_mantissa;
reg [10:0] b_mantissa;
reg [11:0] sum_mantissa;

reg [15:0] a_reg; 
reg [15:0] b_reg; 

always @(*) begin
    a_sign = a[15];
    b_sign = b[15];

    if(a[14:10] < b[14:10]) begin
        a_reg = b;
        b_reg = a;
        swp = 1'b1;
    end else begin
        a_reg = a;
        b_reg = b;
    end
    
    a_exponent = a_reg[14:10];
    b_exponent = b_reg[14:10];
    
    a_mantissa = {1'b1, a_reg[9:0]};
    b_mantissa = {1'b1, b_reg[9:0]};
    
    exp = a_exponent;
    sht_amount = a_exponent - b_exponent;
    
    sign = a_reg[15] !== b_reg[15];
    compl = 1'b0;
    if(sign) begin
        b_mantissa = ~b_mantissa + 11'b1;
        compl = 1'b1;
    end
    
    if(compl) begin
        if(sht_amount !== 5'b0) begin
            b_mantissa = b_mantissa >> 1;
            b_mantissa[10] = 1'b1;
            b_mantissa = b_mantissa >>> (sht_amount - 5'b1);
        end
    end else begin
        b_mantissa = b_mantissa >> sht_amount;
    end
    
    sum_mantissa = a_mantissa + b_mantissa;
    if(sign) begin
        if(sum_mantissa[11]) begin
            sum_mantissa[11] = 1'b0;
        end else begin
            sum_mantissa = ~sum_mantissa + 12'b1;
        end
    end else begin
        if(sum_mantissa[11]) begin
            sum_mantissa = sum_mantissa >> 1;
            exp = exp + 7'b1;
        end
    end
    
    if(sum_mantissa !== 12'b0) begin
        while(~sum_mantissa[10]) begin
            sum_mantissa = sum_mantissa << 1;
            exp = exp - 7'b1;
        end
        
        if(swp) begin
            sign = b_sign;
        end else begin
            if(compl) begin
                sign = b_sign;
            end else begin
                sign = a_sign;
            end
        end
        
        o = {sign, exp, sum_mantissa[9:0]};
    end else begin 
        o = 16'b0;
    end
end

endmodule
