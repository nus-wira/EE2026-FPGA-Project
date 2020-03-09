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
    input CLOCK, btnC
    );
    wire clk20k;
    wire clk6p25m;
    wire [11:0] sample;
    wire reset;
    wire [15:0] oled_data = 16'h07E0;
    wire frame_begin, sending_pixels, sample_pixel, pixel_index, cs, sdin, sclk, d_cn, resn, vccen, pmoden,teststate;
    
    clk_voice c0(CLOCK, clk20k);
    Audio_Capture ac0(CLOCK, clk20k, J_MIC3_Pin3, J_MIC3_Pin1, J_MIC3_Pin4, sample);
    clk_oled o0 (CLOCK, clk6p25m);
    debounce_single_pulse dsp0 (btnC, clk6p25m, reset);
    Oled_Display od0 (.clk(clk6p25m), .reset(reset), .pixel_data(oled_data));

endmodule