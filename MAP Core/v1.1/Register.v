`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 		MANili
// Engineer: 		Mohammad Amin Nili
// 
// Create Date:    	12:13:51 05/14/2014 
// Design Name: 
// Module Name:    	Register 
// Project Name: 	MAP
// Target Devices: 
// Tool versions: 
// Description: 	This file will instantiates registers. 
//
// Dependencies: 
//
// Revision: 		1.1
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Register(
	 input CLK,
	 input WR,
    input [7:0] iData,
    output reg [7:0] oData
    );
	 
	 always @(posedge CLK)
		begin
			$display("%d", oData);
			if(WR == 1)
				oData <= iData;
			else
				oData <= oData;
		end
	 
endmodule
