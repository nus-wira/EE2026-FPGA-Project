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


module colour_mux(
    input sw3, sw4,
    output reg [15:0] bor_col, bg_col, volCol_top, volCol_mid, volCol_bot
    );
    parameter [15:0] GREEN = 16'b00000_111111_00000;
    parameter [15:0] YELLOW = 16'b11111_111111_00000;
    parameter [15:0] RED = 16'b11111_000000_00000;
    parameter [15:0] CYAN = 16'b00000_111111_11111;
    parameter [15:0] BLUE = 16'b00000_000000_11111;
    parameter [15:0] MAGENTA = 16'b11111_000000_11111;
    parameter [15:0] BLACK = 16'b0;
    parameter [15:0] WHITE = ~BLACK;
    
    always @ (*) begin
        if(sw3 && !sw4) begin
            bor_col = BLUE;
            bg_col = BLACK;
            volCol_top = RED;
            volCol_mid = GREEN;
            volCol_bot = WHITE;
        end
        
        else if(sw3 && sw4) begin
            bor_col = BLACK;
            bg_col = WHITE;
            volCol_top = MAGENTA;
            volCol_mid = YELLOW;
            volCol_bot = CYAN;
        end
        
        else if (!sw3 && !sw4) begin
            bor_col = WHITE;
            bg_col = BLACK;
            volCol_top = RED;
            volCol_mid = YELLOW;
            volCol_bot = GREEN;
        end
    end
    
endmodule
