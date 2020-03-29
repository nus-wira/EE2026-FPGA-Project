`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/23/2020 02:54:58 PM
// Design Name: 
// Module Name: ball
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


module ball(
    input clk, E, rst,
    input [1:0] diff, //difficulty, change x velocity of ball
    input [6:0] x,y,ypad_left,ypad_right,
    output ball_on, p1_pt, p2_pt
    );
    localparam Width = 96;
    localparam Height = 64;
    localparam ballSize = 2;
    localparam padWidth = 2;
    localparam padHeight = 20;
    localparam xpad_left = 4;
    localparam xpad_right = 91;
    //  ball movement direction
    // dx = 1 -> right, dx = 0 -> left
    // dy = 1 -> down, dy = 0 -> up
    reg dx = 1,dy = 1;
    reg [1:0] st_state = 0;
    //  ball position
    reg [6:0] x_ball = Width/2, y_ball = Height/2;
    // ball velocity, start state
    wire [1:0] xvel;
    
    // To store booleans
    wire col_top, col_bot, restart;
    wire col_1_x, col_1_y, col_2_x, col_2_y;
    
    // x velocity of ball
    assign xvel = 1 + diff;
    
    // Collision Booleans to be used to change direction
    assign col_bot = dy && y_ball + ballSize + 1 == Height;
    assign col_top = ~dy && y_ball == ballSize;
    assign col_2_x = dx && x_ball + ballSize + xvel == xpad_right;
    assign col_2_y = y_ball <= ypad_right + padHeight/2 && // within bar
                     y_ball >= ypad_right - padHeight/2;
    assign col_1_x = ~dx && x_ball - ballSize - xvel == xpad_left;
    assign col_1_y = y_ball <= ypad_left + padHeight/2 && 
                     y_ball >= ypad_left - padHeight/2;
    // determine ball pass either side
    assign p1_pt = x_ball > xpad_right + padWidth;
    assign p2_pt = x_ball < xpad_left - padWidth;
    
    // Output boolean to render ball
    assign ball_on = x > x_ball - ballSize && x < x_ball + ballSize &&
                     y > y_ball - ballSize && y < y_ball + ballSize;
    
    // Restart in the middle
    assign restart = p1_pt || p2_pt || rst || !E;
    
    always @ (posedge clk) begin
        if (restart) begin
            // Start state 0 - 4. 0:up+right, 1: down+right, 2: up+left, 3:down+left
            // Sets direction of ball when restart
            st_state <= st_state + 1;
            x_ball <= Width/2;
            y_ball <= Height/2;
            dx <= st_state[0];
            dy <= st_state[1];
        end else begin
            // toggle y direction when at top or bottom
            dy <= col_top || col_bot ? ~dy : dy;
            // toggle x direction when hitting paddles
            dx <= col_2_x && col_2_y || col_1_x && col_1_y ? ~dx : dx;
            x_ball <= dx ? x_ball + xvel : x_ball - xvel;
            y_ball <= dy ? y_ball + 1 : y_ball - 1;
        end
        
    end
    
endmodule
