`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/02/2020 02:09:11 PM
// Design Name: 
// Module Name: convertMini_xy
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


module convertMini_xy(
    input [3:0] miniXY,
    input [`PIXELXYBIT:0] x, y,
    output block_en
    );
    localparam x_max = 54;
    localparam y_max = 18;
    
    wire [2:0] miniX, miniY;
    wire [8:0] xrangemax, yrangemax;
    wire [`OLEDBIT:0] oled_dataX, oled_dataY;
    
    assign miniX = miniXY % `MINI_WIDTH; 
    assign miniY = miniXY / `MINI_WIDTH;
    assign xrangemax = x_max - miniY * `BLOCKSIZE;
    assign yrangemax = y_max - miniX * `BLOCKSIZE;
    
    assign oled_dataX = x >= xrangemax - `BLOCKSIZE && x < xrangemax;
    assign oled_dataY = y >= yrangemax - `BLOCKSIZE && y < yrangemax;
    
    assign block_en = (oled_dataX && oled_dataY);
endmodule
