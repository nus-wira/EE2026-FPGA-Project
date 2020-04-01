`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/26/2020 09:41:58 PM
// Design Name: 
// Module Name: pt7seg
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

module pt7seg(
    input clk,
    input [6:0] pt,
    output reg [`SEGBIT:0] seg1, seg0
    );
    wire [3:0] n0,n1;
    assign n0 = pt % 10;
    assign n1 = pt / 10;
    
    always @ (posedge clk) begin
        case (n0)
        4'd0: seg0 <= `DIG0;
        4'd1: seg0 <= `DIG1;
        4'd2: seg0 <= `DIG2;
        4'd3: seg0 <= `DIG3;
        4'd4: seg0 <= `DIG4;
        4'd5: seg0 <= `DIG5;
        4'd6: seg0 <= `DIG6;
        4'd7: seg0 <= `DIG7;
        4'd8: seg0 <= `DIG8;
        4'd9: seg0 <= `DIG9;
        endcase
        case (n1)
        4'd0: seg1 <= `DIG0;
        4'd1: seg1 <= `DIG1;
        4'd2: seg1 <= `DIG2;
        4'd3: seg1 <= `DIG3;
        4'd4: seg1 <= `DIG4;
        4'd5: seg1 <= `DIG5;
        4'd6: seg1 <= `DIG6;
        4'd7: seg1 <= `DIG7;
        4'd8: seg1 <= `DIG8;
        4'd9: seg1 <= `DIG9;
        endcase
    end
    
endmodule
