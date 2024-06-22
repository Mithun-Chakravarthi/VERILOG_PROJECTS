module piso(
input [7:0]datain,clk,ld,
output reg dout);
reg [7:0]tempreg;

initial begin
tempreg<=8'b0;
end

always@(posedge clk)
begin

    if(ld==1'b1)
        begin
        tempreg<=datain;
        dout<=tempreg[0];
        end
        
    else
        begin
        tempreg<=tempreg>>1'b1;
        tempreg[7]<=1'b0;
        dout<=tempreg[0];
        end
    
end
endmodule