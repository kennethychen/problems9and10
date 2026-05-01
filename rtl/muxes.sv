module muxes (
    input               a_i, b_i, c_i, d_i,
    input  logic [1:0]  sel4_i,
    output logic        y0_o, y1_o
);

    // Implementation for y0_o using a Conditional Operator
    // Logic: XOR(a_i, b_i) selects between c_i and d_i
    assign y0_o = (a_i ^ b_i) ? d_i : c_i;

    // Implementation for y1_o using a Case Statement
    // This matches the 4-input MUX shown in Figure 14
    always_comb begin
        case (sel4_i)
            2'b00:   y1_o = 1'b0; // Constant 0
            2'b01:   y1_o = c_i;  
            2'b10:   y1_o = 1'b0; // Constant 0
            2'b11:   y1_o = d_i;
            default: y1_o = 1'b0;
        endcase
    end

endmodule
