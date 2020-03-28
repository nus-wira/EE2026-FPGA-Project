`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/28/2020 08:28:16 PM
// Design Name: 
// Module Name: changestate
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


module changestate(
    input clk, btnC,
    input [2:0] menu_flag, // menu flag
    output reg [2:0] state = 0
    );
    
    always @ (posedge clk) begin
        // If btnC is pressed, and in menu, change to menu flag, else change to menu.
        state <= btnC ? (!state ? menu_flag : 0) : state;
    end
endmodule
