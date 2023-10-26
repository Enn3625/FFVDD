`timescale 1ns/1ns
module HVAC_Control(
    input logic clk,       
    input logic reset,     
    input logic I1,        
    input logic I2,        
    input logic I3,        
    input logic I4,        
    output logic O1,       
    output logic O2,       
    output logic O3,       
    output logic O4        
);

typedef enum logic [1:0] {
    S0,
    S1,
    S2,
    S3  
} state_t;

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

        S0: if (I1 & !I2 & !I3 & !I4) next_state = S0;
            else if (I1 & I2 & !I3 &!I4) next_state = S1;
            else if (I1 & !I2 & I3 & !I4) next_state = S2;
            else if (I4) next_state = S3;
            else next_state = S0;
        S1: if (I1 & I2 & !I3 &!I4) next_state = S1;
            else if (I1 & !I2 & I3 & !I4) next_state = S2;
            else if (I1 & !I2 & !I3 & !I4) next_state = S0;
            else if (I4) next_state = S3;
            else next_state = S1;
        S2: if (I1 & !I2 & I3 & !I4) next_state = S2;
            else if (I1 & I2 & !I3 &!I4) next_state = S1;
            else if (I1 & !I2 & !I3 & !I4) next_state = S0;
            else if (I4) next_state = S3;
            else next_state = S2;
        S3: if (I1 & I2 & !I3 &!I4) next_state = S1;
            else if (I1 & !I2 & I3 & !I4) next_state = S2;
            else if (I1 & !I2 & !I3 & !I4) next_state = S0;
            else if (I4) next_state = S3;
            else next_state = S3;

   endcase
end

assign O1 = (current_state == S0) || (current_state == S1) || (current_state == S2);
assign O2 = (current_state == S1);
assign O3 = (current_state == S2);
assign O4 = (current_state == S3);

endmodule
