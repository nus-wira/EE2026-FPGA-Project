`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.03.2020 20:49:23
// Design Name: 
// Module Name: colour_mux
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
`include "definitions.vh"

module colour_mux(
    input sw3, sw4,
    output reg [15:0] bor_col, bg_col, volCol_top, volCol_mid, volCol_bot
    );
    
    always @ (*) begin
        if(sw3 && !sw4) begin
            bor_col = `BLUE;
            bg_col = `BLACK;
            volCol_top = `RED;
            volCol_mid = `GREEN;
            volCol_bot = `WHITE;
        end
        else if(sw3 && sw4) begin
            bor_col = `RED;
            bg_col = `WHITE;
            volCol_top = `MAGENTA;
            volCol_mid = `YELLOW;
            volCol_bot = `CYAN;
        end        
        else if (!sw3 && !sw4) begin
            bor_col = `WHITE;
            bg_col = `BLACK;
            volCol_top = `RED;
            volCol_mid = `YELLOW;
            volCol_bot = `GREEN;
        end        
        else begin
            bor_col = `WHITE;
            bg_col = `BLACK;
            volCol_top = `BLACK;
            volCol_mid = `BLACK;
            volCol_bot = `BLACK;
        end
    end
    
endmodule
