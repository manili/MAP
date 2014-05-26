`timescale 1ns / 1ps

`define PUSH 	2'd0
`define POP 	2'd1
`define INIT 	2'd2
`define NoOp 	2'd3
//////////////////////////////////////////////////////////////////////////////////
// Company: 		MANili
// Engineer: 		Mohammad Amin Nili
// 
// Create Date:    	12:00:12 05/14/2014 
// Design Name: 
// Module Name:    	Stack 
// Project Name: 	MAP
// Target Devices: 
// Tool versions: 
// Description: 	This file is Stack memory which also works as a SP (which is
//					not good).
//
// Dependencies: 
//
// Revision: 		1.1
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////

//This module use internal SP!
module Stack(
    input CLK,
	 input [1:0] Mode,
	 input [7:0] iData,
    input [7:0] iADDR,
    output [7:0] oData,
	 output reg [7:0] oADDR
    );

	reg [7:0] memory [255:0];
	
	assign oData = memory[oADDR + 1'd1];
	
	always @(posedge CLK)
		begin
			if (Mode == `PUSH)
				begin
					memory[oADDR] <= iData;
					oADDR <= iADDR - 1'd1;
				end
			else if (Mode == `POP)
				begin
					oADDR <= iADDR + 1'd1;
				end
			else if (Mode == `INIT)
				begin
					oADDR <= 8'd255;
				end
			else if (Mode == `NoOp)
				begin
					oADDR <= oADDR;
				end
		end

endmodule
