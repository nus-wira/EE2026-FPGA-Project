`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.03.2020 20:53:55
// Design Name: 
// Module Name: passcode
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


module passcode(
    input E, btnU, btnD, btnL, btnR, clk,
    output pw_flag
    );
    
    reg [2:0] state = 0;
    assign pw_flag = (state == 4) ? 1 : 0;
    
    always @ (clk) begin
        if (E) begin
        case (state)
        0: state <= btnU ? 1 : state;
        1: state <= btnD ? 2 : (btnU || btnL || btnR) ? 0 : state;
        2: state <= btnL ? 3 : (btnU || btnD || btnR) ? 0 : state;
        3: state <= btnR ? 4 : (btnU || btnL || btnD) ? 0 : state;
        endcase
        end
    end
endmodule
