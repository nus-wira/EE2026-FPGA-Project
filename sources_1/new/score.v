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
    input clk, p1_pt, p2_pt,
    output reg [3:0] an = 0,
    output reg [7:0] seg = 0
    );
    reg p1 = 0, p2 = 0;
    reg [1:0] count = 0;
    wire clk381;
    clk_divider c0(clk, 14'd13122, clk381);
    
    always @ (posedge clk) begin
        p1 <= p1_pt ? p1 + 1 : p1;
        p2 <= p2_pt ? p2 + 1 : p2;
    end
    
    // TO ADD MODULE TO CONVERT NUMBER TO DIGIT 0 AND 1 (decimal)
    
    always @ (posedge clk381) begin
        count <= count == 3 ? 0 : count + 1;
        
    end
endmodule
