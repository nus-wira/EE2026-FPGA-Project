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
    output [15:0] led,
    output [3:0] an,
    output [7:0] seg,
    output reg [3:0] num = 0
    );
    
    reg [13:0] count = 0;
    reg [11:0] max_vol = 0;
    wire clk60, clk20k;
    wire [15:0] led_peak;
    
    assign seg[7] = 1; //dp
    
    // Convert mic to decimal digit from 0 to 15
    // Updates num every 5000 samples.
    always @ (posedge clk20k) begin
        count <= count == 14'd5000 ? 0 : count + 1;
        max_vol <= count == 0 ? mic_in : (mic_in > max_vol ? mic_in : max_vol);
        num <= max_vol[11] ? max_vol[10:7] : 0;
    end
    
    clk_divider c1(clk, 25'd2499, clk20k); //20kHz
    clk_divider c0(clk, 25'd833332, clk60); //60 Hz
    // can possibly remove clk60 and update using num directly
    show_digit s0(clk, clk60, num, an, seg[6:0]);
    show_led s1(clk60, num, led_peak);
    
    // Multiplexer for audio to led/7seg
    multi_1bit m0(E, {4'b0, mic_in}, led_peak, led);
    
endmodule

