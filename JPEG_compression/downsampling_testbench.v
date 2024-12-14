module chrominance_downsampling_test;

    // Parameters
    reg Clock;
    reg reset;
    reg Enable0;
    reg [511:0] Cb;
    reg [511:0] Cr;
    wire [511:0] Cb_d;
    wire [511:0] Cr_d;
    wire enable1;

    // Declare loop variables at the top level
    integer i, j;

    // Instantiate the module
    chrominance_downsampling uut (
        .Clock(Clock),
        .reset(reset),
        .Enable0(Enable0),
        .Cb(Cb),
        .Cr(Cr),
        .Cb_d(Cb_d),
        .Cr_d(Cr_d),
        .enable1(enable1)
    );

    // Clock generation
    initial begin
        Clock = 0;
        forever #5 Clock = ~Clock; // Toggle clock every 5 time units
    end

    // Test procedure
    initial begin
        // Initialize inputs
        reset = 1;
        Enable0 = 0;
        Cb = {
            8'd111, 8'd111, 8'd111, 8'd110, 8'd109, 8'd109, 8'd108, 8'd108,
            8'd110, 8'd110, 8'd110, 8'd109, 8'd108, 8'd108, 8'd107, 8'd107,
            8'd109, 8'd109, 8'd108, 8'd108, 8'd107, 8'd107, 8'd106, 8'd106,
            8'd107, 8'd107, 8'd107, 8'd106, 8'd106, 8'd105, 8'd105, 8'd105,
            8'd106, 8'd105, 8'd105, 8'd105, 8'd104, 8'd104, 8'd104, 8'd104,
            8'd104, 8'd104, 8'd104, 8'd104, 8'd104, 8'd103, 8'd103, 8'd103,
            8'd104, 8'd104, 8'd104, 8'd104, 8'd103, 8'd103, 8'd103, 8'd103,
            8'd90, 8'd104, 8'd104, 8'd103, 8'd103, 8'd103, 8'd103, 8'd103
        };
        Cr = {
            8'd166, 8'd167, 8'd168, 8'd168, 8'd168, 8'd168, 8'd168, 8'd170,
            8'd167, 8'd168, 8'd169, 8'd169, 8'd167, 8'd167, 8'd169, 8'd170,
            8'd168, 8'd169, 8'd170, 8'd170, 8'd168, 8'd168, 8'd170, 8'd171,
            8'd168, 8'd170, 8'd171, 8'd171, 8'd170, 8'd169, 8'd171, 8'd172,
            8'd169, 8'd171, 8'd172, 8'd172, 8'd170, 8'd170, 8'd171, 8'd173,
            8'd170, 8'd172, 8'd173, 8'd172, 8'd171, 8'd170, 8'd171, 8'd173,
            8'd170, 8'd172, 8'd173, 8'd172, 8'd171, 8'd170, 8'd171, 8'd173,
            8'd170, 8'd172, 8'd173, 8'd172, 8'd171, 8'd170, 8'd171, 8'd172
        };

        // Start the test
        #10 reset = 0; // Release reset
        Enable0 = 1;   // Enable the module

        // Wait for processing
        #200; // Increased wait time to allow processing

        // Disable the module
        Enable0 = 0;
        #10;

        // Observe outputs
        $display("Cb_d (Hex): %h", Cb_d);
        $display("Cr_d (Hex): %h", Cr_d);
        $display("Enable1: %b", enable1);

        // Display downsampled values as 8x8 matrices
        $display("Downsampled Cb Matrix:");
        for (i = 0; i < 8; i = i + 1) begin
            $write("  ");
            for (j = 0; j < 8; j = j + 1) begin
                $write("%d ", Cb_d[(511-8*(8*i+j)) -: 8]);
            end
            $display("");
        end
        
        $display("Downsampled Cr Matrix:");
        for (i = 0; i < 8; i = i + 1) begin
            $write("  ");
            for (j = 0; j < 8; j = j + 1) begin
                $write("%d ", Cr_d[(511-8*(8*i+j)) -: 8]);
            end
            $display("");
        end

        // End the simulation
        #10 $finish;
    end

endmodule

