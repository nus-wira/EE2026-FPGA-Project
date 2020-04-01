`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.03.2020 14:58:14
// Design Name: 
// Module Name: convertTetris_xy
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
`include "definitions.vh"

module convertTetris_xy(
    input [8:0] tetrisXY,
    input [6:0] x, y,
    output block_en
    );
    
    wire [4:0] tetrisX, tetrisY;
    wire [8:0] xrangemax, yrangemax;
    wire [`OLEDBIT:0] oled_dataX, oled_dataY;
    
    assign tetrisX = tetrisXY % `TRIS_WIDTH; 
    assign tetrisY = tetrisXY / `TRIS_WIDTH;
    assign xrangemax = `WIDTH - tetrisY * `BLOCKSIZE;
    assign yrangemax = `HEIGHT - tetrisX * `BLOCKSIZE;
    
    assign oled_dataX = x >= xrangemax - `BLOCKSIZE && x < xrangemax;
    assign oled_dataY = y >= yrangemax - `BLOCKSIZE && y < yrangemax;
    
    assign block_en = (oled_dataX && oled_dataY);
endmodule
