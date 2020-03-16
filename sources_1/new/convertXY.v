`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.03.2020 14:57:29
// Design Name: 
// Module Name: convertXY
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


module convertXY(
    input pixel_index, twoHzclk,
    output reg x, y
    );
    
    always @ (posedge twoHzclk) begin
        assign x = pixel_index % 96;
        assign y = pixel_index / 96;
    end
    
endmodule
