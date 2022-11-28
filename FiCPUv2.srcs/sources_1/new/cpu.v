`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/27/2022 08:03:31 PM
// Design Name: 
// Module Name: cpu
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


module cpu(
    input         clk,
    input         reset,
    input  [15:0] instr,
    input  [15:0] read_data,
    output        mem_write,
    output [15:0] pc,
    output [15:0] data_addr,
    output [15:0] write_data
);

wire reg_write;

controller ctrl(
    instr[15:10], 
    mem_write, reg_write, acc_write, mov
);

data_path  dpth(
    clk, reset, reg_write, acc_write, mov, instr, read_data, 
    pc, data_addr, write_data
);

always @(posedge clk) begin
    $display("/*******************************/");
    $display("-------CPU-------");
    $display("\tPC: %h", pc);
    $display("\tINSTR: %b", instr);
    $display("\tCONTROL SIGNALS:");
    $display("\t\tMEM WRITE: %b", mem_write);
    $display("\t\tREG WRITE: %b", reg_write);
    $display("\t\tACC WRITE: %b", acc_write);
    $display("\t\tMOV:       %b", mov);
end

endmodule
