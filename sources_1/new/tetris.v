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


module tetris(
    input clk, btnCLK, rst, btnD, btnL, btnR, btnU,
    input [6:0] x,y,
    output [15:0] oled_data
    );
    localparam Width = 10;
    localparam Height = 20;
    
    wire [199:0] board;
//    wire [2:0] cur_blk;
//    wire [1:0] cur_rot;
//    wire [4:0] cur_x, cur_y;
    wire [8:0] cur_blk1, cur_blk2, cur_blk3;
    wire [4:0] x1,y1,x2,y2,x3,y3;
    wire [15:0] oled_blk1, oled_blk2, oled_blk3, oled_board;
    
    tetris_logic tet0(.clk(clk),.btnCLK(btnCLK),.rst(rst),.mvD(btnD),.mvL(btnL), .mvR(btnR), .mvRot(btnU), 
                 .board(board), .cur_blk1(cur_blk1), .cur_blk2(cur_blk2), .cur_blk3(cur_blk3));
    assign x1 = cur_blk1 % Width;
    assign y1 = cur_blk1 / Width;
    assign x2 = cur_blk2 % Width;
    assign y2 = cur_blk2 / Width;
    assign x3 = cur_blk3 % Width;
    assign y3 = cur_blk3 / Width;
    convertTetris_xy xy1( x1,y1, x, y, oled_blk1);
    convertTetris_xy xy2( x2,y2, x, y, oled_blk2);
    convertTetris_xy xy3( x3,y3, x, y, oled_blk3);
    boardXYconversion b0(board, x, y,oled_board);
    assign oled_data = //oled_board ? oled_board : 
                       oled_blk1 ? oled_blk1 : 
                       oled_blk2 ? oled_blk2 :  `BLACK;
endmodule
