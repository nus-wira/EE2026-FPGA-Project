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


module initpong(
    input clkseg,
    output reg [3:0] an = ~4'b0,
    output reg [7:0] seg = ~8'b0
    );
    reg [1:0] count = 0;
    
    always @ (posedge clkseg) begin
        count <= count + 1;
        an <= ~(1 << count);
        case (count)
            3: seg[6:0] <= 7'b0001100; //P
            2: seg[6:0] <= 7'b1000000; //O
            1: seg[6:0] <= 7'b0101011; //n
            0: seg[6:0] <= 7'b0010000; //g
        endcase
    end
endmodule
