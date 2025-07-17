module ddr4_controller (
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
localparam ROW_BITS = 10;          // Number of bits for row address
localparam COL_BITS = 10;          // Number of bits for column address
localparam BANK_BITS = 3;          // Number of bank bits (up to 8 banks)
localparam BG_BITS = 2;            // Number of bank group bits (up to 4 bank groups)
localparam DATA_WIDTH = 32;        // Data width

// State machine for controlling DDR4 operations
localparam IDLE      = 3'b000;
localparam BG_SEL    = 3'b001;
localparam ACTIVATE  = 3'b010;
localparam READ      = 3'b011;
localparam WRITE     = 3'b100;
localparam PRECHARGE = 3'b101;

reg [2:0] state, next_state;
reg [ROW_BITS-1:0] row_addr;
reg [COL_BITS-1:0] col_addr;
reg [2:0] bank_addr;
reg [1:0] bank_group;
reg [ROW_BITS-1:0] active_row;
reg [COL_BITS-1:0] active_col;

reg [DATA_WIDTH-1:0] mem [0:(1 << ROW_BITS) - 1];  // DRAM memory array

// Extract row, column, bank, and bank group from the input address
always @(*) begin
    row_addr   = addr[31:16];
    col_addr   = addr[15:6];
    bank_addr  = addr[5:3];
    bank_group = addr[2:1];
end

// State transition logic
always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        state <= IDLE;
    else
        state <= next_state;
end



always @(*) begin
    next_state = state;
    ready = 0;

    // Default (No Operation)
    ddr4_ras_n = 1;
    ddr4_cas_n = 1;
    ddr4_we_n  = 1;
    ddr4_cs_n  = 1;

    case (state)
        IDLE: begin
            ready = 1;
            if (read_en || write_en) begin // Before Issuing a read or Write command
                next_state = ACTIVATE;    // We need to activate our Memory first 
            end                            
        end

        ACTIVATE: begin
            ddr4_cs_n  = 0;
            ddr4_ras_n = 0;
            ddr4_cas_n = 1;
            ddr4_we_n  = 1;
            ddr4_addr  = row_addr;   // We should first select our row first for READ or WRITE
            ddr4_ba    = bank_addr;
            ddr4_bg    = bank_group; // In which Bank we should activate our row
            active_row = row_addr;
            next_state = (read_en) ? READ : WRITE;
        end

        READ: begin
            ddr4_cs_n  = 0;
            ddr4_ras_n = 1;
            ddr4_cas_n = 0;
            ddr4_we_n  = 1;
            ddr4_addr  = col_addr; // After Activating the particular row we should select  
            ddr4_ba    = bank_addr;// from which Coloumn we should read the data.
            ddr4_bg    = bank_group;
            active_col = col_addr;
            rdata      = mem[active_row];
            next_state = PRECHARGE;
        end

        WRITE: begin
            ddr4_cs_n  = 0;
            ddr4_ras_n = 1;
            ddr4_cas_n = 0;
            ddr4_we_n  = 0;
            ddr4_addr  = col_addr;// After Activating the particular row we should select  
            ddr4_ba    = bank_addr;//To which Coloumn we should write the data.
            ddr4_bg    = bank_group;
            ddr4_dq    = wdata;
            mem[active_row] = wdata;
            next_state = PRECHARGE;
        end

        PRECHARGE: begin
            ddr4_cs_n  = 0;
            ddr4_ras_n = 0;
            ddr4_cas_n = 1;
            ddr4_we_n  = 0;
            ddr4_addr[10] = 1'b1; // Precharge all banks
            next_state = IDLE;
        end

        default: begin
            next_state = IDLE;
        end
    endcase
end


endmodule
