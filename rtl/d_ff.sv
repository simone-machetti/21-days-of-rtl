// -----------------------------------------------------------------------------
// Author: Simone Machetti
// -----------------------------------------------------------------------------

/* verilator lint_off SYNCASYNCNET */

`timescale 1 ns/1 ps

module d_ff (
    input  logic clk_i,
    input  logic rst_ni,
    input  logic d_i,
    output logic q_norst_o,
    output logic q_syncrst_o,
    output logic q_asyncrst_o
);

    always_ff @(posedge clk_i) begin
        q_norst_o <= d_i;
    end

    always_ff @(posedge clk_i) begin
        if (!rst_ni) begin
            q_syncrst_o <= 1'b0;
        end else begin
            q_syncrst_o <= d_i;
        end
    end

    always_ff @(posedge clk_i or negedge rst_ni) begin
        if (!rst_ni) begin
            q_asyncrst_o <= 1'b0;
        end else begin
            q_asyncrst_o <= d_i;
        end
    end

endmodule
