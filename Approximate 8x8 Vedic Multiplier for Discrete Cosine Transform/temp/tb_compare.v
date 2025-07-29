module tb_compare_vm_avm();
    reg [7:0] a;
    reg [7:0] b;
    wire [15:0] s_vm;  // Output of original Vedic multiplier
    wire [15:0] s_avm; // Output of approximate Vedic multiplier
    reg [15:0] error;  // Error between original and approximate outputs

    integer i, j;
    integer file;

    // Instantiate both the original and approximate multipliers
    VM_8bit original_multiplier (
        .a(a),
        .b(b),
        .s(s_vm)
    );

    AVM_8bit approximate_multiplier (
        .a(a),
        .b(b),
        .s(s_avm)
    );

    initial begin
        // Open the file to write the results
        file = $fopen("output_results.txt", "w");
        if (!file) begin
            $display("Error: Failed to open file!");
            $stop;
        end

        for (i = 0; i < 256; i = i + 1) begin
            a = i;
            for (j = 0; j < 256; j = j + 1) begin
                b = j;
                #5;
                
                // Calculate the error
                error = s_vm - s_avm;
                
                // Handle overflow by taking the modulus
                if (error[15]) begin
                    error = ~error + 1; // Convert to positive if error is negative
                end

                // Write the results to the file
                $fwrite(file, "a = %d, b = %d, Original = %d, Approximate = %d, Error = %d\n", a, b, s_vm, s_avm, error);
            end
        end

        // Close the file after writing all results
        $fclose(file);
        $display("Simulation complete. Results written to output_results.txt");
        $stop;
    end

    // Optional: You can still monitor the results in the console for quick debugging
    initial begin
        $monitor("a = %d, b = %d, Original = %d, Approximate = %d, Error = %d", a, b, s_vm, s_avm, error);
    end

    // Terminate the simulation after all test cases are done
    initial #330240 $stop;
endmodule

