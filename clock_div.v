`timescale 1ns / 1ps

module clock_div(
    input clk,
    input rst_n,
    output reg o_clk1,
    output reg o_clk4,
    output reg o_clk64,
    output reg o_clk500
    );

    reg [27:0] cnt1;
    reg [27:0] cnt4;
    reg [27:0] cnt64;
    reg [27:0] cnt500;
    
    parameter cnts1 = 100000000;
    parameter cnts4 = 25000000;
    parameter cnts64 = 1562500;
    parameter cnts500 = 200000;
    
    always @(posedge clk, negedge rst_n) begin
    if (~rst_n) begin
        cnt1 <= 0;
        cnt4 <= 0;
        cnt64 <= 0;
        cnt500 <= 0;
        o_clk1<=0;
        o_clk4<=0;
        o_clk64<=0;
        o_clk500<=0;
    end
    else begin
        if (cnt1 == (cnts1>>1)-1) begin
            cnt1 <= 0;
            o_clk1 <= ~o_clk1;
        end
        else
            cnt1 <= cnt1+1;
        if (cnt4 == (cnts4>>1)-1) begin
            cnt4 <= 0;
            o_clk4 <= ~o_clk4;
        end
        else
            cnt4 <= cnt4+1;
        if (cnt64 == (cnts64>>1)-1) begin
            cnt64 <= 0;
            o_clk64 <= ~o_clk64;
        end
        else
            cnt64 <= cnt64+1;
        if (cnt500 == (cnts500>>1)-1) begin
            cnt500 <= 0;
            o_clk500 <= ~o_clk500;
        end
        else
            cnt500 <= cnt500+1;
    end
    end
    
endmodule
