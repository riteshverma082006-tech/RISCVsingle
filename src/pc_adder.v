// PC + 4
module pc_adder (
    input  [31:0] pc_in,
    output [31:0] pc_plus4
);
    assign pc_plus4 = pc_in + 32'd4;
endmodule
