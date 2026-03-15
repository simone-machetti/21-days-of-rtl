// -----------------------------------------------------------------------------
// Author: Simone Machetti
// -----------------------------------------------------------------------------

/* verilator lint_off SYNCASYNCNET */

`timescale 1 ns/1 ps

module alu (
    input  logic [7:0] a_i,
    input  logic [7:0] b_i,
    input  logic [2:0] op_i,
    output logic [7:0] alu_o
);

    always_comb begin
        case (op_i)
            3'b000 : alu_o = 8'({a_i[7], a_i} + {b_i[7], b_i});
            3'b001 : alu_o = a_i - b_i;
            3'b010 : alu_o = a_i << b_i;
            3'b011 : alu_o = a_i >> b_i;
            3'b100 : alu_o = a_i & b_i;
            3'b101 : alu_o = a_i | b_i;
            3'b110 : alu_o = a_i ^ b_i;
            3'b111 : alu_o = a_i == b_i ? 8'd1 : 8'd0;
        endcase
    end

endmodule
