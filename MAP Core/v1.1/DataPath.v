`timescale 1ns / 1ps

`define SP_BIOS 8'd255
`define PC_BIOS 8'd0
//////////////////////////////////////////////////////////////////////////////////
// Company: 		MANili
// Engineer: 		Mohammad Amin Nili
// 
// Create Date:    	16:04:49 05/14/2014 
// Design Name: 
// Module Name:    	DataPath 
// Project Name: 	MAP
// Target Devices: 
// Tool versions: 
// Description: 	This is Datapath file. 
//
// Dependencies: 
//
// Revision: 		1.1
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module DataPath(
	 input CLK,
    input [1:0] SEL_MUX1,
	 input [1:0] SEL_MUX4,
	 input [1:0] SEL_MUX5,
    input [4:0] OPMode_Main,
    input [1:0] WR,
	 input [1:0] Stack_Mode,
    output ZeroFlag,
	 output E,
	 output [7:0] Ins
    );
	 
	wire [7:0] R1_Value;
	wire [7:0] R2_Value;
	wire [7:0] oData_RF;
	wire [7:0] Y1;
	wire [7:0] Y2;
	wire [7:0] Y3;
	wire [7:0] Y4;
	wire [7:0] Y5;
	wire [7:0] oADDR;
	wire [7:0] oData_Stack;
	wire [7:0] oData_Heap;
	wire [7:0] oADDR_PC;
	wire [7:0] oData_Main_ALU;
	wire [7:0] oData_PC_INC;
	wire [7:0] oData_PC_INS;
	
	//Memory
	RF rf(CLK, Ins[0], WR[0], Y1, R1_Value, R2_Value, oData_RF);
	Stack stack(CLK, Stack_Mode, oData_RF, Y5, oData_Stack, oADDR);
	Heap heap(CLK, WR[1], Ins[5:1], oData_RF, oData_Heap);
	InsMem InstructionMemory(oADDR_PC, Ins);
	
	//Control_Register
	Control_Register PC(CLK, Y4, oADDR_PC);
	
	//Here I use an interal SP in stack instance! It could (should)
	//be modified to get a separate SP.
	
	//MUX
	MUX MUX1(SEL_MUX1, oData_Main_ALU, oData_Stack, oData_Heap, {4'd0, Ins[4:1]}, Y1); //Register Input
	MUX MUX2({1'b0, Ins[0]}, R1_Value, R2_Value, 8'd0, 8'd0, Y2);							  //ALU Input A
	MUX MUX3({1'b0, ~Ins[0]}, R1_Value, R2_Value, 8'd0, 8'd0, Y3);							  //ALU Input B
	MUX MUX4(SEL_MUX4, oData_PC_INC, oData_PC_INS, oData_RF, `PC_BIOS, Y4);				  //PC Input
	MUX MUX5(SEL_MUX5, oADDR, `SP_BIOS, 8'd0, 8'd0, Y5);										  //STACK Input
	
	//ALU
	ALU main_ALU(OPMode_Main, Y2, Y3, E, ZeroFlag, oData_Main_ALU);
	
	//Adder
	Adder pc_Inc(oADDR_PC, 8'd1, oData_PC_INC);
	Adder pc_Ins(oADDR_PC, {3'd0, Ins[5:1]}, oData_PC_INS);
	
endmodule
