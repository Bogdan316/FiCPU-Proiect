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
    output        mem_write,
    output        pop,
    output        psh,
    output [15:0] read_stack,
    output [15:0] pc,
    output [15:0] sp,
    output [15:0] instr,       
    output [15:0] write_stack       
);

wire [15:0] read_data;

cpu cpu(
    clk, reset, instr, read_data, read_stack, 
    mem_write, pc, data_addr, write_data, psh, pop,  write_stack
);
    
// fetch instruction    
instr_mem imem(
    clk, pc[15:1], reset, psh, pop, write_stack,
    instr, read_stack, sp
);

// read/write data from/to memory or from/to stack                  
data_mem dmem(
    clk, mem_write, data_addr, write_data, 
    read_data
);

always @(posedge clk) begin
    if(!reset) begin
        $display("/*******************************/");
        $display("\tPC: %d", pc);
        $display("\tLINE: %d", (pc >> 1) + 1);
        $display("\tINSTR: %b", instr);
        $display("\tCONTROL SIGNALS:");
        $display("\t\tMEM WRITE: %b", mem_write);
        $display("\t\tPSH:       %b", psh);
        $display("\t\tPOP:       %b", pop);
        $display("\tPOP DATA: %h", read_stack);
        $display("\tPSH DATA: %h", write_stack);
    end
end
       
endmodule 
