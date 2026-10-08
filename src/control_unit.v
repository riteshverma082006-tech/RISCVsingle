// Control unit = main decoder + ALU decoder
module control_unit (
    input  [5:0] opcode,
    input  [5:0] funct,
    output       mem_to_reg,
    output       mem_write,
    output       branch,
    output       alu_src,
    output       reg_dst,
    output       reg_write,
    output       jump,
    output [2:0] alu_ctrl
);
    wire [1:0] alu_op;

    main_decoder md (
        .opcode(opcode), .mem_to_reg(mem_to_reg), .mem_write(mem_write),
        .branch(branch), .alu_src(alu_src), .reg_dst(reg_dst),
        .reg_write(reg_write), .jump(jump), .alu_op(alu_op)
    );

    alu_decoder ad (
        .alu_op(alu_op), .funct(funct), .alu_ctrl(alu_ctrl)
    );
endmodule
