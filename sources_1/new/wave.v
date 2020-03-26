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
    output [15:0] oled_data
    );
    localparam Width = 96;
    localparam Height = 64;
    parameter [15:0] BLACK = 16'b0;
    parameter [15:0] WHITE = ~BLACK;
    parameter [15:0] GREEN = 16'b00000_111111_00000;
    parameter [15:0] YELLOW = 16'b11111_111111_00000;
    parameter [15:0] RED = 16'b11111_000000_00000;
    
    reg [11:0] mic_data [Width-1:0];
    integer i;
    initial begin
        for (i = 0; i < Width; i = i+1) begin
            mic_data[i] = 0;
        end
    end
    
    wire [5:0] num; // value from 0 to 63
    reg [6:0] countx = 0; // 0 to 95
    
    
    always @ (posedge clk) begin
        countx <= countx == Width - 1 ? 0 : countx + 1;
        // get new mic_in value
        mic_data[countx] <= countx < Width - 1 ? mic_data[countx+1] : mic_in;
    end
    
    
    wire ygre, yyel, yred;
    wire [6:0] yreflect;
    parameter [6:0] barRange = 21;
    
    assign num = mic_data[x][11] ? mic_data[x][10:5] : 0;
    assign yreflect = Height - 1 - y;
    assign ygre = (yreflect < num && num >= 1 && num <= barRange);
    assign yyel = (yreflect < num && num >= 1+barRange && num <= 2*barRange);
    assign yred = (yreflect < num && num >= 1+2*barRange);
    
    assign oled_data = ygre ? GREEN : yyel ? YELLOW : yred ? RED :
                       !num && !yreflect ? WHITE : BLACK;
    
    
endmodule
