`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/16/2020 06:58:54 PM
// Design Name: 
// Module Name: vol_bar
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

module vol_display (
    input [5:0] sw,
    input clk,
    input [3:0] num,
    input [12:0] pixel_index,
    output [15:0] oled_data
    );
    
    wire [6:0] x,y;
    wire [1:0] bor_wid;
    wire [1:0] volDisp_col;
    wire [15:0] oled_vol, oled_border;
    wire [15:0] bor_col, bg_col, volCol_top, volCol_mid, volCol_bot;
    reg [3:0] freezeNum = 0;
    
    // Border width using switches
    assign bor_wid = sw[1] ? 1 : (sw[2] ? 3 : 0);
    
    // Freezing screen
    always @ (posedge clk) begin
        freezeNum = sw[5] ? freezeNum : num;
    end
    // Convert pixel_index to x , y values
    convertXY xy0(pixel_index, x, y);
    // Mux to choose vol_bar colour
    colour_mux m1(sw[3], sw[4], bor_col, bg_col, volCol_top, volCol_mid, volCol_bot);
    // Border and volume bar
    border b0(bor_col, bg_col, bor_wid, x, y, oled_border);
    vol_bar v0(bg_col, volCol_top, volCol_mid, volCol_bot, freezeNum, x, y, oled_vol);
    // Mux to choose oled to display
    oled_mux m0(x, y, oled_border, oled_vol, oled_data);
    
    
endmodule
