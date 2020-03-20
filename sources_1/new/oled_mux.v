`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/20/2020 12:01:04 PM
// Design Name: 
// Module Name: oled_mux
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


module oled_mux(
    input x,y,
    input [15:0] oled_border, oled_vol,
    output [15:0] oled_data
    );
    localparam Width = 96;
    localparam Height = 64;
    parameter [1:0] bor_wid = 3; // max border width
    
    // If at border, assign border else volume bar
    assign oled_data = (x < bor_wid || x >= Width - bor_wid || y < bor_wid || y >= Height - bor_wid) ?
                        oled_border : oled_vol;
    
endmodule
