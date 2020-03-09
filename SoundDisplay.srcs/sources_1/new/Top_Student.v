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
//    input  J_MIC3_Pin3,   // Connect from this signal to Audio_Capture.v
//    output J_MIC3_Pin1,   // Connect to this signal from Audio_Capture.v
//    output J_MIC3_Pin4,    // Connect to this signal from Audio_Capture.v
    input CLK100MHZ, btnC,
    inout [7:0] JB
    );
    
    wire clk20k;
    wire clk6p25m;
    wire [11:0] sample;
    wire reset;
    wire frame_begin, sending_pixels, sample_pixel, pixel_index, teststate;
    reg [15:0] oled_data = 16'h07E0;
    
    assign JB[2] = 0;
    
    //clk_voice c0(CLK100MHZ, clk20k);
    //Audio_Capture ac0(CLK100MHZ, clk20k, J_MIC3_Pin3, J_MIC3_Pin1, J_MIC3_Pin4, sample);
    
    clk_oled o0 (CLK100MHZ, clk6p25m);
    debounce_single_pulse dsp0 (btnC, clk6p25m, reset);
    Oled_Display od0 (.clk(clk6p25m), .reset(reset), .pixel_data(oled_data), .frame_begin(frame_begin), 
        .sending_pixels(sending_pixels), .sample_pixel(sample_pixel), .pixel_index(pixel_index), 
        .cs(JB[0]), .sdin(JB[1]), .sclk(JB[3]), .d_cn(JB[4]), .resn(JB[5]), .vccen(JB[6]), 
        .pmoden(JB[7]), .teststate(teststate));

endmodule