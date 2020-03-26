`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/26/2020 05:32:18 PM
// Design Name: 
// Module Name: score
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


module score(
    input clk, p1_pt, p2_pt, rst,
    output reg [3:0] an = 0,
    output reg [7:0] seg = 0
    );
    reg [6:0] p1 = 0, p2 = 0;
    reg [1:0] count = 0;
    wire clk381;
    wire [6:0] seg0, seg1, seg2, seg3;
    clk_divider c0(clk, 14'd13122, clk381);
    
    always @ (posedge clk) begin
        p1 <= rst ? 0 : p1_pt ? p1 + 1 : p1;
        p2 <= rst ? 0 : p2_pt ? p2 + 1 : p2;
    end
    
    pt7seg ps0(clk, p1, seg3, seg2);
    pt7seg ps1(clk, p2, seg1, seg0);
    
    always @ (posedge clk381) begin
        count <= count == 3 ? 0 : count + 1;
        an <= ~(1 << count);
        seg[7] <= count != 2;
        case (count)
            0: seg[6:0] <= seg0;
            1: seg[6:0] <= seg1;
            2: seg[6:0] <= seg2;
            3: seg[6:0] <= seg3;
        endcase
//        case (count)
//        0: begin
//            an <= 4'b1110;
//            seg <= seg0;
//        end
//        1: begin
//            an <= 4'b1101;
//            seg <= seg1;
//        end
//        2: begin
//            an <= 4'b1011;
//            seg <= seg1;
//        end
//        3: begin
//            an <= 4'b0111;
//            seg <= seg1;
//        end
//        endcase
    end
endmodule
