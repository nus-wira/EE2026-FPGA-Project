`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/09/2020 02:44:07 PM
// Design Name: 
// Module Name: clk_voice
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

// 20 kHz clock
// m = (fclk/(2*fdesired)) -1
module clk_voice(
    input CLOCK, 
    input [31:0] m,
    output reg clk20k = 0
    );
    reg [31:0] count = 0;
    
    always @ (posedge CLOCK) begin
        count <= (count == m) ? 0 : count + 1;
        clk20k <= (count == 0) ? ~clk20k : clk20k;
    end
endmodule
