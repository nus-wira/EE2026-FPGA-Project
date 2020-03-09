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
module clk_voice(
    input CLOCK,
    output reg clk20k = 0
    );
    reg [12:0] count = 0;
    
    always @ (posedge CLOCK) begin
        if (count == 13'd5000) begin
            clk20k <= ~clk20k;
            count <= 0;
        end
    end
endmodule
