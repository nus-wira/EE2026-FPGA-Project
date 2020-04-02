`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/02/2020 01:34:52 PM
// Design Name: 
// Module Name: show_next_blk
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

module show_next_blk(
    input [2:0] next_blk,
    input [`PIXELXYBIT:0] x,y,
    output reg [`COLBIT:0] blk_col,
    output E
    );
    localparam stPos = 9;
    
    // Mini board just for next_blk
    wire [`MINI_SIZE-1:0] board;
    reg [4:0] blk1, blk2, blk3, blk4;
    wire blk1_E, blk2_E, blk3_E, blk4_E;
    
    convertMini_xy xy1(blk1, x, y, blk1_E);
    convertMini_xy xy2(blk2, x, y, blk2_E);
    convertMini_xy xy3(blk3, x, y, blk3_E);
    convertMini_xy xy4(blk4, x, y, blk4_E);
    
    assign E = blk1_E || blk2_E || blk3_E || blk4_E;

    always @ (*) begin
        case (next_blk)
        `I: begin //straight block
            // If 0 or 2 vertical else horizontal
            blk_col = `RED;
            blk1 = stPos;
            blk2 = blk1 - `MINI_WIDTH;
            blk3 = blk1 - 2 * `MINI_WIDTH;
            blk4 = blk1 - 3 * `MINI_WIDTH;
        end
        `O: begin //square block
            blk_col = `GREEN;
            blk1 = stPos;
            blk2 = blk1 + 1;
            blk3 = blk1 + 1 - `MINI_WIDTH;
            blk4 = blk1 - `MINI_WIDTH;
         end
        `L: begin // L block
            blk_col = `BLUE;
            blk1 = stPos;
            blk2 = blk1 - `MINI_WIDTH;
            blk3 = blk1 - `MINI_WIDTH*2;
            blk4 = blk1 - `MINI_WIDTH*2 + 1;
        end
        `J: begin // J block
            blk_col = `ORANGE;
            blk1 = stPos + 1;
            blk2 = blk1 - `MINI_WIDTH;
            blk3 = blk1 - `MINI_WIDTH*2;
            blk4 = blk1 - 1 - `MINI_WIDTH*2;
        end
        `S: begin // S block
            blk_col = `CYAN;
            blk1 = stPos + 1;
            blk2 = blk1 + 1;
            blk3 = blk1 - 1 - `MINI_WIDTH;
            blk4 = blk1 - `MINI_WIDTH;
        end
        `Z: begin // Z block
            blk_col = `MAGENTA;
            blk1 = stPos;
            blk2 = blk1 + 1;
            blk3 = blk1 + 1 - `MINI_WIDTH;
            blk4 = blk1 + 2 - `MINI_WIDTH;
        end
        `T: begin // T block
            blk_col = `YELLOW;
            blk1 = stPos + 1;
            blk2 = blk1 - 1 - `MINI_WIDTH;
            blk3 = blk1 - `MINI_WIDTH;
            blk4 = blk1 + 1 - `MINI_WIDTH;
        end
        endcase
    end
    
    
endmodule
