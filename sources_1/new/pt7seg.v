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


module pt7seg(
    input clk,
    input [6:0] pt,
    output reg [6:0] seg1, seg0
    );
    wire [3:0] n0,n1;
    assign n0 = pt % 10;
    assign n1 = pt / 10;
    
    always @ (posedge clk) begin
        case (n0)
        4'd0: seg0 <= 7'b1000000;
        4'd1: seg0 <= 7'b1111001;
        4'd2: seg0 <= 7'b0100100;
        4'd3: seg0 <= 7'b0110000;
        4'd4: seg0 <= 7'b0011001;
        4'd5: seg0 <= 7'b0010010;
        4'd6: seg0 <= 7'b0000010;
        4'd7: seg0 <= 7'b1111000;
        4'd8: seg0 <= 7'b0;
        4'd9: seg0 <= 7'b0010000;
        endcase
        case (n1)
        4'd0: seg1 <= 7'b1000000;
        4'd1: seg1 <= 7'b1111001;
        4'd2: seg1 <= 7'b0100100;
        4'd3: seg1 <= 7'b0110000;
        4'd4: seg1 <= 7'b0011001;
        4'd5: seg1 <= 7'b0010010;
        4'd6: seg1 <= 7'b0000010;
        4'd7: seg1 <= 7'b1111000;
        4'd8: seg1 <= 7'b0;
        4'd9: seg1 <= 7'b0010000;
        endcase
    end
    
endmodule
