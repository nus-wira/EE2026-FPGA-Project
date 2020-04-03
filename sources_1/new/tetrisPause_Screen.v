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
    input clk, btnL, btnR, pause,
    input [2:0] game_state,
    input [`PIXELXYBIT:0] old_x, old_y,
    output [`OLEDBIT:0] oled_data,
    output reg [2:0] state = 3
    );
    
    // account for the rotation of screen
    wire [`PIXELXYBIT:0] x, y;
    assign x = 63 - old_y;
    assign y = old_x;
    
    wire gameOver, gamePause, resume, restart, yes, no, arrow1, arrow2, boxwidth, box1, box2;
    wire g, l, a, a1, a2, e, p, p1, u, s, e4, d, d1;
    wire lP, gP, aP;
    wire a3, e2, o1, v, e3, r1, excl;
    wire t, t1, t2, q2, r2, r3, a4, a5, Re2, Rs1, l2, Re;
    wire l3, Y, Y1, Y2, Ye, Ys;
    wire l4, n, o;
    wire [15:0] menudisp [3:0];
    
    //assign Booleans for GAME PAUSED
    assign lP = (y >= 45 && y <= 51);
    assign gP = (y == 45 || y == 51);
    assign aP = (y >= 48 && y <= 51);
    assign a1 = (x >= 10 && x <= 14);
    assign a2 = (x >= 33 && x <= 37);
    assign e = (x >= 22 && x <= 24);
    assign p1 = (x == 13 || x == 14);
    assign u = (y >= 45 && y <= 50);
    assign s = (x >= 44 && x <= 47);
    assign e4 = (x >= 50 && x <= 52);
    assign d = (x == 55 || x == 56);
    assign d1 = (y >= 46 && y <= 50);
    //assign Booleans for GAME OVER
    assign l = (y >= 17 && y <= 23);
    assign g = (y == 17 || y == 23);
    assign a = (y >= 20 && y <= 23);
    assign a3 = (x >= 13 && x <= 17);
    assign e2 = (x >= 25 && x <= 27);
    assign o1 = (y >= 18 && y <= 22);
    assign v = (y >= 17 && y <= 21);
    assign e3 = (x >= 45 && x <= 47);
    assign r1 = (x == 49 || x == 51 || x == 50);
    assign excl = (x == 55 && (y == 23 || (y >= 17 && y <= 21)));
    //assign Booleans for RESTART
    assign l2 = (y >= 41 && y <= 47);
    assign a4 = (x >= 31 && x <= 35);
    assign a5 = (y >= 44 && y <= 47);
    assign r2 = (x == 10 || x == 11 || x == 12);
    assign r3 = (x == 37 || x == 38 || x == 39);
    assign Re2 = (x >= 16 && x <= 18);
    assign Rs1 = (x >= 20 && x <= 23);
    assign t = (y >= 41 && y <= 47);
    assign t1 = (x >= 25 && x <= 29);
    assign t2 = (x >= 42 && x <= 46);
    assign q2 = ((x == 50 && (y == 41 || y == 42 || y == 44 || y == 45 || y == 47)) || ((x >= 51 && x <= 53) && (y == 44 || y == 41)) || ((y == 42 || y == 43) && x == 53));
    //assign Booleans for YES
    assign l3 = (y >= 57 && y <= 63);
    assign Y = ((x >= 27 && x <= 31) && y == 59);
    assign Y1 = ((y == 57 || y == 58) && (x == 27 || x == 31));
    assign Y2 = (y >= 60 && y <= 63 && x == 29);
    assign Ye = (x >= 34 && x <= 36);
    assign Ys = (x >= 38 && x <= 41);
    //assign Booleans for NO
    assign l4 = (y >= 72 && y <= 78);
    assign n = ((x == 28 && y == 74) || (y == 75 && x == 29) || (y == 76 && x == 30));
    assign o = (y >= 73 && y <= 77);
    
    // ARROWS
    assign arrow1 = (((y >= 58 && y <= 62) && x == 21) || (x == 22 && (y == 58 || y == 62))  || (x == 23 && (y == 59 || y == 61)) || (x == 24 && y == 60));
    assign arrow2 = (((y >= 73 && y <= 77) && x == 21) || (x == 22 && (y == 73 || y == 77))  || (x == 23 && (y == 74 || y == 76)) || (x == 24 && y == 75));
    
    // BOX
    assign boxwidth = (x >= 0 && x <= 95);
    assign box1 = (y >= 55 && y <= 65) && boxwidth && ~yes && ~arrow1;
    assign box2 = (y >= 70 && y <= 80) && boxwidth && ~no && ~arrow2;
    
    //////////////////////////////////////////////////////////////////
    /////////////////         PAUSE SCREEN          /////////////////
    ////////////////////////////////////////////////////////////////
        
   //GAME PAUSED
    assign gamePause = (((x == 4 && (y >= 46 && y <= 51)) || (gP && (x == 5 || x == 6)) || ((y == 46 || y == 50) && x == 7) || (x == 8 && (y == 50 || y == 51))) // G
                       || ((x == 13 && lP) || (x == 9 && aP) || (a1 && y == 48) || (x == 12 && y == 45) || (x == 11 && y == 46) || (x == 10 && y == 47)) //a
                       || ((lP && (x == 15 || x == 19)) || (y == 46 && (x == 16 || x == 18)) || (y == 47 && x == 17)) // m
                       || ((lP && x == 21) || (e && (y == 45 || y == 48 || y == 51))) // e
                       
                       || ((x == 28 && lP) || ((x == 30 || x == 29) && (y == 45 || y == 48)) || ((y == 46 || y == 47) && x == 31)) // P
                       || ((x == 37 && lP) || (x == 33 && aP) || (a2 && y == 48) || (x == 36 && y == 45) || (x == 35 && y == 46) || (x == 34 && y == 47)) //a
                       || ((u && (x == 39 || x == 42)) || ((x == 40 || x == 41) && y == 51)) // u
                       || (((y == 45 || y == 48 || y == 51) && s) || ((y == 46 || y == 47) && x == 44)) || ((y == 49 || y == 50) && x == 47)) // s
                       || (((lP && x == 49) || (e4 && (y == 45 || y == 48 || y == 51))))   // e
                       || ((lP && (x == 54)) || (d && (y == 45 || y == 51)) || (d1 && (x == 57))); //d
                       
     //////////////////////////////////////////////////////////////////
    /////////////////         RESTART SCREEN         /////////////////
   //////////////////////////////////////////////////////////////////
   
   // GAMEOVER
   assign gameOver = (((x == 7 && (y >= 18 && y <= 23)) || (g && (x == 8 || x == 9)) || ((y == 18 || y == 22) && x == 10) || (x == 11 && (y == 22 || y == 23)) // G
                      || ((x == 17 && l) || (x == 13 && a) || (a3 && y == 20) || (x == 16 && y == 17) || (x == 15 && y == 18) || (x == 14 && y == 19)) //a
                      || ((l && (x == 19 || x == 23)) || (y == 18 && (x == 20 || x == 22)) || (y == 19 && x == 21)) // m
                      || ((l && x == 25) || (e2 && (y == 17 || y == 20 || y == 23)))) // e
                      
                      || ((o1 && (x == 32 || x == 36)) || ((y == 17 || y == 23) && (x == 34 || x == 35 || x == 33))) // o
                      || ((v && (x == 38 || x == 42)) || (x == 39 && y == 22) || (x == 40 && y == 23) || (x == 41 && y == 22)) // v
                      || ((l && x == 44) || (e3 && (y == 17 || y == 20 || y == 23)))// e
                      || ((x == 49 && l) || ((y == 17 || y == 20) && r1) || ((y == 18 || y == 19) && x == 51) || (x == 50 && y == 21) || (x == 51 && y == 22) || (x == 52 && y == 23)) // r
                      || excl); // !
                         
   // RESTART                 
  assign restart = (((x == 10 && l2) || ((y == 41 || y == 44) && r2) || ((y == 42 || y == 43) && x == 12) || (x == 11 && y == 45) || (x == 12 && y == 46) || (x == 13 && y == 47)) //r;
           || (((l2 && x == 15) || (Re && (y == 41 || y == 44 || y == 47)))) // e
           || (((y == 41 || y == 44 || y == 47) && Rs1) || ((y == 42 || y == 43) && x == 20) || ((y == 45 || y == 46) && x == 23)) // s
           || ((t1 && y == 41) || (t && x == 27)) // t
           || (x == 35 && l2) || (x == 31 && a5) || (a4 && y == 44) || (x == 34 && y == 41) || (x == 33 && y == 42) || (x == 32 && y == 43)) // a
           || ((((x == 37 && l2) || ((y == 41 || y == 44) && r3) || ((y == 42 || y == 43) && x == 39) || (x == 38 && y == 45) || (x == 39 && y == 46) || (x == 40 && y == 47))) // r
           || ((t2 && y == 41) || (t && x == 44)) // t
           || q2); // ?

    // YES
    assign yes = ((Y2 || Y1 || Y) // y
                 || ((l3 && x == 33) || (Ye && (y == 57 || y == 60 || y == 63))) // e
                 || (((y == 57 || y == 60 || y == 63) && Ys) || ((y == 58 || y == 59) && x == 38) || ((y == 61 || y == 62) && x == 41))); //s
    
    // NO        
    assign no = (((l4 && (x == 27 || x == 31)) || n) // n
                || (o && (x == 33 || x == 37) || ((y == 72 || y == 78) && (x == 34 || x == 35 || x == 36)))); // o
    
    //MENU display for respective states
    assign menudisp[0] = (gamePause);
    assign menudisp[1] = (gameOver || restart || yes || no);
    assign menudisp[2] = (gameOver || restart || box1 || no);
    assign menudisp[3] = (gameOver || restart || yes || box2); 
    
    assign oled_data = pause ? (gamePause ? `WHITE : `BLACK) : menudisp[state] ? `WHITE : `BLACK;
    
    always @ (posedge clk) begin
        state <= btnL && state != 1 ? state - 1 : btnR && state != 3 ? state + 1 : state;
    end
        
endmodule
