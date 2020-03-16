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
    input clk2,
    input [3:0] num,
    output reg [15:0] led = 0
    );
    // i.e. num == 1, assign led[1] = 1
    // num == 5, assign led[5] = 1;
    always @ (posedge clk2) begin
        case (num)
        4'd0: led <= 16'h0000;
        4'd1: led <= 16'h0001;
        4'd2: led <= 16'h0003;
        4'd3: led <= 16'h0007;
        4'd4: led <= 16'h000f;
        4'd5: led <= 16'h001f;
        4'd6: led <= 16'h003f;
        4'd7: led <= 16'h007f;
        4'd8: led <= 16'h00ff;
        4'd9: led <= 16'h01ff;
        4'd10: led <= 16'h03ff;
        4'd11: led <= 16'h07ff;
        4'd12: led <= 16'h0fff;
        4'd13: led <= 16'h1fff;
        4'd14: led <= 16'h3fff;
        4'd15: led <= 16'h7fff;
        endcase
    end
endmodule
