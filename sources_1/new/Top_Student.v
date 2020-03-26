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
    input btnU, btnD
    );
    wire clk20k, clk6p25m, reset; // Clocks and reset
    wire frame_begin, sending_pixels, sample_pixel, teststate;
    wire [12:0] pixel_index;
    wire [11:0] mic_in;
    wire [15:0] oled_data;
    wire [15:0] led_peak;
    wire [3:0] num;
    
    // Clocks
    clk_divider c0(CLK100MHZ, 12'd2499, clk20k); // 20 kHz
    clk_divider c1 (CLK100MHZ, 7, clk6p25m); // 6.25 MHz
    
    // Audio capture
    Audio_Capture ac0(
        .CLK(CLK100MHZ),        // 100MHz clock
        .cs(clk20k),            // sampling clock, 20kHz
        .MISO(J_MIC3_Pin3),     // J_MIC3_Pin3, serial mic input
        .clk_samp(J_MIC3_Pin1), // J_MIC3_Pin1
        .sclk(J_MIC3_Pin4),     // J_MIC3_Pin4, MIC3 serial clock
        .sample(mic_in)         // 12-bit audio sample data
        );
    // Multiplexer for audio to led/7seg
    intensity i0 (.clk(CLK100MHZ), .E(sw[0]), .mic_in(mic_in), .led(led_peak), .an(an), .seg(seg), .num(num));
    multi_1bit m0(sw[0], {4'b0, mic_in}, led_peak, led);
    // Reset LED button
    debounce_single_pulse dsp0 (btnC, clk6p25m, reset);
    // OLED Display instantation
    Oled_Display od0 (.clk(clk6p25m), .reset(reset), .pixel_data(oled_data), .frame_begin(frame_begin), 
        .sending_pixels(sending_pixels), .sample_pixel(sample_pixel), .pixel_index(pixel_index), 
        .cs(JB[0]), .sdin(JB[1]), .sclk(JB[3]), .d_cn(JB[4]), .resn(JB[5]), .vccen(JB[6]), 
        .pmoden(JB[7]), .teststate(teststate));
    
    // Empty bit
    assign JB[2] = 0;
    assign seg[7] = 1; // dp
    

    wire [6:0] x,y,userPaddleX, userPaddleY, audioPaddleX, audioPaddleY;
    wire userPaddleAppear,audioPaddleAppear;
    wire [15:0] userPaddle_col, audioPaddle_col;
    wire ball_on, clk50, pulU,pulD;
//    vol_display v0(sw, clk20k, num, pixel_index, oled_data);

    clk_divider c3(CLK100MHZ, 23'd999999, clk50);
    convertXY xy0(pixel_index, x, y);
    debounce_single_pulse dsp1 (btnU, clk6p25m, pulU);
    debounce_single_pulse dsp2 (btnD, clk6p25m, pulD);
//    airHockeyPaddles a0(.btnU(pulU), .btnD(pulD), .clkPaddle(clk50), .sw15(sw[15]), 
//                        .x(x), .y(y),.num(num),
//                        .userPaddleAppear(userPaddleAppear), .audioPaddleAppear(audioPaddleAppear),  
//                        .userPaddleX(userPaddleX), .userPaddleY(userPaddleY), 
//                        .audioPaddleX(audioPaddleX), .audioPaddleY(audioPaddleY),
//                        .userPaddle_col(userPaddle_col), .audioPaddle_col(audioPaddle_col));
//    ball b0 (.clk(clk50), .x(x),.y(y),
//             .ypad_left(userPaddleY),.ypad_right(userPaddleX),
//             .ball_on(ball_on));
//    assign oled_data = userPaddleAppear ? userPaddle_col :
//                       audioPaddleAppear ? audioPaddle_col :
//                       ball_on ? ~16'b0 : 0;
//    wave w0 (.clk(clk20k), .mic_in(mic_in),.x(x), .y(y),.oled_data(oled_data));
      
      menuGUI menu0 (.x(x), .y(y), .oled_data(oled_data));


endmodule