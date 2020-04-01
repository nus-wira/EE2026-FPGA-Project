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
`include "definitions.vh"

module wave(
    input clk,
    input [11:0] mic_in,
    input [`PIXELXYBIT:0] x, y,
    output [`OLEDBIT:0] oled_data
    );
    
    reg [11:0] mic_data [`WIDTH-1:0];
    integer i;
    initial begin
        for (i = 0; i < `WIDTH; i = i+1) begin
            mic_data[i] = 0;
        end
    end
    
    wire [5:0] num; // value from 0 to 63
    reg [`PIXELXYBIT:0] countx = 0; // 0 to 95
    
    
    always @ (posedge clk) begin
        countx <= countx == `WIDTH - 1 ? 0 : countx + 1;
        // get new mic_in value
        mic_data[countx] <= countx < `WIDTH - 1 ? mic_data[countx+1] : mic_in;
    end
    
    
    wire ygre, yyel, yred;
    wire [`PIXELXYBIT:0] yreflect;
    parameter [`PIXELXYBIT:0] barRange = 21;
    
    assign num = mic_data[x][11] ? mic_data[x][10:5] : 0;
    assign yreflect = `HEIGHT - 1 - y;
    assign ygre = (yreflect < num && num >= 1 && num <= barRange);
    assign yyel = (yreflect < num && num >= 1+barRange && num <= 2*barRange);
    assign yred = (yreflect < num && num >= 1+2*barRange);
    
    assign oled_data = ygre ? `GREEN : yyel ? `YELLOW : yred ? `RED :
                       !num && !yreflect ? `WHITE : `BLACK;
    
    
endmodule
