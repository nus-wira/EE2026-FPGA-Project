`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/29/2020 11:15:15 PM
// Design Name: 
// Module Name: rng
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

// Random Number Generator (RNG)
module rng(
    input clk, E,
    input [31:0] max, // number from 0 to max
    output reg [31:0] n = 0
    );
    reg [31:0] count = 0;
    always @ (posedge clk, posedge E) begin
        count <= count == max ? 0 : count + 1;
        n <= E ? n : count;
    end
endmodule
