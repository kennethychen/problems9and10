module ff_reference #(
  parameter WIDTH = 4
) (
  input               clk, rst,
  input  [WIDTH-1:0]  data_i,
  output [WIDTH-1:0]  data_o
);

  // Define nets for 3 stages of flip-flops
  logic [WIDTH-1:0] data_d, data_q;     // Original stage
  logic [WIDTH-1:0] stage2_d, stage2_q; // Additional stage 2
  logic [WIDTH-1:0] stage3_d, stage3_q; // Additional stage 3

  // Assign output to the final stage in the pipeline
  assign data_o = stage3_q;

  always_comb begin : data_set
    // Stage 1 D-input comes from module input
    data_d   = data_i;
    // Stage 2 D-input comes from Stage 1 Q-output
    stage2_d = data_q;
    // Stage 3 D-input comes from Stage 2 Q-output
    stage3_d = stage2_q;
  end

  // Async reset logic for all flip-flops
  // Only reset logic should reside in the always_ff block 
  always_ff @(posedge clk or posedge rst) begin : data_ff
    if (rst) begin
      data_q   <= '0;
      stage2_q <= '0;
      stage3_q <= '0;
    end else begin
      data_q   <= data_d;
      stage2_q <= stage2_d;
      stage3_q <= stage3_d;
    end
  end

endmodule
