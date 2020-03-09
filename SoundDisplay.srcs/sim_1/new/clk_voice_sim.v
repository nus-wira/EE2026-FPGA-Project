`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/09/2020 03:08:40 PM
// Design Name: 
// Module Name: clk_voice_sim
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module clk_voice_sim(

    );
    reg CLOCK;
    wire clk20k;
    
    clk_voice c0(CLOCK, clk20k);
    
    initial begin
        CLOCK = 0;
    end
    
    
    always begin
        #5 CLOCK = ~CLOCK;
    end
    
endmodule
