module HVAC_Control_tb;
    reg clk;
    reg reset;
    reg I1;
    reg I2;
    reg I3;
    reg I4;
    wire O1;
    wire O2;
    wire O3;
    wire O4;

    // Instantiate the module under test
    HVAC_Control UUT (
        .clk(clk),
        .reset(reset),
        .I1(I1),
        .I2(I2),
        .I3(I3),
        .I4(I4),
        .O1(O1),
        .O2(O2),
        .O3(O3),
        .O4(O4)
    );

    // Clock generation
    always begin
        #5 clk = ~clk;
    end

    // Testbench stimulus
    initial begin
        // Initialize signals
        clk = 0;
        reset = 0;
        I1 = 0;
        I2 = 0;
        I3 = 0;
        I4 = 0;

        // Reset and wait for a few clock cycles
        reset = 1;
        #10 reset = 0;

// Idle state
I1 = 1;
    I2 = 0;
    I3 = 0;
    I4 = 0;
   
#10;
    // Heating
    I1 = 1;
    I2 = 1;
    I3 = 0;
    I4 = 0;

// Invalid
#10
I1=1;
I2=1;
I3=1;
I4=0;

#10;
    // Cooling
    I1 = 1;
    I2 = 0;
    I3 = 1;
    I4 = 0;

// Invalid
#10;
I1=1;
I2=1;
I3=1;
I4=0;

// Off
#10;
I1=0;
I2=0;
I3=1;
I4=1;

// Idle
#10;
I1 = 1;
    I2 = 0;
    I3 = 0;
    I4 = 0;
#200
        // Finish simulation
        $finish;
    end
endmodule
