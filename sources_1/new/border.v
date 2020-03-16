`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/16/2020 08:52:35 PM
// Design Name: 
// Module Name: border
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


module border(
    input [1:0] bor_wid,
    input [6:0] x, y,
    output [15:0] oled_data
    );
    localparam Width = 96;
    localparam Height = 64;
    parameter [15:0] BLACK = 16'b0;
    parameter [15:0] WHITE = ~BLACK;
    
    // If border on, assign border pixels to be WHITE
    assign oled_data = (bor_wid && (x <= bor_wid - 1 || x >= Width - bor_wid || y <= bor_wid - 1 || y >= Height - bor_wid)) ?
                        WHITE : BLACK;
endmodule
