`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/27/2022 05:27:26 PM
// Design Name: 
// Module Name: instr_mem
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


module instr_mem (
    input               clk,
    input        [4:0]  a,
    input               reset,
    input               psh,
    input               pop,
    input        [15:0] write_stack,
    output       [15:0] rd,
    output  reg  [15:0] read_stack,
    output  reg  [15:0] sp
);

reg [15:0] RAM[31:0];

initial
    begin
        $readmemb ("memfile.dat",RAM);
    end
    

assign rd = RAM[a]; // word aligned


// stack logic
always @(negedge clk, reset) begin
    if(reset) begin
        sp = 16'h001F;
    end else if(pop) begin
        sp = sp + 1;
        read_stack = RAM[sp];
    end else if(psh) begin
        RAM[sp] = write_stack;
        sp = sp - 1;
    end
end

endmodule
