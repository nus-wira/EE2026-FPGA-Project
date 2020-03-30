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

module vol_bar(
    input [15:0] bg_col, volCol_top, volCol_mid, volCol_bot,
    input [3:0] num,
    input [6:0] x, y,
    output reg [15:0] oled_data
    );

    
    // Booleans 
    wire x_range;
    wire [15:0] v;
    assign x_range = x >= 38 && x <= 57;
    // Boolean value at each level
    assign v[0] = 0;
    assign v[1] = (num >= 1 && (y <= `LVL1 && y >= `LVL1 - `LVLH));
    assign v[2] = (num >= 2 && (y <= `LVL2 && y >= `LVL2 - `LVLH));
    assign v[3] = (num >= 3 && (y <= `LVL3 && y >= `LVL3 - `LVLH));
    assign v[4] = (num >= 4 && (y <= `LVL4 && y >= `LVL4 - `LVLH));
    assign v[5] = (num >= 5 && (y <= `LVL5 && y >= `LVL5 - `LVLH));
    assign v[6] = (num >= 6 && (y <= `LVL6 && y >= `LVL6 - `LVLH));
    assign v[7] = (num >= 7 && (y <= `LVL7 && y >= `LVL7 - `LVLH));
    assign v[8] = (num >= 8 && (y <= `LVL8 && y >= `LVL8 - `LVLH));
    assign v[9] = (num >= 9 && (y <= `LVL9 && y >= `LVL9 - `LVLH));
    assign v[10] = (num >= 10 && (y <= `LVL10 && y >= `LVL10 - `LVLH));
    assign v[11] = (num >= 11 && (y <= `LVL11 && y >= `LVL11 - `LVLH));
    assign v[12] = (num >= 12 && (y <= `LVL12 && y >= `LVL12 - `LVLH));
    assign v[13] = (num >= 13 && (y <= `LVL13 && y >= `LVL13 - `LVLH));
    assign v[14] = (num >= 14 && (y <= `LVL14 && y >= `LVL14 - `LVLH));
    assign v[15] = (num >= 15 && (y <= `LVL15 && y >= `LVL15 - 1));
    
    // Assigning volume bar oled_data
    always @ (*) begin
        if (x_range && num > 0 && v) begin
            if (v[5:1])
                oled_data = volCol_bot;
            if (v[10:6])
                oled_data = volCol_mid;
            if (v[15:11]) 
                oled_data = volCol_top; 
        end else 
            oled_data = bg_col;
    end
    
endmodule
