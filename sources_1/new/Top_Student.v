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
    input CLK100MHZ, sw, btnC,
    output [11:0] led,
    output [7:0] JB
    );
    wire clk20k, clk6p25m ,reset; // Clocks and reset
    wire frame_begin, sending_pixels, sample_pixel, pixel_index, teststate;
    wire [11:0] mic_in;
    wire [15:0] oled_data;
    
    // Clocks
    clk_divider c0(CLK100MHZ, 12'd2499, clk20k); // 20 kHz
    clk_divider c1 (CLK100MHZ, 7, clk6p25m); // 6.25 MHz
    
    // Audio capture
    Audio_Capture ac0(
        .CLK(CLK100MHZ),                  // 100MHz clock
        .cs(clk20k),                   // sampling clock, 20kHz
        .MISO(J_MIC3_Pin3),                 // J_MIC3_Pin3, serial mic input
        .clk_samp(J_MIC3_Pin1),            // J_MIC3_Pin1
        .sclk(J_MIC3_Pin4),            // J_MIC3_Pin4, MIC3 serial clock
        .sample(mic_in)     // 12-bit audio sample data
        );
    // Multiplexer for audio to led
    multi_1bit m0 (sw, mic_in, led);
    
    // Reset LED button
    debounce_single_pulse dsp0 (btnC, clk6p25m, reset);
    // OLED Display instantation
    Oled_Display od0 (.clk(clk6p25m), .reset(reset), .pixel_data(oled_data), .frame_begin(frame_begin), 
        .sending_pixels(sending_pixels), .sample_pixel(sample_pixel), .pixel_index(pixel_index), 
        .cs(JB[0]), .sdin(JB[1]), .sclk(JB[3]), .d_cn(JB[4]), .resn(JB[5]), .vccen(JB[6]), 
        .pmoden(JB[7]), .teststate(teststate));
    
    // Empty bit
    assign JB[2] = 0;
    assign oled_data = {5'b0, mic_in[11:6], 5'b0}; 
    
    
endmodule