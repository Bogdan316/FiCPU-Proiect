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
    input [4:0] a,
    output [15:0] rd
);

reg [15:0] RAM[31:0];

initial
    begin
        $readmemb ("memfile.dat",RAM);
    end
    

assign rd = RAM[a]; // word aligned

endmodule
