`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/27/2022 07:39:07 PM
// Design Name: 
// Module Name: controller
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


module controller(
    input  [5:0] op,
    output       mem_write,
    output       reg_write,
    output       acc_write,
    output       transfer_a,
    output       psh,
    output       pop,
    output       alu_to_reg,
    output       update_flags
);

main_dec md(
    op,
    mem_write, reg_write, acc_write, transfer_a, psh, pop, alu_to_reg, update_flags
);

endmodule
