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
    input CLK100MHZ, btnC,
    input [15:0] sw,
    output [15:0] led,
    output [7:0] JB, seg,
    output [3:0] an,
    input btnU, btnD, btnR
    );
    // Clocks and buttons
    wire clk20k, clk6p25m, clk50, pulU,pulD, pulR, reset; 
    wire frame_begin, sending_pixels, sample_pixel;
    wire [4:0] teststate;

    // Volume data from Audio_capture
    wire [11:0] mic_in;
    wire [3:0] num; // stores volume level (0-15)
    
    // Pixel_index from Oled_Display
    wire [12:0] pixel_index;
    wire [6:0] x,y;
    
    // Wires to store data from various modules
    wire [15:0] oled_data, oled_menu, oled_pong, oled_wave, oled_vol;
    wire [15:0] led_peak, led_vol;
    wire [3:0] an_vol, an_pong;
    wire [7:0] seg_vol, seg_pong;

    // Clocks
    clk_divider c0(CLK100MHZ, 12'd2499, clk20k); // 20 kHz
    clk_divider c1 (CLK100MHZ, 7, clk6p25m); // 6.25 MHz
    clk_divider c2(CLK100MHZ, 23'd999999, clk50); // 50 Hz
    
    // Buttons
    debounce_single_pulse dsp0 (btnC, clk6p25m, reset); // To change to be menu button
    debounce_single_pulse dsp1 (btnU, clk50, pulU);
    debounce_single_pulse dsp2 (btnD, clk50, pulD);
    debounce_single_pulse dsp3 (btnR, clk50, pulR);
    
    // Audio capture
    Audio_Capture ac0(
        .CLK(CLK100MHZ),        // 100MHz clock
        .cs(clk20k),            // sampling clock, 20kHz
        .MISO(J_MIC3_Pin3),     // J_MIC3_Pin3, serial mic input
        .clk_samp(J_MIC3_Pin1), // J_MIC3_Pin1
        .sclk(J_MIC3_Pin4),     // J_MIC3_Pin4, MIC3 serial clock
        .sample(mic_in)         // 12-bit audio sample data
        );
        
    // OLED Display instantation
    Oled_Display od0 (.clk(clk6p25m), .reset(reset), .pixel_data(oled_data), .frame_begin(frame_begin), 
        .sending_pixels(sending_pixels), .sample_pixel(sample_pixel), .pixel_index(pixel_index), 
        .cs(JB[0]), .sdin(JB[1]), .sclk(JB[3]), .d_cn(JB[4]), .resn(JB[5]), .vccen(JB[6]), 
        .pmoden(JB[7]), .teststate(teststate));
    // convert output pixel_index to x & y coordinates
    convertXY xy0(pixel_index, x, y);
    
    // Peak Detector
    intensity i0 (.clk(CLK100MHZ), .E(sw[0]), .mic_in(mic_in), .led(led_vol), .an(an_vol), .seg(seg_vol), .num(num));  
    // Oled display peak detector
    vol_display v0(sw, clk20k, num, x,y, oled_vol);
    
    // Pong
    pong p0(.clk(clk50), .sw(sw[15]), .btnU(pulU), .btnD(pulD), .btnR(pulR), .x(x), .y(y),
            .num(num), .oled_data(oled_pong),.an(an_pong),.seg(seg_pong));
    
    // Wave
    wave w0 (.clk(clk20k), .mic_in(mic_in),.x(x), .y(y),.oled_data(oled_wave));
    
    // Menu
    menuGUI menu0 (.x(x), .y(y), .oled_data(oled_menu));
    
    // Empty bit
    assign JB[2] = 0;
    
    // for testing
    wire [2:0] state;
    assign state = sw[14:12];
    
    // 0: menu, 1: peak detector, 2: pong, 3: wave
    final_mux mux00(.clk(CLK100MHZ), .state(state), .an_vol(an_vol), .an_pong(an_pong), .seg_vol(seg_vol), .seg_pong(seg_pong),
                    .oled_menu(oled_menu), .oled_pong(oled_pong), .oled_wave(oled_wave), .oled_vol(oled_vol), 
                    .led_vol(led_vol), .an(an), .seg(seg),.oled_data(oled_data), .led(led));


endmodule