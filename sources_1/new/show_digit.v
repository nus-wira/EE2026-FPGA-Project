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


module show_digit(
    input clk, clk2,
    input [3:0] num,
    output reg [3:0] an = ~4'b0,
    output reg [6:0] seg = ~7'b0
    );
    
    wire clk381;
    reg [6:0] seg0, seg1;
    reg count = 0;
    
    clk_divider c0(clk, 14'd13122, clk381);
    
    always @ (posedge clk2) begin
        seg1 <= num > 4'd9 ? 7'b1111001 : 7'b1000000;
        case (num)
        4'd0,4'd10: seg0 <= 7'b1000000;
        4'd1,4'd11: seg0 <= 7'b1111001;
        4'd2,4'd12: seg0 <= 7'b0100100;
        4'd3,4'd13: seg0 <= 7'b0110000;
        4'd4,4'd14: seg0 <= 7'b0011001;
        4'd5,4'd15: seg0 <= 7'b0010010;
        4'd6: seg0 <= 7'b0000010;
        4'd7: seg0 <= 7'b1111000;
        4'd8: seg0 <= 7'b0;
        4'd9: seg0 <= 7'b0010000;
        endcase
    end
    
    always @ (posedge clk381) begin
        count <= count + 1;
        case (count)
        0: begin
            an <= 4'b1110;
            seg <= seg0;
        end
        1: begin
            // If num 10 and above, switch on AN[1]
            an <= 4'b1101;
            seg <= seg1;
        end
        endcase
    end
    
endmodule