// -----------------------------------------------------------------------------
// Author: Simone Machetti
// -----------------------------------------------------------------------------

/* verilator lint_off UNUSEDSIGNAL */
/* verilator lint_off GENUNNAMED */

module tb_compressor_n_2 ();

    localparam int IN_SIZE_LIST  [0:4] = '{4, 8, 16, 32, 64};
    localparam int IN_WIDTH_LIST [0:4] = '{8, 8,  8,  8,  8};

    genvar k;
    generate
        for (k = 0; k < 5; k++) begin

            localparam int IN_SIZE  = IN_SIZE_LIST[k];
            localparam int IN_WIDTH = IN_WIDTH_LIST[k];

            localparam int OUT_WIDTH = IN_WIDTH + $clog2(IN_SIZE) + 1;

            logic [ IN_WIDTH-1:0] in [0:IN_SIZE-1];
            logic [OUT_WIDTH-1:0] sum;
            logic [OUT_WIDTH-1:0] carry;
            logic [OUT_WIDTH-1:0] result;
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
                for (int j = 0; j < 1000; j++) begin
                    acc = '0;
                    for (int i = 0; i < IN_SIZE; i++) begin
                        in[i] = IN_WIDTH'($signed(($urandom_range(0, (1<<IN_WIDTH)-1))));
                        acc   = OUT_WIDTH'($signed(acc)) + OUT_WIDTH'($signed(in[i]));
                    end
                    #5;
                    result = OUT_WIDTH'($signed(sum)) + OUT_WIDTH'($signed(carry));
                    if (OUT_WIDTH'($signed(result)) != OUT_WIDTH'($signed(acc))) begin
                        $display("Error!");
                        $finish();
                    end
                end
                $finish();
            end

        end
    endgenerate

endmodule
