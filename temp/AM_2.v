module AVM_8bit_2(a,b,s);
input [7:0]a;
input [7:0]b;
output [15:0]s;

wire [7:0]w1,w2,w3,w4;
wire [7:0]rca_sum1,rca_sum2,rca_sum3;
wire [3:1]rca_ca;

NVM_4bit o0(a[3:0],b[3:0],w1);
NVM_4bit o1(a[3:0],b[7:4],w2);
NVM_4bit o2(a[7:4],b[3:0],w3);
NVM_4bit o3(a[7:4],b[7:4],w4);

O_RCA_8_BIT o5(w2,w3,rca_sum1,rca_ca[1]);
RCA_8_BIT_comp_2 o6(rca_sum1,{4'b0,w1[7:4]}, rca_sum2,rca_ca[2]);
O_RCA_8_BIT o7(w4,{3'b0,rca_ca[1],rca_sum2[7:4]},rca_sum3,rca_ca[3]);

assign s={rca_sum3,rca_sum2[3:0],w1[3:0]};

endmodule

module RCA_8_BIT_comp_2(a,b,sum,cout);
input [7:0]a,b;
output [7:0]sum;
output cout;
wire [7:0]c;
comrpessor_32 f1(a[0],b[0],1'b0,sum[0],c[0]);
comrpessor_32 f2(a[1],b[1],c[0],sum[1],c[1]);
comrpessor_32 f3(a[2],b[2],c[1],sum[2],c[2]);
//comrpessor_32 f4(a[3],b[3],c[2],sum[3],c[3]);
OFA f4(a[3],b[3],c[2],sum[3],c[3]);
OFA f5(a[4],b[4],c[3],sum[4],c[4]);
OFA f6(a[5],b[5],c[4],sum[5],c[5]);
OFA f7(a[6],b[6],c[5],sum[6],c[6]);
OFA f8(a[7],b[7],c[6],sum[7],c[7]);

assign cout=c[7];

endmodule



module tb_compare_vm_avm_2();
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

    AVM_8bit_2 approximate_multiplier (
        .a(a),
        .b(b),
        .s(s_avm)
    );

    initial begin
        // Open the file to write the results
        file = $fopen("output_results_final.txt", "w");
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
