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
    input sw1, sw2,
    input [3:0] num,
    input [12:0] pixel_index,
    output [15:0] oled_data
    );
    
    wire [6:0] x,y;
    wire [1:0] bor_wid;
    wire [15:0] oled_vol, oled_border;
    
    // Border width using switches
    assign bor_wid = sw1 ? 1 : (sw2 ? 3 : 0);
    
    // Convert pixel_index to x , y values
    convertXY xy0(pixel_index, x, y);
    // Border and volume bar
    border b0(bor_wid, x, y, oled_border);
    vol_bar v0(sw1, sw2, num, x, y, oled_vol);
    // Mux to choose oled to display
    oled_mux m0(x, y, oled_border, oled_vol, oled_data);

endmodule
