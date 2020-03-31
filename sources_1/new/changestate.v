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
    input clk, btnC, pw_flag,
    input [2:0] menu_flag, // menu flag
    output reg [2:0] state = 0
    );
    
    always @ (posedge clk) begin
        // If in menu when pw_flag received, change to state 4
        // If btnC is pressed, and in menu, change to menu flag, else change to menu.
        state <= (pw_flag && !state) ? 4 : btnC ? (!state ? menu_flag : 0) : state;
    end
endmodule
