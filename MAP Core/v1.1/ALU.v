`timescale 1ns / 1ps

//Shift
`define SRL 5'd0
`define SRA 5'd1
`define SRRL 5'd2
`define SRRA 5'd3
`define SLL 5'd4
`define SLA 5'd5
`define SLRL 5'd6
`define SLRA 5'd7

//Move
`define MOV 5'd8

//One Operand
`define NOT 5'd9
`define INC 5'd10
`define DEC 5'd11
`define CLR 5'd12

//Two Operands
`define AND 5'd13
`define OR 5'd14
`define ADD 5'd15
`define SUB 5'd16

//Flags
`define CLE 5'd17
`define CLZ 5'd18

//////////////////////////////////////////////////////////////////////////////////
// Company: 	   	MANili
// Engineer: 	   	Mohammad Amin Nili
// 
// Create Date:    	13:33:41 05/14/2014 
// Design Name: 
// Module Name:    	ALU 
// Project Name: 	MAP
// Target Devices: 
// Tool versions: 
// Description:    	This is MAP ALU.
//
// Dependencies: 
//
// Revision: 		1.1
// Revision 1.0 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module ALU(
	 input [4:0] MODE,
    input [7:0] A,
    input [7:0] B,
	 output reg E,
	 output reg Z,
    output reg [7:0] oData
    );

	always @(*)
	begin

//oData :

//Shifts :
		if (MODE == `SRL)
			begin
				oData <= A >> 1;
			end
		else if (MODE == `SRA)
			begin
				oData <= 1 >>> A;
			end
		else if (MODE == `SRRL)
			begin
				oData[7] <= A[0];
				oData[6:0] <= A[7:0] >> 1;
			end
		else if (MODE == `SRRA)
			begin
				oData[6] <= A[0];
				oData[5:0] <= A[6:0] >> 1;
			end
		else if (MODE == `SLL)
			begin
				oData <= A << 1;
			end
		else if (MODE == `SLA)
			begin
				oData <= A <<< 1;
			end
		else if (MODE == `SLRL)
			begin
				oData[0] <= A[7];
				oData[6:0] <= A[7:0] << 1;
			end
		else if (MODE == `SLRA)
			begin
				oData[0] <= A[6];
				oData[5:0] <= A[6:0] >> 1;
			end
		
//Move :
		else if (MODE == `MOV)
			begin
				oData <= A;
			end
		
//One Operand :
		else if (MODE == `NOT)
			begin
				oData <= ~A;
			end
		else if (MODE == `INC)
			begin
				oData <= A + 8'd1;
			end
		else if (MODE == `DEC)
			begin
				oData <= A - 8'd1;
			end
		else if (MODE == `CLR)
			begin
				oData <= 8'd0;
			end

//Two Operands :
		else if (MODE == `AND)
			begin
				oData <= A & B;
			end
		else if (MODE == `OR)
			begin
				oData <= A | B;
			end
		else if (MODE == `ADD)
			begin
				oData <= A + B;
			end
		else if (MODE == `SUB)
			begin
				oData <= A - B;
			end
			
//ELSE :
		else
			oData <= oData;
			
//Flags :
		if (MODE != `CLE)
			E <= A[7] ^ B[7] ^ oData[7];
		else
			E <= 0;
		
		if (MODE != `CLZ)
			Z <= (A == B);
		else
			Z <= 0;

	end

endmodule

//Shift
`undef SRL
`undef SRA
`undef SRRL
`undef SRRA
`undef SLL
`undef SLA
`undef SLRL
`undef SLRA

//Move
`undef MOV

//One Operand
`undef NOT
`undef INC
`undef DEC
`undef CLR

//Two Operands
`undef AND
`undef OR
`undef ADD
`undef SUB

//Flags
`undef CLE
`undef CLZ
