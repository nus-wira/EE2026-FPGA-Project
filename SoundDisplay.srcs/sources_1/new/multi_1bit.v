`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/09/2020 03:20:13 PM
// Design Name: 
// Module Name: multi_1bit
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


module multi_1bit(
    input E,
    input [11:0] mic_in,
    output [11:0] led
    );
    assign led = E ? mic_in : 0;
endmodule
