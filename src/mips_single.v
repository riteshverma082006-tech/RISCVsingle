// Top-level single-cycle MIPS processor
// Supports: add sub and or xor slt | lw sw | beq | addi | j
module mips_single (
    input clk,
    input reset
);
    // ---------------- wires ----------------
    wire [31:0] pc, pc_plus4, pc_branch_t, pc_jump_t;
    wire [31:0] pc_next_br, pc_next;
    wire [31:0] instr;
    wire [31:0] rd1, rd2, sign_imm, src_b, alu_result, mem_rd, wd3;
    wire [4:0]  write_reg;
    wire [2:0]  alu_ctrl;
    wire        mem_to_reg, mem_write, branch, alu_src, reg_dst, reg_write, jump;
    wire        zero, pc_src;

    // ---------------- fetch ----------------
    pc          u_pc     (.clk(clk), .reset(reset), .next_pc(pc_next), .pc_out(pc));
    pc_adder    u_pcadd  (.pc_in(pc), .pc_plus4(pc_plus4));
    instruction_memory imem (.addr(pc), .instr(instr));

    // ---------------- control ----------------
    control_unit cu (
        .opcode(instr[31:26]), .funct(instr[5:0]),
        .mem_to_reg(mem_to_reg), .mem_write(mem_write), .branch(branch),
        .alu_src(alu_src), .reg_dst(reg_dst), .reg_write(reg_write),
        .jump(jump), .alu_ctrl(alu_ctrl)
    );

    // ---------------- register file ----------------
    mux2 #(5) u_wrmux (.a(instr[20:16]), .b(instr[15:11]), .sel(reg_dst), .y(write_reg));

    register_file rf (
        .clk(clk), .we(reg_write),
        .ra1(instr[25:21]), .ra2(instr[20:16]),
        .wa(write_reg), .wd(wd3),
        .rd1(rd1), .rd2(rd2)
    );

    sign_extend se (.imm_in(instr[15:0]), .imm_out(sign_imm));

    // ---------------- execute ----------------
    mux2 u_srcb (.a(rd2), .b(sign_imm), .sel(alu_src), .y(src_b));

    alu u_alu (
        .src_a(rd1), .src_b(src_b), .alu_ctrl(alu_ctrl),
        .result(alu_result), .zero(zero)
    );

    // ---------------- memory / write-back ----------------
    data_memory dmem (
        .clk(clk), .reset(reset), .we(mem_write),
        .addr(alu_result), .wd(rd2), .rd(mem_rd)
    );

    mux2 u_wbmux (.a(alu_result), .b(mem_rd), .sel(mem_to_reg), .y(wd3));

    // ---------------- next PC ----------------
    pc_branch u_pcbr (.sign_imm(sign_imm), .pc_plus4(pc_plus4), .branch_target(pc_branch_t));

    assign pc_src    = branch & zero;
    assign pc_jump_t = {pc_plus4[31:28], instr[25:0], 2'b00};

    mux2 u_pcbrmux (.a(pc_plus4),   .b(pc_branch_t), .sel(pc_src), .y(pc_next_br));
    mux2 u_pcjmux  (.a(pc_next_br), .b(pc_jump_t),   .sel(jump),   .y(pc_next));
endmodule
