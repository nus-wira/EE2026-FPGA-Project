`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.04.2020 14:20:33
// Design Name: 
// Module Name: tetrisPause_Screen
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


module tetrisPause_Screen(
    input clk, btnL, btnR, sw1,
    input [`PIXELXYBIT:0] x, y,
    output reg [`OLEDBIT:0] oled_data,
    output reg [2:0] state
    );
    
    wire gameOver, gamePause, resume, restart, yes, no, arrow1, arrow2, boxwidth, box1, box2;
    wire g, l, a, a1, a2, e, p, p1, u, s, d, d1;
    wire l2, r, Re, Ru, Rs;
    wire [15:0] menudisp [5:0];
    
    //assign Booleans for GAME PAUSED
    assign l = (y >= 17 && y <= 23);
    assign g = (y == 17 || y == 23);
    assign a = (y >= 20 && y <= 23);
    assign a1 = (x >= 10 && x <= 14);
    assign a2 = (x >= 33 && x <= 37);
    assign e = (x >= 22 && x <= 24);
    assign p1 = (x == 13 || x == 14);
    assign u = (y >= 17 && y <= 22);
    assign s = (x >= 44 && x <= 47);
    assign d = (x == 55 || x == 56);
    assign d1 = (y >= 18 && y <= 22);
    
    //assign Booleans for RESUME
    assign l2 = (x >= 41 && x <= 47);
    assign r = (x == 13 || x == 14 || x == 15);
    assign Re = (x >= 19 && x <= 21);
    assign Ru = (y >= 41 && y <= 46);
    assign Rs = (x >= 23 && x <= 26);
    
    //assign Booleans for YES
    
    //assign Booleans for NO
    
    
    // ARROWS
    assign arrow1 = (((y >= 58 && y <= 62) && x == 21) || (x == 22 && (y == 58 || y == 62))  || (x == 23 && (y == 59 || y == 61)) || (x == 24 && y == 60));
    assign arrow2 = (((y >= 73 && y <= 77) && x == 21) || (x == 22 && (y == 73 || y == 77))  || (x == 23 && (y == 74 || y == 76)) || (x == 24 && y == 75));
    
    // BOX
    assign boxwidth = (x >= 0 && x <= 95);
    assign box1 = (y >= 55 && y <= 65) && boxwidth && ~yes && ~arrow1;
    assign box2 = (y >= 70 && y <= 80) && boxwidth && ~no && ~arrow2;
        
   //GAME PAUSED
    assign gamePause = (((x == 4 && (y >= 18 && y <= 23)) || (g && (x == 5 || x == 6)) || ((y == 18 || y == 22) && x == 7) || (x == 8 && (y == 22 || y == 23))) // G
                       || ((x == 13 && l) || (x == 9 && a) || (a1 && y == 20) || (x == 12 && y == 17) || (x == 11 && y == 18) || (x == 10 && y == 19)) //a
                       || ((l && (x == 15 || x == 19)) || (y == 18 && (x == 16 || x == 18)) || (y == 19 && x == 17)) // m
                       || ((l && x == 21) || (e && (y == 17 || y == 20 || y == 23))) // e
                       
                       || ((x == 28 && l) || ((x == 30 || x == 29) && (y == 17 || y == 20)) || ((y == 18 || y == 19) && x == 31)) // P
                       || ((x == 37 && l) || (x == 33 && a) || (a2 && y == 20) || (x == 36 && y == 17) || (x == 35 && y == 18) || (x == 34 && y == 19)) //a
                       || ((u && (x == 39 || x == 42)) || ((x == 40 || x == 41) && y == 23)) // u
                       || (((y == 17 || y == 20 || y == 23) && s) || ((y == 18 || y == 19) && x == 44)) || ((y == 21 || y == 22) && x == 47)) // s
                       || (((l && x == 49) || (e && (y == 17 || y == 20 || y == 23))))   // e
                       || ((l && (x == 54)) || (d && (y == 17 || y == 23)) || (d1 && (x == 57))); //d
    // RESUME                  
    assign = ((((x == 13 && l2) || ((y == 41 || y == 44) && r) || ((y == 42 || y == 43) && x == 15) || (x == 14 && y == 45) || (x == 15 && y == 46) || (x == 16 && y == 47)) //r;
             || (((l && x == 49) || (e && (y == 17 || y == 20 || y == 23)))) // e
             || (((y == 17 || y == 20 || y == 23) && s) || ((y == 18 || y == 19) && x == 44)) || ((y == 21 || y == 22) && x == 47)) // s
             || ((u && (x == 39 || x == 42)) || ((x == 40 || x == 41) && y == 23)) // u
             || ((l && (x == 15 || x == 19)) || (y == 18 && (x == 16 || x == 18)) || (y == 19 && x == 17)) // m
             || ((l && x == 21) || (e && (y == 17 || y == 20 || y == 23)))) // e
             
    
    //MENU display for respective states
    assign menudisp[0] = (gamePause || resume || yes || no);
    assign menudisp[1] = (gamePause || resume || box1 || no);
    assign menudisp[2] = (gamePause || resume || yes || box2); 
    assign menudisp[3] = (gameOver || resume || yes || no);
    assign menudisp[4] = (gameOver || resume || box1 || no);
    assign menudisp[5] = (gameOver || resume || yes || box2); 
    
    always @ (posedge clk) begin
        state <= btnL && state != 0 ? state - 1 : btnR && state != 5 ? state + 1 : state;
    end
        
    always @ (*) begin
        if(sw1)
           oled_data = menudisp[state] ? `BLACK : `WHITE;
        else
           oled_data = menudisp[state] ? `WHITE : `BLACK; 
    end
endmodule
