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
`include "definitions.vh"

module tetris_logic(
    // Clock, movement buttons, rotation clockwise
    input E, clk, btnCLK, rst, mvD, mvDrop, mvL, mvR, mvRot,
    // Keeps track of board's fallen pieces
    output reg [`TRIS_SIZE-1:0] board = 0,
    // Each square of a block as a position on the board (pos = x+y*10)
    output [8:0] cur_blk1, cur_blk2, cur_blk3, cur_blk4,
    // Block colour
    output reg [`COLBIT:0] blk_col
    );
    
    // Current falling block type
    reg [2:0] cur_blkType = 0;
    wire [2:0] rand_blk; // random new block to assign cur_blk to
    
    // Rotation direction of block - 0: 0 deg, 1: 90 deg etc.
    reg [1:0] cur_rot = 0;
    // x,y coordinates of block
    reg [4:0] cur_x = `TRIS_WIDTH/2, cur_y = `TRIS_HEIGHT - 1;
    
    // Width and height of a cur_blk, to keep track of boundaries
    // based on type and rotation
    wire [2:0] cur_width, cur_height;
    
    // Game clock using modified clock_divider
    wire gameCLK;
    game_clock c0(btnCLK, gameCLK);
    
    // Keep track of whether initializing/playing/shifting rows
    reg [1:0] mode = `MODE_INIT;
        
    // Using block type, rotation, position, calculate block locations + width/height
    calc_cur_blk calc_cur0 (cur_blkType, cur_rot, cur_x, cur_y, cur_blk1, cur_blk2, cur_blk3, cur_blk4, cur_width, cur_height);
    // Assign block colour according to block type
    always @ (*) begin
        case (cur_blkType)
        `I: blk_col = `RED;
        `L: blk_col = `BLUE;
        `J: blk_col = `ORANGE;
        `O: blk_col = `GREEN;
        `S: blk_col = `CYAN;
        `T: blk_col = `YELLOW;
        `Z: blk_col = `MAGENTA;
        endcase
    end
    
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
    wire [8:0] test_blk1, test_blk2, test_blk3, test_blk4;
    wire [2:0] test_width, test_height;
    calc_cur_blk calc_test1 (cur_blkType, test_rot, test_x, test_y, test_blk1, test_blk2,test_blk3, test_blk4, test_width, test_height);
    
    // Check whether test_blk above intersects with current fallen blocks
    wire check_intersect;
    assign check_intersect = board[test_blk1] || board[test_blk2] || board[test_blk3] || board[test_blk4];
    
    // Check which row is full
    wire [4:0] remove_row; // row to remove
    wire remove_en;
    full_row f0 (clk, board, remove_row, remove_en);
    reg [4:0] shift_row; // needed to remove row by row
    
    // To make sure when pressing drop, it drops to the bottom
    // Set drop to 1, then keep moving it down until
    // check_intersect becomes true
    reg drop = 0;
    
    // randE set to enable whenever new block is needed
    reg randE = 0;
    // new block in rand_blk
    rng rng0(clk, randE, 2'd2, rand_blk);
    
    // game is over if new block intersects
    wire game_over;
    assign game_over = cur_y == `TRIS_HEIGHT - 1 && (board[cur_blk1] || board[cur_blk2] || board[cur_blk3] || board[cur_blk4]);

 
    always @ (posedge btnCLK) begin
        if (rst || !E) mode <= 0;
        else
        case (mode)
        `MODE_INIT: begin // Initialize
            board <= 0;
            cur_x <= `TRIS_WIDTH/2;
            cur_y <= `TRIS_HEIGHT - 1;
            mode <= `MODE_PLAY;
        end 
        `MODE_PLAY: begin // Play
            if (game_over) // check for game over first
                mode <= `MODE_IDLE;
            else if (remove_en) begin // then check for row to remove first
                mode <= `MODE_SHIFT;
                shift_row <= remove_row;
            end else if (mvD && mvDrop) // If want to drop block
                drop <= 1;
            else if (mvD || gameCLK || drop) begin // Normal down movement at gameCLK
                if (cur_y >= cur_height && !check_intersect) begin
                    randE <= 0; // reset random block enable
                    // Move down
                    cur_y <= cur_y - 1;
                    // drop <= drop ? drop - 1 : drop;
                end else begin
                    randE <= 1; // set random block enable
                    // Intersects with next move so add to board
                    board[cur_blk1] <= 1;
                    board[cur_blk2] <= 1;
                    board[cur_blk3] <= 1;
                    board[cur_blk4] <= 1;
                    // add next block
                    cur_blkType <= rand_blk;
                    cur_rot <= 0;
                    cur_x <= `TRIS_WIDTH/2;
                    cur_y <= `TRIS_HEIGHT - 1;
                    drop <= 0; // reset drop used for mvDrop
                end
            end else if (mvL && cur_x > 0 && !check_intersect) // Move left
                cur_x <= cur_x - 1;
            else if (mvR && cur_x + cur_width < `TRIS_WIDTH && !check_intersect) // Move right
                cur_x <= cur_x + 1;
            else if (mvRot && cur_x + test_width <= `TRIS_WIDTH &&
                     cur_y >= test_height && !check_intersect) // Rotate
                cur_rot <= cur_rot + 1;
        end
        `MODE_SHIFT: begin // Remove row
            if (shift_row == `TRIS_HEIGHT - 1) begin // when shift_row reaches top
                board[shift_row*`TRIS_WIDTH +: `TRIS_WIDTH] <= 0; // set top to 0
                mode <= `MODE_PLAY; // go back to Play mode
            // When deleting full row must shift all above it down
            end else begin
                // set shifting row to row above it
                board[shift_row*`TRIS_WIDTH +: `TRIS_WIDTH] <= board[(shift_row+1)*`TRIS_WIDTH +: `TRIS_WIDTH];
                shift_row <= shift_row + 1;
            end
        end
        `MODE_IDLE: mode <= `MODE_INIT; // for now just restart when game_over
        endcase
        
    end
    
endmodule
