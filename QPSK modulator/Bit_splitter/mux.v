module mux(input a,b,s,
output out);
assign out=s?b:a;
endmodule