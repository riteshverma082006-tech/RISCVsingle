// 32 x 32-bit register file. Two async read ports, one clocked write port.
// $0 is hard-wired to zero.
module register_file (
    input         clk,
    input         we,
    input  [4:0]  ra1,
    input  [4:0]  ra2,
    input  [4:0]  wa,
    input  [31:0] wd,
    output [31:0] rd1,
    output [31:0] rd2
);
    reg [31:0] regs [0:31];
    integer i;

    initial begin
        for (i = 0; i < 32; i = i + 1) regs[i] = 32'd0;
    end

    assign rd1 = (ra1 == 5'd0) ? 32'd0 : regs[ra1];
    assign rd2 = (ra2 == 5'd0) ? 32'd0 : regs[ra2];

    always @(posedge clk) begin
        if (we && wa != 5'd0) regs[wa] <= wd;
    end
endmodule
