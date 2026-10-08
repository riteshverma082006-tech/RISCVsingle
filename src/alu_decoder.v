// ALU decoder: alu_op + funct -> alu_ctrl
//   alu_op 00 = add (lw/sw/addi)   01 = sub (beq)   10 = look at funct
module alu_decoder (
    input      [1:0] alu_op,
    input      [5:0] funct,
    output reg [2:0] alu_ctrl
);
    always @(*) begin
        case (alu_op)
            2'b00:   alu_ctrl = 3'b010;
            2'b01:   alu_ctrl = 3'b110;
            2'b10: begin
                case (funct)
                    6'b100000: alu_ctrl = 3'b010; // add
                    6'b100010: alu_ctrl = 3'b110; // sub
                    6'b100100: alu_ctrl = 3'b000; // and
                    6'b100101: alu_ctrl = 3'b001; // or
                    6'b100110: alu_ctrl = 3'b011; // xor
                    6'b101010: alu_ctrl = 3'b111; // slt
                    default:   alu_ctrl = 3'b010;
                endcase
            end
            default: alu_ctrl = 3'b010;
        endcase
    end
endmodule
