// -----------------------------------------------------------------------------
// Author: Simone Machetti
// -----------------------------------------------------------------------------

/* verilator lint_off UNUSEDSIGNAL */
/* verilator lint_off GENUNNAMED */

module tb_compressor_n_2 ();

    localparam int IN_SIZE_LIST  [0:2] = '{8, 9, 17};
    localparam int IN_WIDTH_LIST [0:2] = '{8, 8,  8};

    genvar s, w;
    generate
        for (s = 0; s < 3; s++) begin
            for (w = 0; w < 3; w++) begin

                localparam int IN_SIZE  = IN_SIZE_LIST[s];
                localparam int IN_WIDTH = IN_WIDTH_LIST[w];

                localparam int OUT_WIDTH = IN_WIDTH + ($clog2(IN_SIZE) - 1) * 2;

                logic [ IN_WIDTH-1:0] in [0:IN_SIZE-1];
                logic [OUT_WIDTH-1:0] sum;
                logic [OUT_WIDTH-1:0] carry;
                logic [OUT_WIDTH-1:0] acc;

                compressor_n_2 #(
                    .IN_SIZE (IN_SIZE),
                    .IN_WIDTH(IN_WIDTH)
                ) compressor_n_2_i (
                    .in_i   (in),
                    .sum_o  (sum),
                    .carry_o(carry)
                );

                initial begin
                    $dumpfile("activity.vcd");
                    $dumpvars(0, tb_compressor_n_2.compressor_n_2_i);
                    for (int j = 0; j < 1000; j++) begin
                        acc = '0;
                        for (int i = 0; i < IN_SIZE; i++) begin
                            in[i] = IN_WIDTH'($signed(($urandom_range(0, (1<<IN_WIDTH)-1))));
                            acc = OUT_WIDTH'($signed(acc)) + OUT_WIDTH'($signed(in[i]));
                        end
                        #5;
                        if ((OUT_WIDTH'($signed(sum)) + OUT_WIDTH'($signed(carry))) != OUT_WIDTH'($signed(acc))) begin
                            $display("Error!");
                            $dumpoff;
                            $finish();
                        end
                    end
                    $dumpoff;
                    $finish();
                end
            end
        end
    endgenerate

endmodule
