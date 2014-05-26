`timescale 1ns / 1ps

`define X1 2'b00
`define X2 2'b01
`define X3 2'b10
`define X4 2'b11

//////////////////////////////////////////////////////////////////////////////////
// Company: 		MANili
// Engineer: 		Mohammad Amin Nili
// 
// Create Date:    	15:43:57 05/14/2014 
// Design Name: 
// Module Name:    	MUX 
// Project Name: 	MAP
// Target Devices: 
// Tool versions: 
// Description: 	this is multiplexer file.
//
// Dependencies: 
//
// Revision: 		1.1
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module MUX(
	 input [1:0] SEL,
    input [7:0] X1,
    input [7:0] X2,
    input [7:0] X3,
    input [7:0] X4,
    output reg [7:0] Y
    );
	 
	always @(*)
		begin
			if (SEL == `X1)
				Y <= X1;
			else if (SEL == `X2)
				Y <= X2;
			else if (SEL == `X3)
				Y <= X3;
			else if (SEL == `X4)
				Y <= X4;
			else
				Y <= Y;
		end

endmodule
