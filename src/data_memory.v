// Data memory (256 words). Async read, synchronous write, synchronous reset.
// Zero-initialised at time 0 so reads are never X.
module data_memory (
    input         clk,
    input         reset,
    input         we,
    input  [31:0] addr,
    input  [31:0] wd,
    output [31:0] rd
);
    reg [31:0] dm [0:255];
    integer i;

    initial begin
        for (i = 0; i < 256; i = i + 1) dm[i] = 32'd0;
    end

    always @(posedge clk) begin
        if (reset) begin
            for (i = 0; i < 256; i = i + 1) dm[i] <= 32'd0;
        end else if (we) begin
            dm[addr[9:2]] <= wd;
        end
    end

    assign rd = dm[addr[9:2]];
endmodule
