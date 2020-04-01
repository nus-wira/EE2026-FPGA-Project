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
`include "definitions.vh"

module convertXY(
    input [`PIXELBIT:0] pixel_index,
    output [`PIXELXYBIT:0] x, y
    );
    
    assign x = pixel_index % `WIDTH;
    assign y = pixel_index / `WIDTH;
    
endmodule
