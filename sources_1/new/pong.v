`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/26/2020 10:00:12 PM
// Design Name: 
// Module Name: pong
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


module pong(
    input clk, sw, btnU, btnD, btnR,
    input [6:0] x, y,
    input [3:0] num,
    output [15:0] oled_data,
    output [3:0] an,
    output [7:0] seg
    );
    parameter [15:0] BLACK = 16'b0;
    parameter [15:0] WHITE = ~BLACK;
    // Paddle positions (centre)
    wire [6:0] userPaddleX, userPaddleY, audioPaddleX, audioPaddleY;
    // Paddle/ball appear booleans                    player point add
    wire userPaddleAppear, audioPaddleAppear, ball_on, p1_pt, p2_pt;
    // Paddle colours
    wire [15:0] userPaddle_col, audioPaddle_col;
    
    airHockeyPaddles a0(.btnU(btnU), .btnD(btnD), .clkPaddle(clk), .sw15(sw), .rst(btnR),
                        .x(x), .y(y),.num(num),
                        .userPaddleAppear(userPaddleAppear), .audioPaddleAppear(audioPaddleAppear),  
                        .userPaddleX(userPaddleX), .userPaddleY(userPaddleY), 
                        .audioPaddleX(audioPaddleX), .audioPaddleY(audioPaddleY),
                        .userPaddle_col(userPaddle_col), .audioPaddle_col(audioPaddle_col));
    ball b0 (.clk(clk), .rst(btnR), .x(x),.y(y), .ypad_left(userPaddleY),.ypad_right(userPaddleX), 
             .ball_on(ball_on), .p1_pt(p1_pt), .p2_pt(p2_pt) );
    score s0 (.clk(clk), .p1_pt(p1_pt), .p2_pt(p2_pt), .rst(btnR), .an(an), .seg(seg));
    
    // oled_data using booleans (determined with x and y inputs)
    assign oled_data = userPaddleAppear ? userPaddle_col : audioPaddleAppear ? audioPaddle_col :
                       ball_on ? WHITE : BLACK;
endmodule