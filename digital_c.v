`timescale 1ns / 1ps

module digital_c(
  input key_h,key_m,key_s,key_al, key_use_al, key_use_dang,  //  时钟控制开关
  input clk,rst_n,   // 时钟和reset信号
  output o_buzzer,  // 蜂鸣器控制信号输出
  output [7:0] DIG,Y // 数码管控制信号输出
  );
  //  分频器，分出多个频率供其他模块使用
  wire o_clk1,o_clk4,o_clk64,o_clk500;
  clock_div u1(clk,rst_n,o_clk1,o_clk4,o_clk64,o_clk500);
  
  // 控制模块，读取输入
  wire c_h,c_m,c_s,c_al,c_use_al,c_use_dang;
  control u2(o_clk64,key_h,key_m,key_s,key_al,key_use_al,key_use_dang,c_h,c_m,c_s,c_al,c_use_al,c_use_dang);
  
  wire [3:0] second_g,second_d,minute_g,minute_d,hour_g,hour_d,hour_g_al,hour_d_al,minute_g_al,minute_d_al;
  wire cout_s,cout_m;
  // 秒计数器
  C_seconds u3(o_clk1,rst_n,c_s,second_g,second_d,cout_s);
  
  // 分计数器
  C_mins u4(cout_s,o_clk4,c_al,rst_n,c_m,minute_g,minute_d,cout_m);
  
  // 时计数器
  C_hours u5(cout_m,o_clk4,c_al,rst_n,c_h,hour_g,hour_d);
  
  wire alarm, alarm2, alarm3;
  // 整点报时模块
  dang_dang u7(clk, minute_g, minute_d, second_g, second_d, c_use_dang, alarm, alarm2);
  
  // 闹钟模块
  alarm u8(hour_g,hour_d,minute_g,minute_d, c_al, c_use_al, c_h, c_m, rst_n, o_clk4, hour_g_al, hour_d_al, minute_g_al, minute_d_al, alarm3);
  
  wire o_clkb;
  // 蜂鸣器控制模块
  buzzer_control u9(clk, rst_n, alarm, alarm2, alarm3, o_clkb);
  
  // 蜂鸣器驱动模块
  buzzer u0(o_clkb, o_buzzer);
  
  // 数码管显示模块
  scan_seg u6( rst_n,clk,c_al,hour_g,hour_d,minute_g,minute_d,second_g,second_d,hour_g_al,hour_d_al,minute_g_al,minute_d_al,DIG,Y);
    
endmodule
