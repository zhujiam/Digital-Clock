`timescale 1ns / 1ps

module C_seconds(clk,reset,control,second_g,second_d,cout_s);
input  clk,reset,control; // ʱ�ӡ�reset�ź��Լ���������ź�
output reg cout_s;  // ���λ
output reg [3:0] second_g,second_d; //  �ֱ𱣴����ʮλ�͸�λ

always@(posedge clk, negedge reset)
begin
  if (control) begin
     {second_g,second_d} <= 8'b00000000;
     cout_s <= 1'b0;
     end
  else if(!reset) begin
     second_d <= 0;
     second_g <= 0;
    end 
  else begin
     if(second_d == 9) begin
        second_d <= 0;
        if(second_g == 5)
           second_g <= 0;
        else
           second_g <= second_g + 1;
     end
     else
       second_d <= second_d + 1;
  end
  cout_s <= ((second_g == 5)&&(second_d == 9))?1:0;
end

endmodule
