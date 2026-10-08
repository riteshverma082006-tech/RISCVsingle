// Branch target = (PC + 4) + (sign-extended immediate << 2)
module pc_branch (
    input  [31:0] sign_imm,
    input  [31:0] pc_plus4,
    output [31:0] branch_target
);
    assign branch_target = pc_plus4 + (sign_imm << 2);
endmodule
