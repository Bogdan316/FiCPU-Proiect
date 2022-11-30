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
    input  [15:0] read_stack,
    output        mem_write,
    output [15:0] pc,
    output [15:0] data_addr,
    output [15:0] write_data,
    output        psh,
    output        pop,
    output [15:0] write_stack
);

wire reg_write;

controller ctrl(
    instr[15:10], 
    mem_write, reg_write, acc_write, transfer_a, psh, pop, alu_to_reg, update_flags
);

data_path  dpth(
    clk, reset, reg_write, acc_write, transfer_a, pop, alu_to_reg, update_flags, instr, read_data, read_stack, 
    pc, data_addr, write_data, write_stack
);

endmodule
