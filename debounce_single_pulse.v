`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.03.2020 15:31:55
// Design Name: 
// Module Name: debounce_single_pulse
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


module debounce_single_pulse(
    input btnC,
    input clk_oled,
    output reset
    );
    
    wire dff_1_out;
    wire dff_2_out;
    
    dff dff0 (clk_oled, btnC, dff_1_out);
    dff dff1 (clk_oled, dff_1_out, dff_2_out);
    
    assign reset = dff_1_out & ~dff_2_out;
endmodule
