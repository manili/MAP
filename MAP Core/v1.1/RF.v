`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 		MANili
// Engineer: 		Mohammad Amin Nili
// 
// Create Date:    	12:27:26 05/14/2014 
// Design Name: 
// Module Name:    	RF 
// Project Name: 	MAP
// Target Devices: 
// Tool versions: 
// Description: 	This is register file which controls registers data flow.
//
// Dependencies: 
//
// Revision: 		1.1
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module RF(
	 input CLK,
    input SEL, //if SEL = 0 means  R1 selected else if SEL = 1 means R2 selected.
    input WR,
    input [7:0] iData,
	 output [7:0] R1_Value,
	 output [7:0] R2_Value,
    output reg [7:0] oData
    );
	
	wire [7:0] oTemp1;
	wire [7:0] oTemp2;
	
	Register R1(CLK, WR & ~SEL, iData, oTemp1);
	Register R2(CLK, WR & SEL, iData, oTemp2);
	
	assign R1_Value = oTemp1;
	assign R2_Value = oTemp2;
	
	always @(*)
		begin
			if(SEL == 0)
				oData <= oTemp1;
			else if (SEL == 1)
				oData <= oTemp2;
			else
				oData <= oData;
		end

endmodule
