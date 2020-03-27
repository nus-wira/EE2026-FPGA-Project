`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.03.2020 16:48:03
// Design Name: 
// Module Name: menuGUI
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


module menuGUI(
    input [6:0] x, y, 
//    input [2:0] state,
    output reg [15:0] oled_data
    );
    parameter [15:0] BLACK = 16'b0;
    parameter [15:0] WHITE = ~BLACK;
    
    wire menuLength;
    wire [6:0] menuX;
    wire v, o, l, u, e, b, a, a1, r, w, Wa, Wa1, Wa2, Wv, We, E;
    wire p, p1, g, arrow1, arrow2, arrow3, arrow4;
    wire menu, volbar, pingpong, wave;
    
    // Booleans
    assign menuLength = (y >= 3 && y <= 16);
    assign menuX[0] = (x == 26 || x == 27);
    assign menuX[1] = (x == 38 || x == 39);
    assign menuX[2] = (x == 42 || x == 43);
    assign menuX[3] = (x == 52 || x == 53);
    assign menuX[4] = (x == 60 || x == 61);
    assign menuX[5] = (x == 64 || x == 65);
    assign menuX[6] = (x == 70 || x == 71);
    assign E = (x >= 44 && x <= 49);
    
    assign v = (y >= 22 && y <= 26);
    assign o = (y >= 23 && y <= 27);
    assign l = (y >= 22 && y <= 28);
    assign u = (y >= 22 && y <= 27);
    assign e = (x >= 40 && x <= 42);
    assign b = (x >= 47 && x <= 49);
    assign a = (y >= 25 && y <= 28);
    assign a1 = (x >= 52 && x <= 54);
    assign r = (x == 58 || x == 59 || x == 60);
    assign p = (y >= 32 && y <= 38);
    assign p1 = (x == 13 || x == 14);
    assign g = (y == 32 || y == 38);
    assign w = (y >= 42 && y <= 47);
    assign Wa = (y >= 45 && y <= 48);
    assign Wa1 = (x >= 21 && x <= 23);
    assign Wa2 = (y >= 42 && y <= 48);
    assign Wv = (y >= 42 && y <= 46);
    assign We = (x >= 33 && x <= 35);
    
    // ARROWS
    assign arrow1 = (((y >= 23 && y <= 27) && x == 3) || (x == 4 && (y == 23 || y == 27))  || (x == 5 && (y == 24 || y == 26)) || (x == 6 && y == 25));
    assign arrow2 = (((y >= 33 && y <= 37) && x == 3) || (x == 4 && (y == 33 || y == 37))  || (x == 5 && (y == 34 || y == 36)) || (x == 6 && y == 35));
    assign arrow3 = (((y >= 43 && y <= 47) && x == 3) || (x == 4 && (y == 43 || y == 47))  || (x == 5 && (y == 44 || y == 46)) || (x == 6 && y == 45));
    assign arrow4 = (((y >= 53 && y <= 57) && x == 3) || (x == 4 && (y == 53 || y == 57))  || (x == 5 && (y == 54 || y == 56)) || (x == 6 && y == 55));
    
    // MENU
    assign menu = ((menuX[4:0] && menuLength) // Straight lines for 7 pixels (M, E, N)
            || ((x == 28 && (y == 5 || y == 6)) || (x == 29 && (y == 6 || y == 7)) || (x == 30 && (y == 7 || y == 8)) || (x == 31 && (y == 8 || y == 9)) || ((x == 32 || x == 33) && (y == 9 || y == 10)))
            || (x == 34 && (y == 8 || y == 9)) || (x == 35 && (y == 7 || y == 8)) || (x == 36 && (y == 6 || y == 7)) || (x == 37 && (y == 5 || y == 6)) // M
            || (E && (y == 3 || y == 4 || y == 9 || y == 10 || y == 15 || y == 16)) // E
            || ((x == 53 && (y == 6 || y == 7)) || (x == 54 && (y == 7 || y == 8)) || (x == 55 && (y == 8 || y == 9)) || (x == 56 && (y == 9 || y == 10)) || (x == 57 && (y == 10 || y == 11)) || (x == 58 && (y == 11 || y == 12))) // N
            || ((menuX[6:5] && (y >= 3 && y <= 14)) || ((x >= 66 && x <= 69) && (y == 15 || y == 16)))); // U 
    // volume bar
    assign volbar = ((v && (x == 12 || x == 16)) || (x == 13 && y == 27) || (x == 14 && y == 28) || (x == 15 && y == 27) //v
                || (o && (x == 18 || x == 22) || ((y == 22 || y == 28) && (x == 19 || x == 20 || x == 21))) // o
                || ((l && x == 24) || ((x == 25 || x == 26 || x == 27) && y == 28)) // l
                || ((u && (x == 29 || x == 32)) || ((x == 30 || x == 31) && y == 28)) // u
                || ((l && (x == 34 || x == 38)) || (y == 23 && (x == 35 || x == 37)) || (y == 24 && x == 36)) // m
                || ((l && x == 40) || (e && (y == 22 || y == 25 || y == 28))) // e
                || ((l && x == 47) || (b && (y == 22 || y == 25 || y == 28)) || (x == 50 && (y == 23 || y == 24 || y == 26 || y == 27))) // b
                || ((x == 56 && l) || (x == 52 && a) || (a1 && y == 26) || (x == 55 && y == 22) || (x == 54 && y == 23) || (x == 53 && y == 24)) // a
                || ((x == 58 && l) || ((y == 25 || y == 22) && r) || ((y == 23 || y == 24) && x == 61) || (x == 60 && y == 26) || (x == 61 && y == 27) || (x == 62 && y == 28))); //r
    // PING PONG
    assign pingpong = ((p && x == 12) || (p1 && (y == 32 || y == 35)) || ((y == 33 || y == 34) && x == 15) // P
                       || (x == 17 && p) // I
                       || (((x == 19 || x == 23) && p) || (y == 34 && x == 20) || (y == 35 && x == 21) || (y == 36 && x == 22)) // N
                       || ((x == 25 && (y >= 33 && y <= 37)) || (g && (x == 26 || x == 27)) || ((y == 33 || y == 37) && x == 28) || (x == 29 && (y == 37 || y == 38))) // G
                       || ((x == 33 && p) || ((x == 34 || x == 35) && (y == 32 || y ==35)) || ((y == 33 || y == 34) && x == 36)) // P
                       || (((x == 38 || x == 42) && (y >= 33 && y <= 37)) || ((x >= 39 && x <= 41) && (y == 32 || y == 38))) // O
                       || (((x == 44 || x == 48) && p) || (y == 34 && x == 45) || (y == 35 && x == 46) || (y == 36 && x == 47)) // N
                       || ((x == 50 && (y >= 33 && y <= 37)) || (g && (x == 51 || x == 52)) || ((y == 33 || y == 37) && x == 53) || (x == 54 && (y == 37 || y == 38)))); // G
    
    // WAVE
    assign wave = ((w && (x == 12 || x == 15 || x == 18)) || ((x == 13 || x == 14 || x == 16 || x == 17) && y == 48) // w
                    || ((x == 24 && Wa2) || (x == 20 && Wa) || (Wa1 && y == 45) || (x == 23 && y == 42) || (x == 22 && y == 43) || (x == 21 && y == 44)) // a
                    || ((Wv && (x == 26 || x == 30)) || (x == 27 && y == 47) || (x == 28 && y == 48) || (x == 29 && y == 47)) // v
                    || (Wa2 && x == 32) || (We && (y == 42 || y == 45 || y == 48))); // e
    
    
    always @ (*) begin
        if (menu || volbar || pingpong || wave || arrow1 || arrow2 || arrow3 || arrow4)
            oled_data = WHITE;
       else 
            oled_data = BLACK;
    end
    
endmodule
