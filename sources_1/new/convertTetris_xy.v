`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.03.2020 14:58:14
// Design Name: 
// Module Name: convertTetris_xy
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

module convertTetris_xy(
    input [4:0] tetrisX, tetrisY,
    input [6:0] x, y,
    output [15:0] oled_data
    );
    
    reg [15:0] oled_dataX, oled_dataY;

    
    always @ (*) begin
       case (tetrisY)
       0: oled_dataX = (x >= 92 && x <= 95);
       1: oled_dataX = (x >= 88 && x <= 91);
       2: oled_dataX = (x >= 84 && x <= 87);
       3: oled_dataX = (x >= 80 && x <= 83);
       4: oled_dataX = (x >= 76 && x <= 79);
       5: oled_dataX = (x >= 72 && x <= 75);
       6: oled_dataX = (x >= 68 && x <= 71);
       7: oled_dataX = (x >= 64 && x <= 67);
       8: oled_dataX = (x >= 60 && x <= 63);
       9: oled_dataX = (x >= 56 && x <= 59);
       10: oled_dataX = (x >= 52 && x <= 55);
       11: oled_dataX = (x >= 48 && x <= 51);
       12: oled_dataX = (x >= 44 && x <= 47);
       13: oled_dataX = (x >= 40 && x <= 43);
       14: oled_dataX = (x >= 36 && x <= 39);
       15: oled_dataX = (x >= 32 && x <= 35);
       16: oled_dataX = (x >= 28 && x <= 31);
       17: oled_dataX = (x >= 24 && x <= 27);
       18: oled_dataX = (x >= 20 && x <= 23);
       19: oled_dataX = (x >= 16 && x <= 19);
       endcase        
    end
    
    always @ (*) begin
       case (tetrisX)
       0: oled_dataY = (y >= 60 && y <= 63);
       1: oled_dataY = (y >= 56 && y <= 59);
       2: oled_dataY = (y >= 52 && y <= 55);
       3: oled_dataY = (y >= 48 && y <= 51);
       4: oled_dataY = (y >= 44 && y <= 47);
       5: oled_dataY = (y >= 40 && y <= 43);
       6: oled_dataY = (y >= 36 && y <= 39);
       7: oled_dataY = (y >= 32 && y <= 35);
       8: oled_dataY = (y >= 28 && y <= 31);
       9: oled_dataY = (y >= 24 && y <= 27);
       endcase        
    end
    
    
    assign oled_data = (oled_dataX && oled_dataY) ? `WHITE : `BLACK;
endmodule
