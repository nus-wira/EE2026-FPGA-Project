`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/26/2020 10:49:52 PM
// Design Name: 
// Module Name: final_mux
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


module final_mux(
    input clk,
    input [2:0] state,
    input [`ANBIT:0] an_vol, an_pong,
    input [`SEGDPBIT:0] seg_vol, seg_pong,
    input [`OLEDBIT:0] oled_menu, oled_pong, oled_wave, oled_vol, oled_tetris, led_vol,
    output reg [`ANBIT:0] an,
    output reg [`SEGDPBIT:0] seg,
    output reg [`OLEDBIT:0] oled_data, led
    );
    always @ (posedge clk) begin
        case (state)
        // Menu
        0: begin
            led <= 0;
            an <= `CLR_AN;
            seg <= `CLR_SEG;
            oled_data <= oled_menu;
        end
        // Peak detector
        1: begin
            led <= led_vol;
            an <= an_vol;
            seg <= seg_vol;
            oled_data <= oled_vol;
        end
        // Pong
        2: begin
            led <= 0;
            an <= an_pong;
            seg <= seg_pong;
            oled_data <= oled_pong;
        end
        // Wave
        3: begin
            led <= led_vol;
            an <= an_vol;
            seg <= seg_vol;
            oled_data <= oled_wave;
        end
        // Tetris
        4: begin
            led <= 0;
            an <= `CLR_AN;
            seg <= `CLR_SEG;
            oled_data <= oled_tetris;
        end
        // Passcode screen
        5: begin
            led <= 0;
            an <= `CLR_AN;
            seg <= `CLR_SEG;
            oled_data <= `BLACK;
        end
        endcase
    end
            
endmodule
