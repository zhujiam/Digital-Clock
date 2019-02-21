`timescale 1ns / 1ps

module C_hours(clk,st_clk,st_alam,reset,control,hour_g,hour_d);
input  clk,st_clk,st_alam,reset,control; // 时钟、reset信号、设置闹钟信号以及调分控制信号
output reg [3:0] hour_g,hour_d; //  分别保存小时的十位和个位


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

always@(posedge _clk, negedge reset)
begin
     if(!reset) begin
       hour_g <= 0;
       hour_d <= 0;
     end 
     else begin 
       if((hour_d == 3)&&(hour_g == 2))
         begin
           hour_g <=0;
           hour_d <= 0;
         end
       else 
       begin
         if(hour_d == 9)
           begin
           hour_d <= 0;
           hour_g <= hour_g + 1;
           end
         else
           hour_d <= hour_d + 1;
       end
     end
end

endmodule
