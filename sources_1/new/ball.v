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
    input clk,
    input [6:0] x,y,ypad_left,ypad_right,
    output ball_on // boolean to have ball on
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
    //  ball position
    reg [6:0] x_ball = Width/2, y_ball = Height/2;
    
    // To store booleans
    wire col_top, col_bot;
    wire col_1_x, col_1_y, col_2_x, col_2_y;
    wire p1_pt, p2_pt;
    
    // Collision Booleans to be used to change direction
    assign col_top = y_ball + ballSize == Height;
    assign col_bot = y_ball == ballSize;
    assign col_2_x = x_ball + ballSize == xpad_right;
    assign col_2_y = y_ball < ypad_right + padHeight/2 && // within bar
                     y_ball > ypad_right - padHeight/2;
    assign col_1_x = x_ball - ballSize == xpad_left;
    assign col_1_y = y_ball < ypad_left + padHeight/2 && 
                     y_ball > ypad_right - padHeight/2;
    assign p1_pt = x_ball > xpad_right + padWidth;
    assign p2_pt = x_ball < xpad_left - padWidth;
    
    // Output boolean to render ball
    assign ball_on = x > x_ball - ballSize && x < x_ball + ballSize &&
                     y > y_ball - ballSize && y < y_ball + ballSize;
    
    always @ (posedge clk) begin
        // toggle y direction when at top or bottom
        dy <= col_top || col_bot ? ~dy : dy;
        // toggle x direction when hitting paddles
        dx <= col_2_x && col_2_y || col_1_x && col_1_y ? ~dx : dx;
        
        if (p1_pt || p2_pt) begin
            x_ball <= Width/2;
            y_ball <= Height/2;
        end else begin
            x_ball <= dx ? x_ball + 1 : x_ball - 1;
            y_ball <= dy ? y_ball + 1 : y_ball - 1;
        end
        
    end
    
endmodule
