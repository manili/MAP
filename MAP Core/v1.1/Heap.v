`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 		MANili
// Engineer: 		Mohammad Amin Nili
// 
// Create Date:    	12:30:59 05/14/2014 
// Design Name: 
// Module Name:    	Heap 
// Project Name: 	MAP
// Target Devices: 
// Tool versions: 
// Description:		This is Heap memory of MAP.
//
// Dependencies: 
//
// Revision: 		1.1
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Heap(
    input CLK,
    input WR,
    input [4:0] ADDR,
    input [7:0] iData,
    output [7:0] oData
    );

	reg [7:0] memory [31:0];
	
	assign oData = memory[ADDR];
	
	always @(posedge CLK)
		begin
			if (WR == 1)
				begin
					memory[ADDR] <= iData;
				end
			else
				memory[ADDR] <= memory[ADDR];
		end

endmodule
