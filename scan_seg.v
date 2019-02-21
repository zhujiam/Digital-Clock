`timescale 1ns / 1ps

module scan_seg(
    input rst,clk,setAlarm,
    input [3:0] hour_g,hour_d,minute_g,minute_d,second_g,second_d,hour_g_al,hour_d_al,minute_g_al,minute_d_al, //当前时间以及设置的闹钟时间
    output [7:0] DIG,Y
    );
    reg clkout;
    reg [31:0] cnt;
    reg [2:0] scan_cnt;
    parameter period = 200000;
    
    reg [6:0] Y_r;
    reg [7:0] DIG_r;
    
    // decode
    wire [6:0] seg_outhg,seg_outhd,seg_outmg,seg_outmd,seg_outsg,seg_outsd;
    reg [3:0] tmp_hour_g, tmp_hour_d, tmp_min_g, tmp_min_d, tmp_sec_g, tmp_sec_d;
    always@(*) begin
      if (setAlarm) begin
        tmp_hour_g <= hour_g_al;
        tmp_hour_d <= hour_d_al;
        tmp_min_g <= minute_g_al;
        tmp_min_d <= minute_d_al;
        tmp_sec_g <= 0;
        tmp_sec_d <= 0;
      end
      else begin
        tmp_hour_g <= hour_g;
        tmp_hour_d <= hour_d;
        tmp_min_g <= minute_g;
        tmp_min_d <= minute_d;
        tmp_sec_g <= second_g;
        tmp_sec_d <= second_d;
      end
    end
    
    time_display u(tmp_hour_g,seg_outhg);
    time_display u1(tmp_hour_d,seg_outhd);
    time_display u2(tmp_min_g,seg_outmg);
    time_display u3(tmp_min_d,seg_outmd);
    time_display u4(tmp_sec_g,seg_outsg);
    time_display u5(tmp_sec_d,seg_outsd);
    
    assign Y = {1'b1, (~Y_r[6:0])}; // 数码管使能信号，小数点永远不亮
    assign DIG = ~DIG_r;
    
    always@(posedge clk or negedge rst)  // frequency division
    begin
        if (!rst) begin
            cnt <= 0;
            clkout <= 0;
        end 
        else begin
            if (cnt == (period >> 1) - 1)
            begin
                clkout <= ~clkout;
                cnt <= 0;
            end
            else
                cnt <= cnt + 1;
        end
    end
    
    always@(posedge clkout or negedge rst) // change scan_cnt based on clkout
    begin
        if (!rst)
            scan_cnt <= 0;
        else begin
            scan_cnt <= scan_cnt + 1;
            if (scan_cnt == 3'd5) scan_cnt <= 0;
        end
    end
    
    always@(scan_cnt)  // select tube
    begin
        case (scan_cnt)
            3'b000 : DIG_r = 8'b0000_0001;
            3'b001 : DIG_r = 8'b0000_0010;
            3'b010 : DIG_r = 8'b0000_0100;
            3'b011 : DIG_r = 8'b0000_1000;
            3'b100 : DIG_r = 8'b0001_0000;
            3'b101 : DIG_r = 8'b0010_0000;
            default: DIG_r = 8'b0000_0000;
        endcase
    end
    
    always@(scan_cnt)  // decoder to display on 7_seg tube
    begin
        case (scan_cnt)
            0: Y_r = seg_outsd;
            1: Y_r = seg_outsg;
            2: Y_r = seg_outmd;
            3: Y_r = seg_outmg;
            4: Y_r = seg_outhd;
            5: Y_r = seg_outhg;
        endcase
    end
    
endmodule
