`timescale 1ns / 1ps


module alarm(
    input [3:0] i_hour1,
    input [3:0] i_hour0,
    input [3:0] i_min1,
    input [3:0] i_min0,
    input set_al,
    input use_al,
    input adj_hour,
    input adj_min,
    input rst_n,
    input clk,
    output reg [3:0] o_hour1,
    output reg [3:0] o_hour0,
    output reg [3:0] o_min1,
    output reg [3:0] o_min0,
    output reg alarm3
    );
    
    reg [3:0] al_hour1, al_hour0;
    reg [3:0] al_min1, al_min0;
    
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            alarm3 <=0; 
            al_hour1 <= 0;
            al_hour0 <= 0;
            al_min1 <= 0;
            al_min0 <= 0;
        end
        else begin
            if(set_al) begin
                if(adj_min) begin
                    if(al_min0 == 9) begin
                        al_min0 <= 0;
                        if(al_min1 == 5) al_min1 <= 0;
                        else al_min1 <= al_min1 + 1;
                    end
                        else al_min0 <= al_min0 + 1;
                end
                if(adj_hour) begin
                    if({al_hour1, al_hour0} == {4'b0010,4'b0011}) begin
                        al_hour1 <= 0;
                        al_hour0 <= 0;
                    end
                    else if(al_hour0 == 9) begin
                        al_hour0 <= 0;
                        al_hour1 <= al_hour1 + 1;
                    end
                    else al_hour0 <= al_hour0 + 1;
                end
            end
            alarm3 <=0;
            if({i_hour1,i_hour0,i_min1,i_min0}=={al_hour1,al_hour0,al_min1,al_min0}) begin
                if(use_al) alarm3 <= 1;
            end
        end
        o_hour1 <= al_hour1;
        o_hour0 <= al_hour0;
        o_min1 <= al_min1;
        o_min0 <= al_min0;
    end
    
endmodule