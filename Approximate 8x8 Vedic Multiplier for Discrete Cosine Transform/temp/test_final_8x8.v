module dct_final(
    input signed [0:511] A,  
    input clk,       
    input reset,
    output reg signed [103:0] D 
);

reg signed [0:767] B = {12'd1448,  12'd1448, 12'd1448, 12'd1448, 12'd1448, 12'd1448, 12'd1448, 12'd1448,
			12'd2009,  12'd1703, 12'd1138, 12'd400, -12'd400, -12'd1138, -12'd1703, -12'd2009,
			12'd1892,  12'd784, -12'd784, -12'd1892, -12'd1892, -12'd784, 12'd784, 12'd1892,
			12'd1703, -12'd400, -12'd2009, -12'd1138, 12'd1138, 12'd2009, 12'd400, -12'd1703,
			12'd1448, -12'd1448, -12'd1448, 12'd1448, 12'd1448, -12'd1448, -12'd1448, 12'd1448,
			12'd1138, -12'd2009, 12'd400, 12'd1703, -12'd1703, -12'd400, 12'd2009, -12'd1138,
			12'd784,  -12'd1892, 12'd1892, -12'd784, -12'd784, 12'd1892, -12'd1892, 12'd784,
			12'd400,  -12'd1138, 12'd1703, -12'd2009, 12'd2009, -12'd1703, 12'd1138, -12'd400};  

reg signed [7:0]  matA [7:0][7:0];  
reg signed [11:0] matB [7:0][7:0];  
reg signed [11:0] matBT [7:0][7:0];

reg signed [19:0] PP [0:511];        
reg signed [33:0] PP1 [0:511];       
reg signed [21:0] matC [7:0][7:0];
reg signed [35:0] matD [7:0][7:0]; 

reg enable1, enable2, enable3, enable4, enable5, done;
integer i, j, k, l, m, n, q, a, b, c;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        for (i = 0; i < 511; i = i + 1) begin
            PP[i] <= 20'd0;
	   PP1[i] <= 34'd0;
        end
        for (i = 0; i < 8; i = i + 1) begin
            for (j = 0; j < 8; j = j + 1) begin
                matA[i][j] <= 8'd0;
                matB[i][j] <= 12'd0;
                matBT[i][j]<= 12'd0;
                matC[i][j] <= 22'd0;
                matD[i][j] <= 36'd0;
            end
        end
        enable1 <= 1'b1;
        enable2 <= 1'b0;
        enable3 <= 1'b0;
        enable4 <= 1'b0;
        k <= 0;
        q <= 0;
    end 

else begin
        if (enable1) begin
            for (i = 0; i < 8; i = i + 1) begin
                for (j = 0; j < 8; j = j + 1) begin
                    matA[i][j] <= (A[(i * 8 + j) * 8 +: 8])-(8'd128);  
                    matB[i][j] <= B[(i * 8 + j) * 12 +: 12];
                    matBT[j][i] <= B[(i * 8 + j) * 12 +: 12];
                end
            end
            enable1 <= 1'b0;
            enable2 <= 1'b1;
        end 

else if (enable2) begin
            k = 0;
            for (a = 0; a < 8; a = a + 1) begin 
                for (b = 0; b < 8; b = b + 1) begin  
                    for (c = 0; c < 8; c = c + 1) begin 
                        PP[k] <= matB[a][c] * matA[c][b]; 
                        k = k + 1;  
                    end
                end
            end
            enable2 <= 1'b0; 
            enable3 <= 1'b1;
        end 

else if (enable3) begin
            for (i = 0; i < 8; i = i + 1) begin
                for (j = 0; j < 8; j = j + 1) begin
                    matC[i][j] <= PP[(i*8+j)*8] + PP[(i*8+j)*8+1] + PP[(i*8+j)*8+2] + 
                                  PP[(i*8+j)*8+3] + PP[(i*8+j)*8+4] + PP[(i*8+j)*8+5] + 
                                  PP[(i*8+j)*8+6] + PP[(i*8+j)*8+7];
                end
            end
            enable3 <= 1'b0;
            enable4 <= 1'b1;
        end 

else if (enable4) begin
            q = 0;
            for (l = 0; l < 8; l = l + 1) begin 
                for (m = 0; m < 8; m = m + 1) begin  
                    for (n = 0; n < 8; n = n + 1) begin 
                        PP1[q] <= matC[l][n] * matBT[n][m]; 
                        q = q + 1;  
                    end
                end
            end
            enable4 <= 1'b0;
            enable5 <= 1'b1;
        end 
else if (enable5) begin
            for (i = 0; i < 8; i = i + 1) begin
                for (j = 0; j < 8; j = j + 1) begin
                    matD[i][j] <=( PP1[(i*8+j)*8] + PP1[(i*8+j)*8+1] + PP1[(i*8+j)*8+2] + 
                                  PP1[(i*8+j)*8+3] + PP1[(i*8+j)*8+4] + PP1[(i*8+j)*8+5] + 
                                  PP1[(i*8+j)*8+6] + PP1[(i*8+j)*8+7])>>>24;
                end
            end
            done <= 1'b1;
            enable5 <= 1'b0;
        end
    end
end

endmodule

