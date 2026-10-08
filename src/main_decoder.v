// Main control decoder (opcode -> control signals)
//   R-type 000000   lw 100011   sw 101011   beq 000100   addi 001000   j 000010
module main_decoder (
    input  [5:0] opcode,
    output reg   mem_to_reg,
    output reg   mem_write,
    output reg   branch,
    output reg   alu_src,
    output reg   reg_dst,
    output reg   reg_write,
    output reg   jump,
    output reg [1:0] alu_op
);
    always @(*) begin
        case (opcode)
            //                                  {mtr, mw, br, as, rd, rw, aluop, j}
            6'b000000: {mem_to_reg, mem_write, branch, alu_src, reg_dst, reg_write, alu_op, jump} = 9'b0_0_0_0_1_1_10_0; // R-type
            6'b100011: {mem_to_reg, mem_write, branch, alu_src, reg_dst, reg_write, alu_op, jump} = 9'b1_0_0_1_0_1_00_0; // lw
            6'b101011: {mem_to_reg, mem_write, branch, alu_src, reg_dst, reg_write, alu_op, jump} = 9'b0_1_0_1_0_0_00_0; // sw
            6'b000100: {mem_to_reg, mem_write, branch, alu_src, reg_dst, reg_write, alu_op, jump} = 9'b0_0_1_0_0_0_01_0; // beq
            6'b001000: {mem_to_reg, mem_write, branch, alu_src, reg_dst, reg_write, alu_op, jump} = 9'b0_0_0_1_0_1_00_0; // addi
            6'b000010: {mem_to_reg, mem_write, branch, alu_src, reg_dst, reg_write, alu_op, jump} = 9'b0_0_0_0_0_0_00_1; // j
            default:   {mem_to_reg, mem_write, branch, alu_src, reg_dst, reg_write, alu_op, jump} = 9'b0;
        endcase
    end
endmodule
