`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.03.2020 14:57:29
// Design Name: 
// Module Name: convertXY
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


module convertXY(
//    input clk,
    input [12:0] pixel_index,
    output [6:0] x, y
    );
    
    assign x = pixel_index % 96;
    assign y = pixel_index / 96;
    
endmodule
