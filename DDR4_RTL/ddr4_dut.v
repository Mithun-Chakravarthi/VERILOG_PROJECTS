module DDR4_Controller (
    input wire clk,            // System clock
    input wire rst_n,          // Reset (active low)
    input wire [31:0] addr,    // Address input (row, column, bank, bank group)
    input wire [15:0] wdata,   // Write data input
    output reg [15:0] rdata,   // Read data output
    input wire read_en,        // Read enable signal
    input wire write_en,       // Write enable signal
	input wire [1:0] bg_en,
    output reg ready,          // Ready signal (indicates controller is ready for next operation)
    
    // DDR4 Interface Signals (simplified)
    output reg [15:0] ddr4_dq,     // DDR4 data bus
    output reg [15:0] ddr4_addr,   // DDR4 address bus
    output reg [2:0] ddr4_ba,      // DDR4 bank address
    output reg [1:0] ddr4_bg,      // DDR4 bank group
    output reg ddr4_ras_n,         // DDR4 row address strobe (active low)
    output reg ddr4_cas_n,         // DDR4 column address strobe (active low)
    output reg ddr4_we_n,          // DDR4 write enable (active low)
    output reg ddr4_cs_n           // DDR4 chip select (active low)
);

// DDR4 memory parameters
localparam ROW_BITS = 16;     // Number of bits for row address
localparam COL_BITS = 10;     // Number of bits for column address
localparam BANK_BITS = 3;     // Number of bank bits (up to 8 banks)
localparam BG_BITS = 2;       // Number of bank group bits (up to 4 bank groups)
localparam DATA_WIDTH = 32;       // Number of bank group bits (up to 4 bank groups)

// State machine for controlling DDR4 operations
localparam IDLE    = 3'b000;
localparam BG_SEL    = 3'b001;
localparam ACTIVATE= 3'b010;
localparam READ    = 3'b011;
localparam WRITE   = 3'b100;
localparam PRECHARGE = 3'b101;

reg [2:0] state, next_state;
reg [31:0] row_addr, col_addr;
reg [2:0] bank_addr;
reg [1:0] bank_group;
reg [ROW_BITS - 1 : 0] active_row;
reg [COL_BITS -1 : 0 ] active_col;
    //reg [DATA_WIDTH-1:0] mem [0:(1 << ROW_BITS) * (1 << COL_BITS) - 1];  // DRAM memory array
    reg [DATA_WIDTH-1:0] mem [0:(1 << ROW_BITS)  - 1];  // DRAM memory array



// Extract row, column, bank, and bank group from the input address
always @(*) begin
    row_addr   = addr[31:16];  // Extract row address (16 bits)
    col_addr   = addr[15:6];   // Extract column address (10 bits)
    bank_addr  = addr[5:3];    // Extract bank address (3 bits)
    bank_group = addr[2:1];    // Extract bank group (2 bits)
end

// State transition logic
always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        state <= IDLE;
    else
        state <= next_state;
end

// Next state logic and control signals
always @(*) begin
    // Default assignments

    next_state = state;
    ready = 0;
    ddr4_ras_n = 1;
    ddr4_cas_n = 1;
    ddr4_we_n = 1;
    ddr4_cs_n = 1;

    case (state)
        IDLE: begin
            ready = 1;  // Ready to accept new command
            if (read_en || write_en) begin
                next_state = ACTIVATE;
            end
        end

       ACTIVATE: begin
           ddr4_cs_n = 0;
           ddr4_ras_n = 0;   // Activate command
           ddr4_addr = row_addr[ROW_BITS-1:0];
           active_row = row_addr[ROW_BITS-1:0];
           ddr4_ba = bank_addr;
           ddr4_bg = bank_group;
           next_state = (read_en) ? READ : WRITE;
       end


       READ: begin

	   			case(ddr4_bg )		//Bank_Group selection for Rdata
	2'b00: begin
           ddr4_cs_n = 0;
           ddr4_cas_n = 0;   // Read command
           active_col = col_addr[COL_BITS-1:0];
           ddr4_addr = col_addr[COL_BITS-1:0];
           ddr4_ba = bank_addr;
           ddr4_bg = bank_group;
       rdata = ddr4_dq;  // Capture data from DDR4 memory
   	//rdata = mem [{active_row ,active_col}];
   	rdata = mem [active_row];
           next_state = PRECHARGE;  end


	2'b01: begin
           ddr4_cs_n = 0;
           ddr4_cas_n = 0;   // Read command
           active_col = col_addr[COL_BITS-1:0];
           ddr4_addr = col_addr[COL_BITS-1:0];
           ddr4_ba = bank_addr;
           ddr4_bg = bank_group;
       rdata = ddr4_dq;  // Capture data from DDR4 memory
   	//rdata = mem [{active_row ,active_col}];
   	rdata = mem [active_row];
           next_state = PRECHARGE;  end

	2'b10: begin
           ddr4_cs_n = 0;
           ddr4_cas_n = 0;   // Read command
           active_col = col_addr[COL_BITS-1:0];
           ddr4_addr = col_addr[COL_BITS-1:0];
           ddr4_ba = bank_addr;
           ddr4_bg = bank_group;
       rdata = ddr4_dq;  // Capture data from DDR4 memory
   	//rdata = mem [{active_row ,active_col}];
   	rdata = mem [active_row];
           next_state = PRECHARGE;  end


		2'b11: begin
           ddr4_cs_n = 0;
           ddr4_cas_n = 0;   // Read command
           active_col = col_addr[COL_BITS-1:0];
           ddr4_addr = col_addr[COL_BITS-1:0];
           ddr4_ba = bank_addr;
           ddr4_bg = bank_group;
       rdata = ddr4_dq;  // Capture data from DDR4 memory
   	//rdata = mem [{active_row ,active_col}];
   	rdata = mem [active_row];
           next_state = PRECHARGE;  end

	default: next_state = IDLE;
	endcase
		  
       end

       WRITE: begin  
	   		case (ddr4_bg ) 		//	Bank_Group selection for wdata
		2'b00: begin
           ddr4_cs_n = 0;
           ddr4_we_n = 0;    // Write command
           ddr4_addr = col_addr[COL_BITS-1:0];
           ddr4_ba = bank_addr;
           ddr4_bg = bank_group;
           ddr4_dq = wdata;
   		mem[active_row] <= wdata;
           next_state = PRECHARGE;  end
	2'b01:  begin
           ddr4_cs_n = 0;
           ddr4_we_n = 0;    // Write command
           ddr4_addr = col_addr[COL_BITS-1:0];
           ddr4_ba = bank_addr;
           ddr4_bg = bank_group;
           ddr4_dq = wdata;
   		mem[active_row] <= wdata;
           next_state = PRECHARGE;  end

		2'b10:  begin
           ddr4_cs_n = 0;
           ddr4_we_n = 0;    // Write command
           ddr4_addr = col_addr[COL_BITS-1:0];
           ddr4_ba = bank_addr;
           ddr4_bg = bank_group;
           ddr4_dq = wdata;
   		mem[active_row] <= wdata;
           next_state = PRECHARGE;  end

		2'b11: begin
           ddr4_cs_n = 0;
           ddr4_we_n = 0;    // Write command
           ddr4_addr = col_addr[COL_BITS-1:0];
           ddr4_ba = bank_addr;
           ddr4_bg = bank_group;
           ddr4_dq = wdata;
   		mem[active_row] <= wdata;
           next_state = PRECHARGE;  end

		 default :next_state = IDLE; 
		 endcase
		   
       end

        PRECHARGE: begin
            ddr4_cs_n = 0;
            ddr4_ras_n = 0;
            ddr4_we_n = 0;   // Precharge command
            next_state = IDLE;
        end
    endcase
end

endmodule



