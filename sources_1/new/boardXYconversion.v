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
    input clock,
    output [15:0] oled_data
    );
    wire [8:0] boardIndex;
    
    assign boardIndex = (((`WIDTH -1 - x)/`BLOCKSIZE) * 10) + ((`HEIGHT - 1 - y)/`BLOCKSIZE);
    assign oled_data = board[boardIndex] ? `WHITE : `BLACK; 
    
endmodule
