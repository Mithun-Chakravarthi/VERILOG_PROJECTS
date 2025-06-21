module synchronous_fifo_tb();

    reg clk, rst, rd, wr;
    reg [7:0] din;
    wire [7:0] dout;
    wire full, empty;

    synchronous_fifo dut (
        .clk(clk),
        .rst(rst),
        .rd(rd),
        .wr(wr),
        .din(din),
        .dout(dout),
        .full(full),
        .empty(empty)
    );

    // Generate clock
    always #5 clk = ~clk;

    integer i;

    initial begin
        $display("Time\t wr_ptr\t rd_ptr\t din\t dout\t full\t empty");
        $monitor("%0t\t %d\t %d\t %d\t %d\t %b\t %b", $time, dut.wr_ptr, dut.rd_ptr, din, dout, full, empty);

        // Initialize signals
        clk = 0;
        rst = 1;
        din = 0;
        wr  = 0;
        rd  = 0;

        // Apply reset
        #10 rst = 0;

        // Write 8 values
        for (i = 1; i <= 8; i = i + 1) begin
            @(negedge clk);
            din = i;
            wr  = 1;
            rd  = 0;
        end

        // Stop writing
        @(negedge clk);
        wr = 0;

        // Small gap before reading
        #10;

        // Read 8 values
        for (i = 1; i <= 8; i = i + 1) begin
            @(negedge clk);
            wr  = 0;
            rd  = 1;
        end

        // Stop reading
        @(negedge clk);
        rd = 0;

        // Finish
        #10;
        $finish;
    end

endmodule

