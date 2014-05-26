`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 		MANili
// Engineer: 		Mohammad Amin Nili
// 
// Create Date:    	12:40:45 05/14/2014 
// Design Name: 
// Module Name:    	Control_Register 
// Project Name: 	MAP
// Target Devices: 
// Tool versions: 	
// Description: 	This is Control Register this file instantiates PC 
//					(Program Counter) and SP (Stack Pointer) which is 
//					not created yet.
//
// Dependencies: 
//
// Revision: 		1.1
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Control_Register(
	 input CLK,
    input [7:0] iADDR,
    output reg [7:0] oADDR
    );

	always @(posedge CLK)
	begin
		oADDR <= iADDR;
	end

endmodule
