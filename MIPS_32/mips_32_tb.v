module mips_32_tb();
reg clk1,clk2;
integer k;

pipe_MIPS32 dut(clk1,clk2);
initial 
  begin
  clk1=0;clk2=0;

	repeat(20)
	begin
	#5 clk1=1; #5 clk1=0;
	#5 clk2=1; #5 clk2=0;
	end
   end

initial begin
for(k=0;k<31;k=k+1)
  dut.REG[k]=k;
  dut.MEM[0]=32'h2801000a;  // ADDI R1,R0,10
  dut.MEM[1]=32'h28020014;  // ADDI R2,R0,20
  dut.MEM[2]=32'h28030019;  // ADDI R3,R0,25
  dut.MEM[3]=32'h0ce77800;  // OR R7,R7,R7 ----DUMMY INSTR
  dut.MEM[4]=32'h0ce77800;  // OR R7,R7,R7 ----DUMMY INSTR
  dut.MEM[5]=32'h00222000;  // ADD R4,R1,R2
  dut.MEM[6]=32'h0ce77800;  // OR R7,R7,R7 ----dummy instr
  dut.MEM[7]=32'h00832800;  // ADD R5,R4,R3
  dut.MEM[8]=32'hfc000000;  // HLT
   
  dut.HALTED=0;
  dut.PC=0;
  dut.TAKEN_BRANCH=0;
 
  #280
   for(k=0;k<6;k=k+1)
     $display("R%1d  - %2d",k,dut.REG[k]);
   end

  initial begin
    #300 $finish;
 end
endmodule
    

