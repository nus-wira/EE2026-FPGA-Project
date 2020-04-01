`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/28/2020 03:06:40 PM
// Design Name: 
// Module Name: initpong
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

module initpong(
    input clkseg,
    output reg [`ANBIT:0] an = `CLR_AN,
    output reg [`SEGDPBIT:0] seg = `CLR_SEG
    );
    reg [1:0] count = 0;
    
    always @ (posedge clkseg) begin
        count <= count + 1;
        an <= ~(1 << count);
        case (count)
            3: seg[`SEGBIT:0] <= `CHAR_P; //P
            2: seg[`SEGBIT:0] <= `CHAR_O; //O
            1: seg[`SEGBIT:0] <= `CHAR_N; //n
            0: seg[`SEGBIT:0] <= `CHAR_G; //g
        endcase
    end
endmodule
