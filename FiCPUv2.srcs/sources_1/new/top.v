`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/27/2022 05:29:04 PM
// Design Name: 
// Module Name: top
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


module top(
    input         clk, 
    input         reset,
    output [15:0] write_data,
    output [15:0] data_addr,
    output        mem_write
);

wire [15:0] instr;
wire [15:0] pc;
wire [15:0] read_data;

cpu cpu(
    clk, reset, instr, read_data, 
    mem_write, pc, data_addr, write_data
);
    
// fetch instruction    
instr_mem imem(
    pc[5:1],
    instr
);

// read/write data from/to memory                     
data_mem dmem(
    clk, mem_write, data_addr, write_data, 
    read_data
);
       
endmodule 
