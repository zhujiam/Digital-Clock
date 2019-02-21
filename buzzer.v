`timescale 1ns / 1ps

module buzzer(
    input clk,
    output o_buzzer
    );
    
    reg counter;
    
    always @(posedge clk) begin
        counter <= counter + 1;
    end
    
    assign o_buzzer = counter;
    
endmodule