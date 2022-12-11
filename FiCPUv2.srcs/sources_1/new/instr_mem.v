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
    input        [14:0] a,
    input               reset,
    input               psh,
    input               pop,
    input        [15:0] write_stack,
    output       [15:0] rd,
    output       [15:0] read_stack,
    output  reg  [15:0] sp
);

reg [15:0] RAM[63:0];

initial
    begin
        $readmemb ("memfile.dat",RAM);
    end
    

assign rd = RAM[a]; // word aligned


// stack logic
always @(posedge clk, posedge reset) begin
    if(reset) begin
        sp = 16'h003F;
    end else if(pop) begin
        sp = sp + 1;
    end else if(psh) begin
        RAM[sp] = write_stack;
        sp = sp - 1;
    end
end

assign read_stack = RAM[sp + 1];

endmodule
