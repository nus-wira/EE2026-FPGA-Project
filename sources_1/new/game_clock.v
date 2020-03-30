`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/31/2020 12:01:13 AM
// Design Name: 
// Module Name: game_clock
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

// Modified clock divider where only a single pulse at every gameclk
//0.5Hz

module game_clock(
    input clk,
    output reg gameclk = 0
    );
    reg [5:0] count = 0;
    
    always @ (posedge clk) begin
        count <= (count == 49) ? 0 : count + 1;
        gameclk <= (count == 0);
    end
    
endmodule
