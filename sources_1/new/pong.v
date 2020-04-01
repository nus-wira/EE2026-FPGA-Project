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
    input clk, clkseg, btnU, btnD, btnR, flag,
    input [2:0] sw,
    input [`PIXELXYBIT:0] x, y,
    input [3:0] num,
    output [`OLEDBIT:0] oled_data,
    output [`ANBIT:0] an,
    output [`SEGDPBIT:0] seg
    );
    // Paddle positions (centre)
    wire [`PIXELXYBIT:0] userPaddleX, userPaddleY, audioPaddleX, audioPaddleY;
    // Paddle/ball appear booleans                    player point add
    wire userPaddleAppear, audioPaddleAppear, ball_on, p1_pt, p2_pt;
    wire [`COLBIT:0] userPaddle_col, audioPaddle_col;
    wire [`ANBIT:0] an_init, an_score;
    wire [`SEGDPBIT:0] seg_init, seg_score;
    wire E;
    
    // Only start when in correct mode
    assign E = sw[0] && flag;
    
    airHockeyPaddles a0(.btnU(btnU), .btnD(btnD), .clkPaddle(clk), .sw(E), .rst(btnR),
                        .x(x), .y(y),.num(num),
                        .userPaddleAppear(userPaddleAppear), .audioPaddleAppear(audioPaddleAppear),  
                        .userPaddleX(userPaddleX), .userPaddleY(userPaddleY), 
                        .audioPaddleX(audioPaddleX), .audioPaddleY(audioPaddleY),
                        .userPaddle_col(userPaddle_col), .audioPaddle_col(audioPaddle_col));
    ball b0 (.clk(clk), .E(E), .rst(btnR), .diff(sw[2:1]), .x(x),.y(y), .ypad_left(userPaddleY),.ypad_right(audioPaddleY), 
             .ball_on(ball_on), .p1_pt(p1_pt), .p2_pt(p2_pt) );
    score s0 (.clk(clk), .clkseg(clkseg), .p1_pt(p1_pt), .p2_pt(p2_pt), .E(E), .rst(btnR), .an(an_score), .seg(seg_score));
    initpong i0 (clkseg, an_init, seg_init);
    
    assign an = E ? an_score : an_init;
    assign seg = E ? seg_score : seg_init;
    
    // oled_data using booleans (determined with x and y inputs)
    assign oled_data = userPaddleAppear ? userPaddle_col : audioPaddleAppear ? audioPaddle_col :
                       ball_on ? `WHITE : `BLACK;
endmodule
