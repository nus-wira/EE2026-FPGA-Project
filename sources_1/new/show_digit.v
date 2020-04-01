`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/15/2020 06:54:52 PM
// Design Name: 
// Module Name: show_digit
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

module show_digit(
    input clkseg,
    input [3:0] num,
    output reg [`ANBIT:0] an = `CLR_AN,
    output reg [`SEGBIT:0] seg = ~7'b0
    );
    
    reg [`SEGBIT:0] seg0, seg1;
    reg count = 0;
    
    
    always @ (*) begin
        seg1 = num > 4'd9 ? `DIG1 : `DIG0;
        case (num)
        4'd0,4'd10: seg0 = `DIG0;
        4'd1,4'd11: seg0 = `DIG1;
        4'd2,4'd12: seg0 = `DIG2;
        4'd3,4'd13: seg0 = `DIG3;
        4'd4,4'd14: seg0 = `DIG4;
        4'd5,4'd15: seg0 = `DIG5;
        4'd6: seg0 = `DIG6;
        4'd7: seg0 = `DIG7;
        4'd8: seg0 = `DIG8;
        4'd9: seg0 = `DIG9;
        endcase
    end
    
    always @ (posedge clkseg) begin
        count <= count + 1;
        an <= ~(1 << count);
        seg <= count ? seg1 : seg0;
    end
    
endmodule