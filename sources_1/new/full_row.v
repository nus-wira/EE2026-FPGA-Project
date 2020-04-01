`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/30/2020 05:24:59 PM
// Design Name: 
// Module Name: full_row
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

module full_row(
    input clk,
    input [`TRIS_SIZE-1:0] board,
    output reg [4:0] row = 0,
    output remove
    );
    
    // If all 1s in a row
    assign remove = &board[row*`TRIS_WIDTH +: `TRIS_WIDTH];
    
    always @ (posedge clk) begin
        row <= !remove ? row == `TRIS_HEIGHT - 1 ? 0 : row + 1 : row;
    end
endmodule
