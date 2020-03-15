`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/09/2020 03:20:13 PM
// Design Name: 
// Module Name: intensity
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


module intensity(
    input clk, E,
    input [11:0] mic_in,
    output [11:0] led,
    output [3:0] an,
    output [6:0] seg
    );
    reg [11:0] bit12 = 1 << 11;
    
    wire [3:0] num;
    // Convert mic to decimal digit from 0 to 15
    assign num = mic_in[10:7];
    
    show_digit s0(clk, num, an, seg);
    show_led s1(num, led);
    
    
    
endmodule

