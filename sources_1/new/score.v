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
`include "definitions.vh"

module score(
    input clk, clkseg, p1_pt, p2_pt, E, rst,
    output reg [`ANBIT:0] an = `CLR_AN,
    output reg [`SEGDPBIT:0] seg = `CLR_SEG
    );
    reg [6:0] p1 = 0, p2 = 0;
    reg [1:0] count = 0;
    
    wire [`SEGBIT:0] seg0, seg1, seg2, seg3;

    
    always @ (posedge clk) begin
        p1 <= !E || rst ? 0 : p1_pt ? p1 + 1 : p1;
        p2 <= !E || rst ? 0 : p2_pt ? p2 + 1 : p2;
    end
    
    pt7seg ps0(clk, p1, seg3, seg2);
    pt7seg ps1(clk, p2, seg1, seg0);
    
    always @ (posedge clkseg) begin
        count <= count + 1;
        an <= ~(1 << count);
        seg[7] <= count != 2;
        case (count)
            0: seg[6:0] <= seg0;
            1: seg[6:0] <= seg1;
            2: seg[6:0] <= seg2;
            3: seg[6:0] <= seg3;
        endcase
    end
endmodule
