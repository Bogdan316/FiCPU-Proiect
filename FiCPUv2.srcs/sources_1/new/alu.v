`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/28/2022 12:27:41 PM
// Design Name: 
// Module Name: alu
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


module alu(
    input      [5:0]  alu_op,
    input      [15:0] src_a,
    input      [15:0] src_b,
    output            zero,
    output            negative,
    output            carry,
    output            overflow,
    output reg [15:0] alu_result
);

reg cout;

always @(*) begin
    cout = 1'b0;
    
    case(alu_op)
        6'b100000: {cout, alu_result} = src_b + src_a;                                     // ADD
        6'b100001: alu_result = src_b + ~src_a + 16'b1;                                    // SUB 
        6'b100110: alu_result = src_a;                                                     // TRANSFER A
        6'b100111: alu_result = src_b;                                                     // MOV TO REG 
        6'b101000: alu_result = src_b[7:0] * src_a[7:0];                                   // MUL
        6'b101001: alu_result = src_b >> src_a;                                            // LSR
        6'b101010: alu_result = src_b << src_a;                                            // LSL
        6'b101011: alu_result = (src_b >> src_a) | (src_b << (16'h10 - src_a));            // RSR
        6'b101100: alu_result = (src_b << src_a) | (src_b >> (16'h10 - src_a));            // RSL
        6'b101101: alu_result = $signed(src_b) / $signed(src_a);                           // DIV
        6'b101110: alu_result = src_b % src_a;                                             // MOD
        6'b101111: alu_result = src_b & src_a;                                             // AND
        6'b110000: alu_result = src_b | src_a;                                             // OR
        6'b110001: alu_result = src_b ^ src_a;                                             // XOR
        6'b110010: alu_result = ~src_a;                                                    // NOT
        6'b110011: alu_result = src_a + 16'b1;                                             // INC REG
        6'b110100: alu_result = src_a - 16'b1;                                             // DEC REG
        6'b110101: alu_result = src_b + ~src_a + 16'b1;                                    // CMP
        6'b110110: alu_result = src_b & src_a;                                             // TST
        6'b110111: alu_result = src_a;                                                     // TRANSFER REG
        6'b111000: {cout, alu_result} = src_a + src_b;                                     // ADDI                                           
        6'b111001: alu_result = src_a + ~src_b + 16'b1;                                    // SUBI                                         
        6'b111010: alu_result = src_b[7:0] * src_a[7:0];                                   // MULI                                         
        6'b111011: alu_result = src_a >> src_b;                                            // LSRI                                         
        6'b111100: alu_result = src_a << src_b;                                            // LSLI                                         
        6'b111101: alu_result = $signed(src_a[7:0]) / $signed(src_b[7:0]);                 // DIVI                                         
        6'b111110: alu_result = src_a % src_b;                                             // MODI                                         
        default:   alu_result = 16'bx;
    endcase
end

assign zero     = ~(|alu_result);
assign negative = alu_result[15];
assign carry    = cout;
assign overflow = ((~(src_b[15] ^ src_a[15])) & (alu_result[15] ^ src_b[15]))  ^ (alu_op == 6'b100001 || alu_op == 6'b110101);

endmodule
