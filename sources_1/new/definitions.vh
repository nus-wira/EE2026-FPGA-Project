////////////////////////////////////////////////////
////////////////      MACROS       ////////////////
//////////////////////////////////////////////////

// Screen dimmensions
`define WIDTH 96
`define HEIGHT 64
// Colors
`define BLACK 16'b0
`define WHITE ~`BLACK
`define MAGENTA 16'b11111_000000_11111
`define CYAN 16'b00000_111111_11111
`define YELLOW 16'b11111_111111_00000
`define GREEN 16'b00000_111111_00000
`define RED 16'b11111_000000_00000
`define BLUE 16'b00000_000000_11111
`define ORANGE 16'b11110_111100_00000
`define GREY 16'b01100_001100_01100

// Bit numbers for various
`define LDBIT       15
`define OLEDBIT     15
`define ANBIT       3
`define SEGDPBIT    7 //with dp
`define SEGBIT      6 //without dp
`define COLBIT      15 //colour
`define PIXELBIT    12 // Pixel_index from oled_display
`define PIXELXYBIT  6
// To clear AN/SEG
`define CLR_AN  ~4'b0
`define CLR_SEG ~8'b0

// 7SEG DIGITS
`define DIG0    7'b1000000
`define DIG1    7'b1111001
`define DIG2    7'b0100100
`define DIG3    7'b0110000
`define DIG4    7'b0011001
`define DIG5    7'b0010010
`define DIG6    7'b0000010
`define DIG7    7'b1111000
`define DIG8    7'b0
`define DIG9    7'b0010000   
// char
`define CHAR_P  7'b0001100
`define CHAR_O  7'b1000000
`define CHAR_N  7'b0101011
`define CHAR_G  7'b0010000


////////////////////////////////////////////////////
////////////////      VOL BAR      ////////////////
//////////////////////////////////////////////////

// Vol Bar Levels
`define LVLD 4
`define LVLH 2
`define LVL1 60
`define LVL2 (`LVL1 - `LVLD)
`define LVL3 (`LVL2 - `LVLD)
`define LVL4 (`LVL3 - `LVLD)
`define LVL5 (`LVL4 - `LVLD)
`define LVL6 (`LVL5 - `LVLD)
`define LVL7 (`LVL6 - `LVLD)
`define LVL8 (`LVL7 - `LVLD)
`define LVL9 (`LVL8 - `LVLD)
`define LVL10 (`LVL9 - `LVLD)
`define LVL11 (`LVL10 - `LVLD)
`define LVL12 (`LVL11 - `LVLD)
`define LVL13 (`LVL12 - `LVLD)
`define LVL14 (`LVL13 - `LVLD)
`define LVL15 (`LVL14 - `LVLD)



////////////////////////////////////////////////////
////////////////     PING PONG     ////////////////
//////////////////////////////////////////////////

//paddle dimmensions for ping pong
`define PADDLEWIDTH 3
`define PADDLEHEIGHT 20
`define PADWIDTH 2
//ball dimmensions for ping pong
`define BALLSIZE 2
//edge definitions for ping pong
`define XPADLEFT 4
`define XPADRIGHT 91
`define BORDER 3 //dist from edge
//movement definitions for ping pong
`define PIXELMOVE 6 //each button press moves 6 pixels 
`define AUDIOMOVE 3 //each increament in audio (0-15) moves the paddles by 3



////////////////////////////////////////////////////
////////////////      TETRIS       ////////////////
//////////////////////////////////////////////////

// DIMENSIONS FOR TETRIS GAME
// How many pixels wide/high each block is
`define BLOCKSIZE 4
//// How many blocks wide the game board is
`define TRIS_WIDTH 10
//// How many blocks high the game board is
`define TRIS_HEIGHT 20
//// Total board size (area)
`define TRIS_SIZE (`TRIS_WIDTH * `TRIS_HEIGHT)
//// Width of the game board in pixels
`define BOARD_WIDTH (`TRIS_WIDTH * `BLOCKSIZE)
//// Height of the game board in pixels
`define BOARD_HEIGHT (`TRIS_HEIGHT * `BLOCKSIZE)
//// Starting x pixel for the game board
//`define BOARD_X (((`PIXEL_WIDTH - `BOARD_WIDTH) / 2) - 1)
//// Starting y pixel for the game board
//`define BOARD_Y (((`PIXEL_HEIGHT - `BOARD_HEIGHT) / 2) - 1)

//// The number of bits used to store a block position
//`define BITS_BLK_POS 8
//// The number of bits used to store an X position
//`define BITS_X_POS 4
//// The number of bits used to store a Y position
//`define BITS_Y_POS 5
//// The number of bits used to store a rotation
//`define BITS_ROT 2
//// The number of bits used to store how wide / long a block is (max of decimal 4)
//`define BITS_BLK_SIZE 3
//// The number of bits for the score. The score goes up to 10000
//`define BITS_SCORE 14
//// The number of bits used to store each block
//`define BITS_PER_BLOCK 3

// Tetris block type
`define I 0
`define L 1
`define J 2
`define O 3
`define S 4
`define T 5
`define Z 6

//// Modes
`define MODE_INIT 0
`define MODE_PLAY 1
`define MODE_SHIFT 2
`define MODE_IDLE 3
