`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.03.2020 14:22:46
// Design Name: 
// Module Name: airHockeyPaddles
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

module airHockeyPaddles(
    input btnU, btnD, clkPaddle, sw15, rst,
    input [6:0] x, y,
    input [3:0] num,
    output userPaddleAppear, audioPaddleAppear,  
    output reg [6:0] userPaddleX, userPaddleY, audioPaddleX, audioPaddleY,
    output [15:0] userPaddle_col, audioPaddle_col
    );
    // Display size of Oled
    localparam Width = 96;
    localparam Height = 64;
    // Paddle size
    localparam paddleHeight = 20;
    localparam paddleWidth = 3;
    // other sizing
    localparam border = 3; // distance from edge
    localparam pixelMove = 6; // each button press/in(de)crease in vol corresponds to the paddles moving by 3 pixels
    localparam audioMove = 3; // pixel distance each volume level (0-15)
    // Colours for paddles
    parameter [15:0] RED = 16'b11111_000000_00000;
    parameter [15:0] BLUE = 16'b00000_000000_11111;
    
    //assign initial position of audioPaddle
    reg [6:0] audioPaddleInitial = Height - paddleHeight/2;
    
    //Booleans
    wire [3:0] UP;
    wire [3:0] AP;
    assign UP[0] = x >= userPaddleX - (paddleWidth/2);
    assign UP[1] = x <= userPaddleX + (paddleWidth/2);
    assign UP[2] = y >= userPaddleY - (paddleHeight/2);
    assign UP[3] = y <= userPaddleY + (paddleHeight/2);
    assign AP[0] = x >= audioPaddleX - (paddleWidth/2);
    assign AP[1] = x <= audioPaddleX + (paddleWidth/2);
    assign AP[2] = y >= audioPaddleY - (paddleHeight/2);
    assign AP[3] = y <= audioPaddleY + (paddleHeight/2);
    
    initial begin
        userPaddleX = border;
        userPaddleY = Height/2;
        audioPaddleX = Width - border - 1;
        audioPaddleY = Height/2;
    end
    
    // Audio Paddle positioning
    wire [6:0] nextAudioY;
    assign nextAudioY = audioPaddleInitial - audioMove * num;
    
    // User's Paddle
    always @ (posedge clkPaddle) begin
        if (rst || !sw15) begin
            userPaddleY <= Height/2;
            audioPaddleY <= Height/2;
        end else begin
            // Audio Paddle
            audioPaddleY <= nextAudioY >= paddleHeight/2 ? nextAudioY : paddleHeight/2;
            // User Paddle
            if (btnU)
                //prevent from going out of bounds
                userPaddleY <= userPaddleY - paddleHeight/2 < pixelMove ? paddleHeight/2 : userPaddleY - pixelMove;
            else if (btnD)
                userPaddleY <= userPaddleY + paddleHeight/2 + pixelMove >= Height ? 
                               Height - 1 - paddleHeight/2 : userPaddleY + pixelMove;
        end
    end
    
    // Turning on the user's paddle
    // only true when all bits of UP are 1
    assign userPaddleAppear = !(~UP);
    // assigning colour to user's paddle
    assign userPaddle_col = RED; 
    
    // Turning on the audio paddle
    // only true when all bits of AP are 1
    assign audioPaddleAppear = !(~AP);
    // assigning colour to audio paddle
    assign audioPaddle_col = BLUE;    
    
endmodule
