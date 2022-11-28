`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/27/2022 08:09:13 PM
// Design Name: 
// Module Name: data_path
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


module data_path(
    input         clk,
    input         reset,
    input         reg_write,
    input         acc_write,
    input         mov,
    input         pop,
    input  [15:0] instr,
    input  [15:0] read_data,
    input  [15:0] read_stack,
    output [15:0] pc,
    output [15:0] data_addr,
    output [15:0] write_data,
    output [15:0] write_stack
);

wire [15:0] imm_ex;
wire [15:0] pc_next;
wire [15:0] x;
wire [15:0] y;
wire [15:0] a;
wire [15:0] alu_result;
wire [15:0] rf_data;

// update PC on posedge clk
flopr #(16) pc_reg(
    clk, reset, pc_next, 
    pc
);

// inc PC to next instruction, word aligned
adder inc_pc(
    pc, 32'b10,
    pc_next
);

// sign extend immediate value
sign_extension se(
    instr[8:0],
    data_addr
); 

// write/read to/from x or y
// select source from data memory, stack or the acc register
mux4 #(16) wd_reg(read_data, read_stack, a, 16'bx, {mov, pop}, rf_data);         
reg_file rf(
    clk, reg_write, instr[9], rf_data, 
    x, y
);

// write to data memory
mux2 #(16) wd_mux(x, y, instr[9], write_data);

// write to stack memory
mux2 #(16) ws_mux(x, y, instr[9], write_stack);

// compute alu operations
alu alu(instr[15:10], instr[8:0], instr[9] ? y : x, a, alu_result); 

// write/read to/from acc register
acc_reg acc(clk, reset, acc_write, alu_result, a);

always @(posedge clk) begin
    $display("\tX: %d Y: %d A: %d", x, y, a);
end

endmodule
