module synchronous_fifo (
    input clk, rst, rd, wr,
    input [7:0] din,
    output reg [7:0] dout,
    output full, empty
);

    reg [7:0] mem[7:0];
    reg [3:0] wr_ptr, rd_ptr;  // extra bit for full detection

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            wr_ptr <= 4'b0;
            rd_ptr <= 4'b0;
            dout   <= 8'b0;
        end else begin
            // Write
            if (wr && !full) begin
                mem[wr_ptr[2:0]] <= din;
                wr_ptr <= wr_ptr + 1;
            end

            // Read
            else if (rd && !empty) begin
                dout <= mem[rd_ptr[2:0]];
                rd_ptr <= rd_ptr + 1;
            end
        end
    end

    assign full  = ((wr_ptr[2:0] == rd_ptr[2:0]) && (wr_ptr[3] != rd_ptr[3]));
    assign empty = (wr_ptr == rd_ptr);

endmodule
