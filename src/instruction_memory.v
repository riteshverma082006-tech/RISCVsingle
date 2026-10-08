// Instruction memory (256 words, word-addressed via PC[9:2]).
// Unused locations are zero-filled (0x00000000 = sll $0,$0,0, a NOP)
// so the CPU never fetches X after the program ends.
//
// Program: sum of 1..10 -> stored to mem[0] (expected result: 55)
//   addi $8, $0, 10
//   addi $9, $0, 0
//   beq  $8, $0, +3      (-> sw)
//   add  $9, $9, $8
//   addi $8, $8, -1
//   j    2
//   sw   $9, 0($0)
module instruction_memory (
    input  [31:0] addr,
    output [31:0] instr
);
    reg [31:0] im [0:255];
    integer i;

    initial begin
        for (i = 0; i < 256; i = i + 1) im[i] = 32'h00000000;

        im[0] = 32'h2008000a; // addi $8, $0, 10
        im[1] = 32'h20090000; // addi $9, $0, 0
        im[2] = 32'h11000003; // beq  $8, $0, 3
        im[3] = 32'h01284820; // add  $9, $9, $8
        im[4] = 32'h2108ffff; // addi $8, $8, -1
        im[5] = 32'h08000002; // j    2
        im[6] = 32'hac090000; // sw   $9, 0($0)
    end

    assign instr = im[addr[9:2]];
endmodule
