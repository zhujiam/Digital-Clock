`timescale 1ns / 1ps

module time_display(
    input [3:0] i_time,
    output reg [6:0] seg_out
    );
    
    always@(*)
    begin
    case (i_time)
    4'b0000 : seg_out <= 7'b0111111; // 0 
    4'b0001 : seg_out <= 7'b0000110; // 1 
    4'b0010 : seg_out <= 7'b1011011; // 2 
    4'b0011 : seg_out <= 7'b1001111; // 3 
    4'b0100 : seg_out <= 7'b1100110; // 4 
    4'b0101 : seg_out <= 7'b1101101; // 5 
    4'b0110 : seg_out <= 7'b1111101; // 6 
    4'b0111 : seg_out <= 7'b0100111; // 7 
    4'b1000 : seg_out <= 7'b1111111; // 8 
    4'b1001 : seg_out <= 7'b1101111; // 9 
    endcase
    end
    
endmodule
