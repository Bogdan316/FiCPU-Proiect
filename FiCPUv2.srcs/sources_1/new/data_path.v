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
    input         transfer_a,
    input         pop,
    input         alu_to_reg,
    input         update_flags,
    input         bra,
    input  [15:0] instr,
    input  [15:0] read_data,
    input  [15:0] read_stack,
    output [15:0] pc,
    output [15:0] data_addr,
    output [15:0] write_data,
    output [15:0] write_stack
);

wire zero;
wire negative;
wire carry;
wire overflow;

wire [3:0] flags;

wire [15:0] imm_ex;
wire [15:0] pc_inc;
wire [15:0] pc_next;
wire [15:0] x;
wire [15:0] y;
wire [15:0] a;
wire [15:0] alu_result;
wire [15:0] rf_data;
wire [15:0] se_imm;
wire [15:0] branch_imm;
wire [15:0] pc_branch;

// inc PC to next instruction, word aligned
adder inc_pc(
    pc, 16'b10,
    pc_inc
);

sign_extension se_branch_imm(
    instr[8:0],
    branch_imm
);

// branch address
adder add_pc(
    pc_inc, branch_imm << 1,
    pc_branch
);

// next instruction select
mux2 #(16) pc_source(
    pc_inc, pc_branch, bra, 
    pc_next
);

// update PC on posedge clk
flopr #(16) pc_reg(
    clk, reset, pc_next, 
    pc
);

// sign extend immediate value
sign_extension se(
    instr[8:0],
    data_addr
); 

// write/read to/from x or y
// select source from data memory, stack, acc register or alu
one_hot_encoder wd_reg(read_data, read_stack, a, alu_result, {alu_to_reg, transfer_a, pop}, rf_data);     
reg_file rf(
    clk, reg_write, instr[9], rf_data, 
    x, y
);

// write/read to/from acc register
acc_reg acc(clk, reset, acc_write, alu_result, a);

// write to data memory
mux2 #(16) wd_mux(x, y, instr[9], write_data);

// write to stack memory
mux2 #(16) ws_mux(x, y, instr[9], write_stack);

// compute alu operations
sign_extension se_imm_alu(
    instr[8:0],
    se_imm
);
alu alu(
    instr[15:10], se_imm, instr[9] ? y : x, a,
    zero, negative, carry, overflow, alu_result
);

flopr_en #(4) flag_reg(
    clk, reset, update_flags, {zero, negative, carry, overflow}, 
    flags
);

always @(negedge clk) begin
    $display("\tX: %d Y: %d A: %d", x, y, a);
    $display("\tZNCO");
    $display("\t%b", flags);
end

endmodule
