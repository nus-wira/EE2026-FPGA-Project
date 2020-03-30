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


module calc_cur_blk(
    input [2:0] cur_blk,
    input [1:0] cur_rot,
    input [4:0] cur_x, cur_y,
    output reg [8:0] blk1, blk2, blk3,
    output reg [2:0] blk_width, blk_height
    );
    localparam Width = 10;
    
    wire cur_pos;
    assign cur_pos = cur_x + cur_y*Width;
    always @ (*) begin
        case (cur_blk)
        0: begin //straight block
            // If 0 or 2 vertical else horizontal
            blk1 = cur_pos;
            blk2 = cur_rot[0] ? blk1 + 1 : blk1 - Width;
            blk3 = cur_rot[0] ? blk1 + 2 : blk1 - 2* Width ;
            blk_width = cur_rot[0] ? 3 : 1;
            blk_height = cur_rot[0] ? 1 : 3;
        end
        1: begin // L block
            blk_width = 2;
            blk_height = 2;
            case (cur_rot)
            0: begin // L
                blk1 = cur_pos;
                blk2 = cur_pos - Width;
                blk3 = cur_pos - Width;
            end
            1: begin // L clockwise 90
                blk1 = cur_pos;
                blk2 = cur_pos + 1;
                blk3 = cur_pos - Width;
            end
            2: begin // L clockwise 180
                blk1 = cur_pos;
                blk2 = cur_pos + 1;
                blk3 = cur_pos + 1 - Width;
            end
            3: begin // L clockwise 270
                blk1 = cur_pos + 1;
                blk2 = cur_pos - Width;
                blk3 = cur_pos + 1 - Width;
            end
            endcase
        end
        endcase
    end
endmodule
