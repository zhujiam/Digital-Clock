`timescale 1ns / 1ps

module dang_dang(
    input clk,
    input [3:0] i_min1,
    input [3:0] i_min0,
    input [3:0] i_sec1,
    input [3:0] i_sec0,
    input use_dang,
    output reg alarm,
    output reg alarm2
    );
    
    always @(posedge clk) begin
        if (use_dang) begin
            if ({i_min1,i_min0,i_sec1}=={4'b0101,4'b1001,4'b0101}) begin
                if (i_sec0 == 4'b0000) alarm <= 1;
                if (i_sec0 == 4'b0001) alarm <= 0;
                if (i_sec0 == 4'b0010) alarm <= 1;
                if (i_sec0 == 4'b0011) alarm <= 0;
                if (i_sec0 == 4'b0100) alarm <= 1;
                if (i_sec0 == 4'b0101) alarm <= 0;
                if (i_sec0 == 4'b0110) alarm <= 1;
                if (i_sec0 == 4'b0111) alarm <= 0;
                if (i_sec0 == 4'b1000) alarm <= 1;
                if (i_sec0 == 4'b1001) alarm <= 0;
            end
            if ({i_min1,i_min0,i_sec1}=={4'b0000,4'b0000,4'b0000}) begin
                if (i_sec0 == 4'b0000) alarm2 <=1;
                if (i_sec0 == 4'b0001) alarm2 <=0;
            end
        end
    end
    
endmodule
