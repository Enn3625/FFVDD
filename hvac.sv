`timescale 1ns/1ns
module HVAC_Control(
    input logic clk,       // Clock input
    input logic reset,     // Reset input
    input logic I1,        // Turn On
    input logic I2,        // Change to Heating
    input logic I3,        // Change to Cooling
    input logic I4,        // Turn Off
    output logic O1,       // Display for user feedback (1 when S0, S1, S2, 0 when S3)
    output logic O2,       // Control for heating element
    output logic O3,       // Control for cooling element
    output logic O4        // Additional output (1 when S3, 0 when S0, S1, S2)
);

// Define the states
typedef enum logic [1:0] {
    S0,
    S1,
    S2,
    S3  
} state_t;

// Define state registers
state_t current_state, next_state;

always_ff @(posedge clk)
begin
    if (reset)
        current_state <= S3;
    else
        current_state <= next_state;
end
always_comb
begin
    case(current_state)

        S0: if (I1) next_state = S0;
            else if (I2) next_state = S1;
            else if (I3) next_state = S2;
            else if (I4) next_state = S3;
        S1: if (I2) next_state = S1;
            else if (I3) next_state = S2;
            else if (I1) next_state = S0;
            else if (I4) next_state = S3;
        S2: if (I3) next_state = S2;
            else if (I2) next_state = S1;
            else if (I1) next_state = S0;
            else if (I4) next_state = S3;
        S3: if (I2) next_state = S1;
            else if (I3) next_state = S2;
            else if (I1) next_state = S0;
            else if (I4) next_state = S3;

    endcase
end
assign O1 = (current_state == S0) || (current_state == S1) || (current_state == S2);
assign O2 = (current_state == S1);
assign O3 = (current_state == S2);
assign O4 = (current_state == S3);

endmodule
