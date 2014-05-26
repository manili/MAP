`timescale 1ns / 1ps

`define ADD 2'd0
`define SUB 2'd1
`define NoOp 2'
//////////////////////////////////////////////////////////////////////////////////
// Company:        	MANili
// Engineer: 	   	Mohammad Amin Nili
// 
// Create Date:    	20:54:54 05/14/2014 
// Design Name: 
// Module Name:    	Adder 
// Project Name:   	MAP
// Target Devices: 
// Tool versions: 
// Description:    	This is an adder for PC (Program Counter).
//
// Dependencies: 
//
// Revision: 		1.1
// Revision 1.0 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Adder(
    input [7:0] A,
    input [7:0] B,
    output [7:0] oData
    );
	 
	 assign oData = A + B;

endmodule
