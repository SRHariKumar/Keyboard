`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.02.2024 13:04:42
// Design Name: 
// Module Name: bcd_7segment
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


  module Binary_To_7Segment 
  (
   input       clk,
   input [3:0] i_Binary_Num,
   output   reg [7:0] r_Hex_Encoding
   );

 // reg [7:0]    r_Hex_Encoding = 8'h00;
  
  // Purpose: Creates a case statement for all possible input binary numbers.
  // Drives r_Hex_Encoding appropriately for each input combination.
  always @(posedge clk)
    begin
      case (i_Binary_Num)
        4'b0000 : r_Hex_Encoding = 8'b00000011;//0
        4'b0001 : r_Hex_Encoding = 8'b11110011;//1
        4'b0010 : r_Hex_Encoding = 8'b00100101;//2
        4'b0011 : r_Hex_Encoding = 8'b00001101;//3
        4'b0100 : r_Hex_Encoding = 8'b10011001;//4         
        4'b0101 : r_Hex_Encoding = 8'b01001001;//5
        4'b0110 : r_Hex_Encoding = 8'b01000001;//6
        4'b0111 : r_Hex_Encoding = 8'b00011101;//7
        4'b1000 : r_Hex_Encoding = 8'b00000001;//8
        4'b1001 : r_Hex_Encoding = 8'b00001001;//9
        4'b1010 : r_Hex_Encoding = 8'b00010001;//A
        4'b1011 : r_Hex_Encoding = 8'b11000001;//B
        4'b1100 : r_Hex_Encoding = 8'b01100011;//C
        4'b1101 : r_Hex_Encoding = 8'b10000101;//d
        4'b1110 : r_Hex_Encoding = 8'b01100001;//E
        4'b1111 : r_Hex_Encoding = 8'b01110001;//F
        
        
        
        default: r_Hex_Encoding = 8'b11111111;
      endcase
    end 


endmodule