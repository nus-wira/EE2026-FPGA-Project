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


module tetris_logic(E, clk,btnCLK,rst,mvD,mvDrop, mvL, mvR, mvRot, board, cur_blk1, cur_blk2, cur_blk3);
    localparam Width = 10;
    localparam Height = 20;
    
    
    // Clock, movement buttons, rotation clockwise
    input E, clk, btnCLK, rst, mvD, mvDrop, mvL, mvR, mvRot;
    // Keeps track of board's fallen pieces
    output reg [Width*Height-1:0] board = 0;
    // Each square of a block as a position on the board (pos = x+y*10)
    output [8:0] cur_blk1, cur_blk2, cur_blk3;
    
    // Current falling block type
    reg cur_blk = 0;
    // Rotation direction of block - 0: 0 deg, 1: 90 deg etc.
    reg [1:0] cur_rot = 0;
    // x,y coordinates of block
    reg [4:0] cur_x = Width/2, cur_y = Height - 1;
    
    // Width and height of a cur_blk, to keep track of boundaries
    // based on type and rotation
    wire [2:0] cur_width, cur_height;
    
    // Game clock using modified clock_divider
    wire gameCLK;
    game_clock c0(btnCLK, gameCLK);
    
    // Keep track of whether initializing/playing/shifting rows
    reg [1:0] mode = 0;
        
    // Using block type, rotation, position, calculate block locations + width/height
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
    
    // Get test data into similar wires to get block locations + width/height
    wire [8:0] test_blk1, test_blk2, test_blk3;
    wire [2:0] test_width, test_height;
    calc_cur_blk calc_test1 (cur_blk, test_rot, test_x, test_y, test_blk1, test_blk2,test_blk3, test_width, test_height);
    
    // Check whether test_blk above intersects with current fallen blocks
    wire check_intersect;
    assign check_intersect = board[test_blk1] || board[test_blk2] || board[test_blk3];
    
    // Check which row is full
    wire [4:0] remove_row; // row to remove
    wire remove_en;
    full_row f0 (clk, board, remove_row, remove_en);
    reg [4:0] shift_row; // needed to remove row by row
    
    reg [4:0] drop = 0;
    
    // game is over if new block intersects
    wire game_over;
    assign game_over = cur_y == Height - 1 && (board[cur_blk1] || board[cur_blk2] || board[cur_blk3]);
    
    
    
    always @ (posedge btnCLK) begin
        if (rst || !E) mode <= 0;
        else
        case (mode)
        0: begin // Initialize
            board <= 0;
            cur_x <= Width/2;
            cur_y <= Height - 1;
            mode <= 1;
        end 
        1: begin // Play
            if (game_over)
                mode <= 3;
            if (remove_en) begin // check for row to remove first
                mode <= 2;
                shift_row <= remove_row;
            end else if (mvD && mvDrop) // If want to drop block
                drop <= Height;
            else if (mvD || gameCLK || drop) begin // Normal down movement at gameCLK
                if (cur_y >= cur_height && !check_intersect) begin
                    // Move down
                    cur_y <= cur_y - 1;
                    drop <= drop ? drop - 1 : drop; 
                end else begin
                    // Intersects with next move so add to board
                    board[cur_blk1] <= 1;
                    board[cur_blk2] <= 1;
                    board[cur_blk3] <= 1;
                    // add next block
                    cur_blk <= cur_blk + 1;
                    cur_rot <= 0;
                    cur_x <= Width/2;
                    cur_y <= Height - 1;
                    drop <= 0;
                end
            end else if (mvL && cur_x > 0 && !check_intersect)
                // Move left
                cur_x <= cur_x - 1;
            else if (mvR && cur_x + cur_width < Width && !check_intersect)
                // Move right
                cur_x <= cur_x + 1;
            else if (mvRot && cur_x + test_width <= Width &&
                     cur_y >= test_height && !check_intersect)
                // Rotate
                cur_rot <= cur_rot + 1;

        end
        2: begin // Remove row
            if (shift_row == Height - 1) begin
                board[shift_row*Width +: Width] <= 0;
                mode <= 1;
            // When deleting full row must shift all above it down
            end else begin
                board[shift_row*Width +: Width] <= board[(shift_row+1)*Width +: Width];
                shift_row <= shift_row + 1;
            end
        end
        3: mode <= 0; // for now just restart when game_over
        endcase
        
    end
    
endmodule
