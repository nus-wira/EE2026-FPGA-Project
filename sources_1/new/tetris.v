`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/30/2020 08:03:52 PM
// Design Name: 
// Module Name: tetris
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

module tetris(
    input E, clk, btnCLK, rst, btnD, btnL, btnR, btnU, Edrop,
    input [6:0] x,y,
    output [15:0] oled_data
    );
    
    wire [`TRIS_SIZE-1:0] board;
    wire [8:0] cur_blk1, cur_blk2, cur_blk3;
    wire [4:0] x1,y1,x2,y2,x3,y3;
//    wire [15:0] oled_blk1, oled_blk2, oled_blk3, 
    wire [15:0] oled_board, blk_col;
    wire blk1_E, blk2_E, blk3_E;
    
    tetris_logic tet0(
        .E(E), .clk(clk),.btnCLK(btnCLK),.rst(rst),
        .mvD(btnD),.mvDrop(Edrop), .mvL(btnL), .mvR(btnR), .mvRot(btnU), 
        .board(board), .cur_blk1(cur_blk1), .cur_blk2(cur_blk2), 
        .cur_blk3(cur_blk3), .blk_col(blk_col));

    convertTetris_xy xy1( cur_blk1, x, y, blk1_E);
    convertTetris_xy xy2( cur_blk2, x, y, blk2_E);
    convertTetris_xy xy3( cur_blk3, x, y, blk3_E);
    boardXYconversion b0(board, x, y,oled_board);
    
    assign oled_data = oled_board ? oled_board : 
                       blk1_E || blk2_E || blk3_E ? blk_col : 
                       (x < `WIDTH - `BOARD_HEIGHT || y < `HEIGHT - `BOARD_WIDTH) ? `BLUE : `BLACK;
endmodule
