`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/15/2020 07:32:51 PM
// Design Name: 
// Module Name: show_led
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


module show_led(
    input num,
    output [15:0] led
    );
    // i.e. num == 1, assign led[1] = 1
    // num == 5, assign led[5] = 1;
    assign led = num ? 1 << (num-1) : 0;
endmodule
