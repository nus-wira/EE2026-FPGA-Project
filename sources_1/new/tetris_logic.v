`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/30/2020 02:55:16 PM
// Design Name: 
// Module Name: tetris_logic
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


module tetris_logic(clk,btnCLK,rst,mvD,mvL, mvR, mvRot, board, cur_blk1, cur_blk2, cur_blk3);
    localparam Width = 10;
    localparam Height = 20;
    
    
    // Clock, movement buttons, rotation clockwise
    input clk, btnCLK, rst, mvD, mvL, mvR, mvRot;
    // Keeps track of board's fallen pieces
    output reg [Width*Height-1:0] board = 0;
    // Current falling block type
    reg cur_blk = 0;
    // Rotation direction of block - 0: 0 deg, 1: 90 deg etc.
    reg [1:0] cur_rot = 0;
    // x,y coordinates of block
    reg [4:0] cur_x = Width/2, cur_y = Height - 1;
    
    output [8:0] cur_blk1, cur_blk2, cur_blk3;
    
    wire gameCLK;
//    clk_divider c0(btnCLK, 6'd49, gameCLK);
    game_clock c0(btnCLK, gameCLK);
    
    reg [1:0] mode = 0;
    
    // Each square of a block as a position on the board (pos = x+y*10)
//    wire [8:0] cur_blk1, cur_blk2, cur_blk3, cur_blk4;
    // Width and height of a cur_blk, to keep track of boundaries
    // based on type and rotation
    wire [2:0] cur_width, cur_height;
    
    // Using block type, rotation, position, calculate wires above
    calc_cur_blk calc_cur0 (cur_blk, cur_rot, cur_x, cur_y, cur_blk1, cur_blk2, cur_blk3, cur_width, cur_height);
    
    // Wires to test a next state of block
    wire [1:0] test_rot;
    wire [4:0] test_x, test_y;
    // Test positions of next state, will check validity in main logic
    calc_test_blk calc_test0 (
        .btnCLK(btnCLK),.mvD(mvD), .mvL(mvL), .mvR(mvR), .mvRot(mvRot),
        .cur_x(cur_x), .cur_y(cur_y), .cur_rot(cur_rot),
        .test_x(test_x), .test_y(test_y), .test_rot(test_rot)
    );
    
    // Get test data into similar wires
    wire [8:0] test_blk1, test_blk2, test_blk3;
    wire [2:0] test_width, test_height;
    calc_cur_blk calc_test1 (cur_blk, test_rot, test_x, test_y, test_blk1, test_blk2,test_blk3, test_width, test_height);
    
    // Check whether test_blk above intersects with current fallen blocks
    wire check_intersect;
    assign check_intersect = board[test_blk1] || board[test_blk2] || board[test_blk3];
    
    // Check which row is full
    wire [4:0] remove_row;
    wire remove_en;
    full_row f0 (clk, board, remove_row, remove_en);
    
    // game is over if new block intersects
    wire game_over;
    assign game_over = cur_y == Height - 1 && (board[cur_blk1] || board[cur_blk2] || board[cur_blk3]);
    
    always @ (posedge btnCLK) begin
        if (rst) mode <= 0;
        else
        case (mode)
        0: begin
//        if (rst) begin
            board <= 0;
            cur_x <= Width/2;
            cur_y <= Height - 1;
            mode <= 1;
        end 
        1: begin
//            if (game_over)
//                mode <= 3;
            if (mvL && cur_x > 0 && !check_intersect)
                // Move left
                cur_x <= cur_x - 1;
            else if (mvR && cur_x + cur_width < Width && !check_intersect)
                // Move right
                cur_x <= cur_x + 1;
            else if (mvRot && cur_x + test_width < Width &&
                     cur_y >= test_height && !check_intersect)
                // Rotate
                cur_rot <= cur_rot + 1;
            else if ((mvD || gameCLK) && cur_y >= cur_height && !check_intersect)
                // Move down
                cur_y <= cur_y - 1;
            else if (check_intersect || cur_y < cur_height) begin 
                // Intersects with next move so add to board
                board[cur_blk1] <= 1;
                board[cur_blk2] <= 1;
                board[cur_blk3] <= 1;
                // add next block
//                cur_blk <= cur_blk + 1;
//                cur_rot <= 0;
//                cur_x <= 2;
//                cur_y <= Height - 1;
                
            end
        end
        2: begin // When deleting full row must shift all down
            if (remove_row == Height - 1) begin
                board[remove_row*Width +: Width] <= 0;
                mode <= 1;
            end else
                board[remove_row*Width +: Width] <= board[remove_row*Width +: Width];
        end
        3: mode <= 0; // for now just restart when game_over
        endcase
            
        
        
    end
    
endmodule
