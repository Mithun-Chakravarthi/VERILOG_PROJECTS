//-----------------------------------------------------------------------------
// DDR4 Multi-Bank Group Memory Controller (Top-Level Wrapper)
// Author: Mithun Chakravarthi (VIT Vellore)
// Description:
//   This module instantiates 4 separate DDR4 controller blocks, one for each
//   bank group (BG0 - BG3), allowing parallel bank access. A multiplexer
//   selects outputs based on the active bank group (bg_en).
//-----------------------------------------------------------------------------

module DDR4_mult_bank_access_Controller (
    input wire clk,                  // System clock
    input wire rst_n,                // Active-low reset
    input wire [31:0] addr,          // Full DDR4 address (row, col, bank, bank group)
    input wire [15:0] wdata,         // Input data to write
    output reg [15:0] rdata,         // Output data read

    input wire read_en,              // Global read enable
    input wire write_en,             // Global write enable
    input wire [1:0] bg_en,          // Bank group enable selector (00 to 11)

    output reg ready,                // Indicates controller is ready for next op
    output reg [15:0] ddr4_dq,       // DDR4 bidirectional data bus (output)
    output reg [15:0] ddr4_addr,     // DDR4 address bus
    output reg [2:0] ddr4_ba,        // DDR4 bank address
    output reg [1:0] ddr4_bg,        // DDR4 bank group
    output reg ddr4_ras_n,           // Row address strobe (active low)
    output reg ddr4_cas_n,           // Column address strobe (active low)
    output reg ddr4_we_n,            // Write enable (active low)
    output reg ddr4_cs_n             // Chip select (active low)
);

//-----------------------------------------------------------------------------
// Internal wire arrays to collect outputs from all 4 controllers
//-----------------------------------------------------------------------------
wire [15:0] rdata_arr [3:0];         // Read data from each bank group
wire [15:0] ddr4_dq_arr [3:0];       // Data bus from each bank group
wire [15:0] ddr4_addr_arr [3:0];     // Address bus from each bank group
wire [2:0]  ddr4_ba_arr [3:0];       // Bank address from each group
wire [1:0]  ddr4_bg_arr [3:0];       // Bank group indicator from each controller
wire        ddr4_ras_n_arr [3:0];    // RAS signal from each controller
wire        ddr4_cas_n_arr [3:0];    // CAS signal from each controller
wire        ddr4_we_n_arr  [3:0];    // WE signal from each controller
wire        ddr4_cs_n_arr  [3:0];    // CS signal from each controller
wire        ready_arr      [3:0];    // Ready signals from each controller

//-----------------------------------------------------------------------------
// Generate 4 instances of the DDR4 controller module,
// one per bank group. Each responds only when selected via `bg_en`.
//-----------------------------------------------------------------------------
genvar i;
generate
    for (i = 0; i < 4; i = i + 1) begin : bank_group
        ddr4_controller controller_inst (
            .clk(clk),
            .rst_n(rst_n),
            .addr(addr),
            .wdata(wdata),
            .rdata(rdata_arr[i]),
            .read_en(read_en && (bg_en == i)),   // Enable only selected bank group
            .write_en(write_en && (bg_en == i)), // Enable only selected bank group
            .ready(ready_arr[i]),
            .ddr4_dq(ddr4_dq_arr[i]),
            .ddr4_addr(ddr4_addr_arr[i]),
            .ddr4_ba(ddr4_ba_arr[i]),
            .ddr4_bg(ddr4_bg_arr[i]),
            .ddr4_ras_n(ddr4_ras_n_arr[i]),
            .ddr4_cas_n(ddr4_cas_n_arr[i]),
            .ddr4_we_n(ddr4_we_n_arr[i]),
            .ddr4_cs_n(ddr4_cs_n_arr[i])
        );
    end
endgenerate

//-----------------------------------------------------------------------------
// Output MUX logic: Based on bg_en, forward selected controller outputs
//-----------------------------------------------------------------------------
always @(*) begin
    case (bg_en)
        2'd0: begin
            rdata       = rdata_arr[0];
            ready       = ready_arr[0];
            ddr4_dq     = ddr4_dq_arr[0];
            ddr4_addr   = ddr4_addr_arr[0];
            ddr4_ba     = ddr4_ba_arr[0];
            ddr4_bg     = ddr4_bg_arr[0];
            ddr4_ras_n  = ddr4_ras_n_arr[0];
            ddr4_cas_n  = ddr4_cas_n_arr[0];
            ddr4_we_n   = ddr4_we_n_arr[0];
            ddr4_cs_n   = ddr4_cs_n_arr[0];
        end
        2'd1: begin
            rdata       = rdata_arr[1];
            ready       = ready_arr[1];
            ddr4_dq     = ddr4_dq_arr[1];
            ddr4_addr   = ddr4_addr_arr[1];
            ddr4_ba     = ddr4_ba_arr[1];
            ddr4_bg     = ddr4_bg_arr[1];
            ddr4_ras_n  = ddr4_ras_n_arr[1];
            ddr4_cas_n  = ddr4_cas_n_arr[1];
            ddr4_we_n   = ddr4_we_n_arr[1];
            ddr4_cs_n   = ddr4_cs_n_arr[1];
        end
        2'd2: begin
            rdata       = rdata_arr[2];
            ready       = ready_arr[2];
            ddr4_dq     = ddr4_dq_arr[2];
            ddr4_addr   = ddr4_addr_arr[2];
            ddr4_ba     = ddr4_ba_arr[2];
            ddr4_bg     = ddr4_bg_arr[2];
            ddr4_ras_n  = ddr4_ras_n_arr[2];
            ddr4_cas_n  = ddr4_cas_n_arr[2];
            ddr4_we_n   = ddr4_we_n_arr[2];
            ddr4_cs_n   = ddr4_cs_n_arr[2];
        end
        2'd3: begin
            rdata       = rdata_arr[3];
            ready       = ready_arr[3];
            ddr4_dq     = ddr4_dq_arr[3];
            ddr4_addr   = ddr4_addr_arr[3];
            ddr4_ba     = ddr4_ba_arr[3];
            ddr4_bg     = ddr4_bg_arr[3];
            ddr4_ras_n  = ddr4_ras_n_arr[3];
            ddr4_cas_n  = ddr4_cas_n_arr[3];
            ddr4_we_n   = ddr4_we_n_arr[3];
            ddr4_cs_n   = ddr4_cs_n_arr[3];
        end
        default: begin
            // Default case when no valid bank group is selected
            rdata       = 16'h0000;
            ready       = 1'b0;
            ddr4_dq     = 16'hzzzz;
            ddr4_addr   = 16'h0000;
            ddr4_ba     = 3'b000;
            ddr4_bg     = 2'b00;
            ddr4_ras_n  = 1'b1;
            ddr4_cas_n  = 1'b1;
            ddr4_we_n   = 1'b1;
            ddr4_cs_n   = 1'b1;
        end
    endcase
end

endmodule
