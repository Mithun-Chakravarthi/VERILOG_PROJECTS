// ENGINEER NAME: B. MITHUN CHAKRAVARTHI //
`include  "ddr4_dut.v"
module DDR4_mult_bank_access_Controller  (
    input wire clk,            // System clock
    input wire rst_n,          // Reset (active low)
    input wire [31:0] addr,    // Address input (row, column, bank, bank group)
    input wire [15:0] wdata,   // Write data input
   
    output  [15:0] rdata,   // Read data output
    
    input wire read_en,        // Read enable signal
    input wire [1:0] bg_en,
    input wire write_en,       // Write enable signal
    
    output  ready,          // Ready signal (indicates controller is ready for next operation)
    output [15:0] ddr4_dq,     // DDR4 data bus 
    output [15:0] ddr4_addr,   // DDR4 address bus 
    output [2:0] ddr4_ba,      // DDR4 bank address
    output [1:0] ddr4_bg,      // DDR4 bank group
    output ddr4_ras_n,         // DDR4 row address strobe (active low)
    output ddr4_cas_n,         // DDR4 column address strobe (active low)
    output ddr4_we_n,          // DDR4 write enable (active low)
    output ddr4_cs_n           // DDR4 chip select (active low)

);



	   	DDR4_Controller Bank_group0 (
					.clk(clk),.rst_n(rst_n),.addr(addr),.wdata(wdata),.rdata(rdata),.read_en (read_en),.bg_en(bg_en),
					.write_en(write_en),.ready(ready),.ddr4_dq(ddr4_dq),.ddr4_addr(ddr4_addr),.ddr4_ba (ddr4_ba),
					.ddr4_bg(ddr4_bg),.ddr4_ras_n(ddr4_ras_n),.ddr4_cas_n(ddr4_cas_n),.ddr4_we_n(ddr4_we_n),.ddr4_cs_n(ddr4_cs_n) 

					);


		DDR4_Controller Bank_group1 (
					.clk(clk),.rst_n(rst_n),.addr(addr),.wdata(wdata),.rdata(rdata),.read_en (read_en),.bg_en(bg_en),
					.write_en(write_en),.ready(ready),.ddr4_dq(ddr4_dq),.ddr4_addr(ddr4_addr),.ddr4_ba (ddr4_ba),
					.ddr4_bg(ddr4_bg),.ddr4_ras_n(ddr4_ras_n),.ddr4_cas_n(ddr4_cas_n),.ddr4_we_n(ddr4_we_n),.ddr4_cs_n(ddr4_cs_n) 

					);

		DDR4_Controller Bank_group2 (
					.clk(clk),.rst_n(rst_n),.addr(addr),.wdata(wdata),.rdata(rdata),.read_en (read_en),.bg_en(bg_en),					
					.write_en(write_en),.ready(ready),.ddr4_dq(ddr4_dq),.ddr4_addr(ddr4_addr),.ddr4_ba (ddr4_ba),
					.ddr4_bg(ddr4_bg),.ddr4_ras_n(ddr4_ras_n),.ddr4_cas_n(ddr4_cas_n),.ddr4_we_n(ddr4_we_n),.ddr4_cs_n(ddr4_cs_n) 

					);

		DDR4_Controller Bank_group3 (
					.clk(clk),.rst_n(rst_n),.addr(addr),.wdata(wdata),.rdata(rdata),.read_en (read_en),.bg_en(bg_en),
					.write_en(write_en),.ready(ready),.ddr4_dq(ddr4_dq),.ddr4_addr(ddr4_addr),.ddr4_ba (ddr4_ba),
					.ddr4_bg(ddr4_bg),.ddr4_ras_n(ddr4_ras_n),.ddr4_cas_n(ddr4_cas_n),.ddr4_we_n(ddr4_we_n),.ddr4_cs_n(ddr4_cs_n) 

					);


endmodule
