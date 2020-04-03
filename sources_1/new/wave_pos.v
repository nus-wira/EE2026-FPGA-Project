`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/03/2020 04:18:07 PM
// Design Name: 
// Module Name: wave_pos
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

module wave_pos(
    input sw,
    input [11:0] mic_data,
    input [`PIXELXYBIT:0] y,
    output [`OLEDBIT:0] oled_data    
    );
    localparam barRange = 21;
    localparam greRange = 10;
    localparam yelRange = 20;
    
    wire [`PIXELXYBIT:0] yreflect;
    reg [5:0] num, transnum; // value from 0 to 63
    reg ygre, yyel, yred;
    assign yreflect = `HEIGHT - 1 - y;
    
    // sw on: only positive sound, default: nice wave
    always @ (*) begin
        if (sw) begin
            num = (mic_data[11] ? mic_data[10:5] : 0);
            if (yreflect < num) begin
                ygre = (num >= 1 && num <= barRange);
                yyel = (num >= 1+barRange && num <= 2*barRange);
                yred = (num >= 1+2*barRange);
            end else begin
                ygre = 0;
                yyel = 0;
                yred = 0;
            end
        end else begin
            num = mic_data[11:6];
            transnum = num > `HEIGHT/2 ? num : `HEIGHT - num; // get value above x-axis
            if (yreflect < transnum && yreflect > `HEIGHT - transnum) begin
                ygre = (transnum <= `HEIGHT/2 + greRange && transnum >= `HEIGHT/2 - greRange);
                yyel = !ygre && (transnum <= `HEIGHT/2 + yelRange && transnum >= `HEIGHT/2 - yelRange);
                yred = !yyel && (transnum > `HEIGHT/2 + yelRange && transnum < `HEIGHT/2 - yelRange);
            end else begin
                ygre = 0;
                yyel = 0;
                yred = 0;
            end
        end
    end
    
    assign oled_data = ygre ? `GREEN : yyel ? `YELLOW : yred ? `RED :
                       sw && !num && !yreflect || 
                       !sw && num == `HEIGHT/2 && yreflect == `HEIGHT/2 ? `WHITE : `BLACK;
endmodule
