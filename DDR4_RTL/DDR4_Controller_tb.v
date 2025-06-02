`timescale 1ns/1ns
`include "ddr4_bank_sel_dut.v"
module DDR4_Controller_tb;

// Testbench signals
reg clk;
reg rst_n;
reg [31:0] addr; 
reg [15:0] wdata;
reg [1:0] bg_en;
reg read_en;
reg write_en;
wire  [15:0] rdata; 
wire ready;

// DDR4 interface signals (from the DDR4_Controller)
wire [15:0] ddr4_dq;  
wire [15:0] ddr4_addr;
wire [2:0] ddr4_ba;   
wire [1:0] ddr4_bg;      
wire ddr4_ras_n;
wire ddr4_cas_n;
wire ddr4_we_n;
wire ddr4_cs_n;

// Instantiate the DDR4 controller
DDR4_mult_bank_access_Controller uut (
    .clk(clk),
    .rst_n(rst_n),
    .addr(addr), 
    .wdata(wdata),  
    .rdata(rdata), 
    .read_en(read_en),
    .write_en(write_en),
    .ready(ready),
    .ddr4_dq(ddr4_dq),
    .ddr4_addr(ddr4_addr),
    .ddr4_ba(ddr4_ba),
    .ddr4_bg(ddr4_bg),
    .ddr4_ras_n(ddr4_ras_n),
    .ddr4_cas_n(ddr4_cas_n),
    .ddr4_we_n(ddr4_we_n),
    .ddr4_cs_n(ddr4_cs_n) ,
	.bg_en		(bg_en)
);


// Clock generation
always begin
    #5 clk = ~clk;  // 100 MHz clock (10ns period)
end

//Testbench procedure
initial begin
    // Initialize signals

clk =0;
rst_n =0;
addr =32'b0;
wdata = 16'b0;

 read_en = 0;
 write_en = 0;

// Reset the controller
    #20 rst_n = 1;
	repeat (50) begin
	main();
	repeat (10) 

    @(posedge clk);
	end
	#2000;
	$finish;
end


task main();
begin
	bg_en = $random;
	//addr[2:1] = $urandom_range (0, 3);  // Overwriting 2 bits of ADDRESS to select BG
	//addr[5:3] = $urandom_range (0, 3); 
	wdata =	$urandom_range (16'h0fff, 16'hffff);
	addr = $urandom_range (32'h04050600 , 32'h05050600 );

	write_en = 1;
	read_en  = 0;

// Wait for ready signal
   @(posedge clk);
   while (!ready) @(posedge clk);

   // Test read from the same location
   @(posedge clk);
   write_en = 0;
   read_en = 1;
 
   @(posedge clk);
end
   endtask 


endmodule

