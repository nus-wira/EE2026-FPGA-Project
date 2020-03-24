`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/21/2020 08:28:48 PM
// Design Name: 
// Module Name: wave
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


module wave(
    input clk,
    input [11:0] mic_in,
    input [6:0] x, y,
    output reg [15:0] oled_data = 0
    );
    localparam Width = 64;
    parameter [15:0] BLACK = ~16'b0;
    parameter [15:0] WHITE = ~BLACK;
    
    reg [11:0] mic_data [Width-1:0];
    integer i;
    initial begin
        for (i = 0; i < Width; i = i+1) begin
            mic_data[i] = 0;
        end
    end
    
    reg [5:0] num = 0; // value from 0 to 63
//    reg [6:0] countx = 0; // 0 to 95
    
    wire clk4;
    clk_divider c0 (clk, 24'd12499999, clk4); //4Hz
    

    always @ (posedge clk4) begin
        // replace values with the next one
        for (i = 0; i < Width - 1; i = i + 1) begin
            mic_data[i] <= mic_data[i+1];
        end
        // get new mic_in value
        mic_data[Width - 1] <= mic_in;
        // convert to a volume level
        num <= mic_data[x][11] ? mic_data[x][10:5] : 0;
        oled_data <= num == y ? WHITE : BLACK;
    end
    
    
endmodule
