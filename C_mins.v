`timescale 1ns / 1ps

module C_mins(clk,st_clk,st_alam,reset,control,minute_g,minute_d,cout_m);
input  clk,st_clk,st_alam,reset,control; // 时钟、reset信号、设置闹钟信号以及调分控制信号
output reg cout_m;  // 分进位
output reg [3:0] minute_g,minute_d; //  分别保存分的十位和个位

reg control_;
always@(*)
  if (st_alam)
     control_ <= 0;
  else
     control_ <= control;
  

reg _clk;
always@(*)
    if (control_) begin
        _clk <= st_clk;
    end
    else begin
        _clk <= clk;
    end

always@(posedge _clk)
begin
     if(!reset) begin
         minute_d <= 0;
         minute_g <= 0;
     end 
     else begin
         if(minute_d == 9) begin
             minute_d <= 0;
             if(minute_g == 5)
                minute_g <= 0;
             else 
                minute_g <= minute_g + 1;
         end
         else 
            minute_d <= minute_d + 1;
     end
     if (control)
         cout_m <= 0;
     else
         cout_m <= (minute_g == 5)&&(minute_d == 9) ? 1:0;
end

endmodule
