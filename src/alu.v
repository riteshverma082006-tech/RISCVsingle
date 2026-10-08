// ALU
//   000 AND   001 OR   010 ADD   011 XOR   110 SUB   111 SLT (signed)
module alu (
    input      [31:0] src_a,
    input      [31:0] src_b,
    input      [2:0]  alu_ctrl,
    output reg [31:0] result,
    output            zero
);
    always @(*) begin
        case (alu_ctrl)
            3'b000:  result = src_a & src_b;
            3'b001:  result = src_a | src_b;
            3'b010:  result = src_a + src_b;
            3'b011:  result = src_a ^ src_b;
            3'b110:  result = src_a - src_b;
            3'b111:  result = ($signed(src_a) < $signed(src_b)) ? 32'd1 : 32'd0;
            default: result = 32'd0;
        endcase
    end

    assign zero = (result == 32'd0);
endmodule
