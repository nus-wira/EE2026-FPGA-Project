`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/30/2020 03:41:10 PM
// Design Name: 
// Module Name: calc_cur_blk
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

module calc_cur_blk(
    input [2:0] cur_blk,
    input [1:0] cur_rot,
    input [4:0] cur_x, cur_y,
    output reg [8:0] blk1, blk2, blk3,
    output reg [2:0] blk_width, blk_height
    );
        
    wire [8:0] cur_pos;
    assign cur_pos = cur_x + cur_y*`TRIS_WIDTH;
    always @ (*) begin
        case (cur_blk)
        `I: begin //straight block
            // If 0 or 2 vertical else horizontal
            blk1 = cur_pos;
            blk2 = cur_rot[0] ? blk1 + 1 : blk1 - `TRIS_WIDTH;
            blk3 = cur_rot[0] ? blk1 + 2 : blk1 - 2* `TRIS_WIDTH ;
            blk_width = cur_rot[0] ? 3 : 1;
            blk_height = cur_rot[0] ? 1 : 3;
        end
        `L: begin // L block
            blk_width = 2;
            blk_height = 2;
            case (cur_rot)
            0: begin // L
                blk1 = cur_pos;
                blk2 = cur_pos - `TRIS_WIDTH;
                blk3 = cur_pos - `TRIS_WIDTH + 1;
            end
            1: begin // L clockwise 90
                blk1 = cur_pos;
                blk2 = cur_pos + 1;
                blk3 = cur_pos - `TRIS_WIDTH;
            end
            2: begin // L clockwise 180
                blk1 = cur_pos;
                blk2 = cur_pos + 1;
                blk3 = cur_pos + 1 - `TRIS_WIDTH;
            end
            3: begin // L clockwise 270
                blk1 = cur_pos + 1;
                blk2 = cur_pos - `TRIS_WIDTH;
                blk3 = cur_pos + 1 - `TRIS_WIDTH;
            end
            endcase
        end
        endcase
    end
endmodule
