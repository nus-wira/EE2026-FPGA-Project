`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.03.2020 17:22:45
// Design Name: 
// Module Name: boardXYconversion
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

module boardXYconversion(
    input [199:0] board,
    input [6:0] x, y,
    output [15:0] oled_data
    );
    localparam Width = 10;
    localparam Height = 20;
    wire [8:0] boardIndex;
    wire inRange;
    assign inRange = x >= `WIDTH - `BLOCKSIZE * Height && y >= `HEIGHT - `BLOCKSIZE * Width;
    assign boardIndex = (((`WIDTH -1 - x)/`BLOCKSIZE) * 10) + ((`HEIGHT - 1 - y)/`BLOCKSIZE);
    assign oled_data = board[boardIndex] && inRange ? `WHITE : `BLACK; 
    
endmodule
