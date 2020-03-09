`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.03.2020 15:19:04
// Design Name: 
// Module Name: clk_oled
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

// m = (fclk/fdesired*2) -1
module clk_oled(
    input CLOCK,
    output reg clk6p25m = 0
    );
    reg [2:0] count = 0;
    
    always @ (posedge CLOCK) begin
        count <= (count == 7) ? 0 : count + 1;
        clk6p25m <= (count == 0) ? ~clk6p25m : clk6p25m;
    end
endmodule
