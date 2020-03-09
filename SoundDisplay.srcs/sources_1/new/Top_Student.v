`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
//
//  FILL IN THE FOLLOWING INFORMATION:
//
//  LAB SESSION DAY (Delete where applicable): MONDAY P.M
//
//  STUDENT A NAME: WIRA AZMOON AHMAD
//  STUDENT A MATRICULATION NUMBER: A0149286R
//
//  STUDENT B NAME: R RAMANA
//  STUDENT B MATRICULATION NUMBER: A0197788X
//
//////////////////////////////////////////////////////////////////////////////////


module Top_Student (
    input  J_MIC3_Pin3,   // Connect from this signal to Audio_Capture.v
    output J_MIC3_Pin1,   // Connect to this signal from Audio_Capture.v
    output J_MIC3_Pin4,    // Connect to this signal from Audio_Capture.v
    input CLK100MHZ, sw,
    output [11:0] led,
    output led15
    );
    wire clk20k;
    wire [11:0] mic_in;
    clk_voice c0(CLK100MHZ, 12'd2499, clk20k);
    Audio_Capture ac0(
        .CLK(CLK100MHZ),                  // 100MHz clock
        .cs(clk20k),                   // sampling clock, 20kHz
        .MISO(J_MIC3_Pin3),                 // J_MIC3_Pin3, serial mic input
        .clk_samp(J_MIC3_Pin1),            // J_MIC3_Pin1
        .sclk(J_MIC3_Pin4),            // J_MIC3_Pin4, MIC3 serial clock
        .sample(mic_in)     // 12-bit audio sample data
        );
    
    
    assign led15=sw;
//    assign led=mic_in;
    multi_1bit m0 (sw, mic_in, led);

endmodule