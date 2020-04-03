`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.04.2020 19:03:27
// Design Name: 
// Module Name: passcode_display
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


module passcode_display(
    input [`PIXELXYBIT:0] x, y, 
    input micD,
    output reg [`OLEDBIT:0] oled_data
    );
    
    wire code, LENGTH, TWOLENGTH1, TWOLENGTH2, E1, E2, TWO1, ZERO, TWO2, SIX, SIX1;
    //ASSIGN BOOLEANS
    assign LENGTH = (y >= 11 && y <= 52);
    assign TWOLENGTH1 = (y >= 13 && y <= 30);
    assign TWOLENGTH2 = (y >= 34 && y <= 50);
    assign E1 = (x >= 3 && x <= 15);
    assign E2 = (x >= 18 && x <= 30);
    assign TWO1 = (x >= 33 && x <= 45);
    assign ZERO = (x >= 48 && x <= 61);
    assign TWO2 = (x >= 64 && x <= 76);
    assign SIX = (x >= 79 && x <= 92);
    assign SIX1 = ((x == 91 || x == 92) && (y >= 34 && y <= 50));
    
    assign code =  (((LENGTH && (x == 3 || x == 4)) || (E1 && (y == 11 || y == 12 || y == 31 || y == 32 || y == 33 || y == 51 || y == 52))) // E
                    || ((LENGTH && (x == 18 || x == 19)) || (E2 && (y == 11 || y == 12 || y == 31 || y == 32 || y == 33 || y == 51 || y == 52))) // E
                    || ((TWOLENGTH1 && (x == 44 || x == 45)) || (TWOLENGTH2 && (x == 33 || x == 34)) || (TWO1 && (y == 11 || y == 12 || y == 31 || y == 32 || y == 33 || y == 51 || y == 52))) // 2
                    || ((LENGTH && (x == 48 || x == 49 || x == 60 || x == 61)) || (ZERO && (y == 11 || y == 12 || y == 51 || y == 52))) // 0
                    || ((TWOLENGTH1 && (x == 75 || x == 76)) || (TWOLENGTH2 && (x == 64 || x == 65)) || (TWO2 && (y == 11 || y == 12 || y == 31 || y == 32 || y == 33 || y == 51 || y == 52)))// 2
                    || ((LENGTH && (x == 79 || x == 80)) || (SIX && (y == 11 || y == 12 || y == 31 || y == 32 || y == 33 || y == 51 || y == 52)) || SIX1)); // 6
     
    always @ (*) begin
        if (micD)
           oled_data = code ? `WHITE : `BLACK;
    end
endmodule
