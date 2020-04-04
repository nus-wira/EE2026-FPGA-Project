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
    input clk, btnC, btnL, micD, pw_flag,
    input [2:0] menu_flag, // menu flag
    output reg [2:0] state = 5
    );
    
    always @ (posedge clk) begin
        // If in menu when pw_flag received, change to state 5
        // If btnC is pressed, and in menu, change to menu flag, else change to lockscreen.
//        state <= state == 5 ? (pw_flag && micD) ? 0 : !state ? btnL ? 5 : btnC ?  menu_flag : state : 5 : state;
//        state <= btnC ? (!state ? menu_flag : 0) : state;
          if ((state == 5 && micD && pw_flag) || ((state != 0 && state != 5) && btnC))
            state <= 0;
          else if (!state && btnC)
            state <= menu_flag;
          else if (!state && btnL)
            state <= 5;
          else 
            state <= state;
    end
    // : 2
endmodule
