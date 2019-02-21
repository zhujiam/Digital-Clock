`timescale 1ns / 1ps

module control(clk,key_h,key_m,key_s,key_al,key_use_al,key_use_dang,c_h,c_m,c_s,c_al,c_use_al,c_use_dang);
input clk,key_h,key_m,key_s,key_al,key_use_al,key_use_dang; // ʱ���ź��Լ����������ź�
output reg c_h,c_m,c_s,c_al,c_use_al,c_use_dang; // ��������źſ�������ģ��

always@(posedge clk)
begin
    c_h <= key_h;
    c_m <= key_m;
    c_s <= key_s;
    c_al <= key_al;
    c_use_al <= key_use_al;
    c_use_dang <= key_use_dang;
end
 
endmodule
