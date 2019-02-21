`timescale 1ns / 1ps

module digital_c(
  input key_h,key_m,key_s,key_al, key_use_al, key_use_dang,  //  ʱ�ӿ��ƿ���
  input clk,rst_n,   // ʱ�Ӻ�reset�ź�
  output o_buzzer,  // �����������ź����
  output [7:0] DIG,Y // ����ܿ����ź����
  );
  //  ��Ƶ�����ֳ����Ƶ�ʹ�����ģ��ʹ��
  wire o_clk1,o_clk4,o_clk64,o_clk500;
  clock_div u1(clk,rst_n,o_clk1,o_clk4,o_clk64,o_clk500);
  
  // ����ģ�飬��ȡ����
  wire c_h,c_m,c_s,c_al,c_use_al,c_use_dang;
  control u2(o_clk64,key_h,key_m,key_s,key_al,key_use_al,key_use_dang,c_h,c_m,c_s,c_al,c_use_al,c_use_dang);
  
  wire [3:0] second_g,second_d,minute_g,minute_d,hour_g,hour_d,hour_g_al,hour_d_al,minute_g_al,minute_d_al;
  wire cout_s,cout_m;
  // �������
  C_seconds u3(o_clk1,rst_n,c_s,second_g,second_d,cout_s);
  
  // �ּ�����
  C_mins u4(cout_s,o_clk4,c_al,rst_n,c_m,minute_g,minute_d,cout_m);
  
  // ʱ������
  C_hours u5(cout_m,o_clk4,c_al,rst_n,c_h,hour_g,hour_d);
  
  wire alarm, alarm2, alarm3;
  // ���㱨ʱģ��
  dang_dang u7(clk, minute_g, minute_d, second_g, second_d, c_use_dang, alarm, alarm2);
  
  // ����ģ��
  alarm u8(hour_g,hour_d,minute_g,minute_d, c_al, c_use_al, c_h, c_m, rst_n, o_clk4, hour_g_al, hour_d_al, minute_g_al, minute_d_al, alarm3);
  
  wire o_clkb;
  // ����������ģ��
  buzzer_control u9(clk, rst_n, alarm, alarm2, alarm3, o_clkb);
  
  // ����������ģ��
  buzzer u0(o_clkb, o_buzzer);
  
  // �������ʾģ��
  scan_seg u6( rst_n,clk,c_al,hour_g,hour_d,minute_g,minute_d,second_g,second_d,hour_g_al,hour_d_al,minute_g_al,minute_d_al,DIG,Y);
    
endmodule
