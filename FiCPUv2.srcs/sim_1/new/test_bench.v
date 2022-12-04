`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/27/2022 06:17:24 PM
// Design Name: 
// Module Name: test_bench
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


module test_bench;

reg clk;
reg reset;

wire        mem_write;
wire        pop;
wire        psh;
wire [15:0] sp;
wire [15:0] write_data;
wire [15:0] data_addr;
wire [15:0] pc;
wire [15:0] read_stack;
wire [15:0] instr;

// instantiate device to be tested
top dut (
    clk, reset, 
    write_data, data_addr, mem_write, pop, psh, read_stack, pc, sp, instr
);

// initialize test
initial
    begin
        reset <= 1; # 22; reset <= 0;
    end
    
// generate clock to sequence tests
always
    begin
        clk <= 1; # 5; clk <= 0; # 5;
    end

initial begin
    #150
    $stop;
end

endmodule