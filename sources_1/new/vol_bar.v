`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/16/2020 06:58:54 PM
// Design Name: 
// Module Name: vol_bar
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

// TO BE EDITED
module vol_bar(
    input clk2,
    input [3:0] num,
    input [15:0] pixel_index,
    output reg [15:0] oled_data
    );
    parameter [15:0] GREEN = 16'b00000_111111_00000;
    parameter [15:0] YELLOW = 16'b11111_111111_00000;
    parameter [15:0] RED = 16'b11111_111111_00000;
    
    //convertXY xy0(clk2, pixel_index, x, y);
    // Should use convertXY on pixel_data
    // Should use result with if else in always block below
    always @ (*) begin
        case (num)
        1,2,3,4,5: oled_data = GREEN;
        6,7,8,9,10: oled_data = YELLOW;
        11,12,13,14,15: oled_data = RED;
        endcase
    end
endmodule
