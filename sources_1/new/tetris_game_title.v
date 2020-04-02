`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.04.2020 13:15:52
// Design Name: 
// Module Name: tetris_game_title
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


module tetris_game_title(
    input [`PIXELXYBIT:0] old_x, old_y,
    output tetris
    );
    wire [`PIXELXYBIT:0] x, y;
    wire t, t1, e, e1, r, s;
    
    assign x = 63 - old_y;
    assign y = old_x;
    
    // ASSIGN BOOLEANS
    assign t = (x >= 17 && x <= 21);
    assign t1 = (y >= 5 && y <= 11);
    assign e = (y >= 23 && y <= 26);
    assign e1 = (x >= 23 && x <= 27);
    assign r = (x == 34 || x == 35 || x == 36);
    assign s = (x >= 41 && x <= 44);
    
    assign tetris = (((t && y == 5) || (t1 && x == 19)) // t
                    || (((t1 && x == 23) || (e && (y == 5 || y == 8 || y == 11))))   // e
                    || (((x >= 28 && x <= 32) && y == 5) || (t1 && x == 30)) // t
                    || ((x == 34 && t1) || ((y == 5 || y == 8) && r) || ((y == 6 || y == 7) && x == 36) || (x == 35 && y == 9) || (x == 36 && y == 10) || (x == 37 && y == 11))// r
                    || (x == 39 && t1)// i
                    || (((y == 5 || y == 11 || y == 8) && s) || ((y == 9 || y == 10) && x == 44)) || ((y == 6 || y == 7) && x == 41)); // s
endmodule
