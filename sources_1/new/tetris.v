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
    input E, clk, btnCLK, rst, pause, btnD, btnL, btnR, btnU, Edrop, micD,
    input [`PIXELXYBIT:0] x,y,
    output [`OLEDBIT:0] oled_data
    );
    
    wire [`TRIS_SIZE-1:0] board;
    wire [8:0] cur_blk1, cur_blk2, cur_blk3, cur_blk4;
    wire [`OLEDBIT:0] oled_board, blk_col, next_blk_col, oled_pause;
    wire blk1_E, blk2_E, blk3_E, blk4_E, next_blk_E, title_E;
    wire [2:0] next_blk, mode, tris_menu;
    
    tetris_logic tet0(
        .E(E), .clk(clk),.btnCLK(btnCLK),.rst(rst), .pause(pause), .tris_menu(tris_menu),
        .mvD(btnD),.mvDrop(Edrop), .mvL(btnL), .mvR(btnR), .mvRot(btnU), .micD(micD),
        .board(board), .cur_blk1(cur_blk1), .cur_blk2(cur_blk2), 
        .cur_blk3(cur_blk3), .cur_blk4(cur_blk4), .blk_col(blk_col), .rand_blk(next_blk), .mode(mode));

    convertTetris_xy xy1(cur_blk1, x, y, blk1_E);
    convertTetris_xy xy2(cur_blk2, x, y, blk2_E);
    convertTetris_xy xy3(cur_blk3, x, y, blk3_E);
    convertTetris_xy xy4(cur_blk4, x, y, blk4_E);
    boardXYconversion b0(board, x, y,oled_board);
    show_next_blk n0(next_blk, x, y, next_blk_col, next_blk_E);
    tetris_game_title t0(x,y, title_E);
    tetrisPause_Screen p0(.clk(btnCLK), .btnL(btnU), .btnR(btnD), .pause(pause),
        .x(x), .y(y), .oled_data(oled_pause), .state(tris_menu));
    
    assign oled_data = pause || mode == `MODE_OVER ? oled_pause : 
                       title_E ? `WHITE : oled_board ? oled_board : 
                       blk1_E || blk2_E || blk3_E || blk4_E ? blk_col : 
                       next_blk_E ? next_blk_col :
                       (x < `WIDTH - `BOARD_HEIGHT || y < `HEIGHT - `BOARD_WIDTH) ? `GREY : `BLACK;
endmodule
