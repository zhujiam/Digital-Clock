`timescale 1ns / 1ps

module buzzer_control(
    input clk,
    input rst_n,
    input alarm,
    input alarm2,
    input alarm3,
    output reg o_clknk
    );

    reg [27:0] cnt1000;
    reg [27:0] cnt2000;
    
    parameter cnts1000 = 100000;
    parameter cnts2000 = 50000;
    
    always @(posedge clk, negedge rst_n) begin
        if (~rst_n) begin
            cnt1000 <= 0;
            cnt2000 <= 0;
            o_clknk<=0;
        end
        else begin
            if (alarm3) begin
                if (cnt2000 == (cnts2000>>1)-1) begin
                    cnt2000 <= 0;
                    o_clknk <= ~o_clknk;
                end
                else cnt2000 <= cnt2000+1;
            end
            else if (alarm) begin
                if (cnt1000 == (cnts1000>>1)-1) begin
                    cnt1000 <= 0;
                    o_clknk <= ~o_clknk;
                end
                else cnt1000 <= cnt1000+1;
            end
            else if (alarm2) begin
                if (cnt2000 == (cnts2000>>1)-1) begin
                    cnt2000 <= 0;
                    o_clknk <= ~o_clknk;
                end
                else cnt2000 <= cnt2000+1;
            end
        end
    end
    
endmodule
