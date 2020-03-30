// Screen dimmensions
`define WIDTH 96
`define HEIGHT 64

//paddle dimmensions for ping pong
`define PADDLEWIDTH 3
`define PADDLEHEIGHT 20
//ball dimmensions for ping pong
`define BALLSIZE 2
//edge definitions for ping pong
`define XPADLEFT 4
`define XPADRIGHT 91

// How many pixels wide/high each block is
`define BLOCKSIZE 4

//// How many blocks wide the game board is
//`define BLOCKS_WIDE 10

//// How many blocks high the game board is
//`define BLOCKS_HIGH 22

//// Width of the game board in pixels
//`define BOARD_WIDTH (`BLOCKS_WIDE * `BLOCK_SIZE)
//// Starting x pixel for the game board
//`define BOARD_X (((`PIXEL_WIDTH - `BOARD_WIDTH) / 2) - 1)

//// Height of the game board in pixels
//`define BOARD_HEIGHT (`BLOCKS_HIGH * `BLOCK_SIZE)
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

// The type of each block
`define NIL 2'b00
`define I 2'b01
`define L 2'b10
//`define J 3'b011
//`define O 3'b100
//`define S 3'b101
//`define T 3'b110
//`define Z 3'b111

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

//// Error value
//`define ERR_BLK_POS 8'b11111111

//// Modes
//`define MODE_BITS 3
//`define MODE_PLAY 0
//`define MODE_DROP 1
//`define MODE_PAUSE 2
//`define MODE_IDLE 3
//`define MODE_SHIFT 4

//// The maximum value of the drop timer
//`define DROP_TIMER_MAX 10000