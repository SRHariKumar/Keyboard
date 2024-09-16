`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.02.2024 13:42:02
// Design Name: 
// Module Name: scanner4x4_top
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


module scanner4x4_top(
    input  wire clk,
    input  wire  [3:0] Row,
    output wire [3:0] Col,
    output wire [7:0] SSEGAN,
    output wire [7:0] r_Hex_Encoding );
   
   wire [3:0] o_Switch;
   wire [3:0] DecodeOut;
   wire [3:0] i_Binary_Num;
    
    assign SSEGAN = 8'b0111_1111; 
    
    Decoder d1 (.clk(clk), .Row(Row), .Col(Col), .DecodeOut(DecodeOut));
    // Decoder1 d1 (.clk(clk), .Row(Row), .Col(Col), .DecodeOut(DecodeOut));
    //KeyboardScanner f1 (.clk(clk), .rst(rst), .Row(Row), .ColOut(Col), .KeyData(DecodeOut), .KeyReady(1'bz));
     
     Debounce_4_Bit d2 (.i_Clk(clk), . i_Switch(DecodeOut), .o_Switch(i_Binary_Num));
    
    
    Binary_To_7Segment b1 (.clk(clk), .i_Binary_Num(i_Binary_Num), .r_Hex_Encoding(r_Hex_Encoding));
    
   
    
    
endmodule
