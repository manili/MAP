`timescale 1ns / 1ps


//Stack :

`define SP_PUSH 	2'd0

`define SP_POP 	2'd1

`define SP_INIT	2'd2

`define SP_NoOp 	2'd3


//ALU :
//Shift
`define ALU_SRL 5'd0
`define ALU_SRA 5'd1
`define ALU_SRRL 5'd2
`define ALU_SRRA 5'd3
`define ALU_SLL 5'd4
`define ALU_SLA 5'd5
`define ALU_SLRL 5'd6
`define ALU_SLRA 5'd7

//Move
`define ALU_MOV 5'd8

//One Operand
`define ALU_NOT 5'd9
`define ALU_INC 5'd10
`define ALU_DEC 5'd11
`define ALU_CLR 5'd12

//Two Operands
`define ALU_AND 5'd13
`define ALU_OR  5'd14
`define ALU_ADD 5'd15
`define ALU_SUB 5'd16

//Flags
`define ALU_CLE 5'd17
`define ALU_CLZ 5'd18



//No Operation

`define NoOp	 5'd19

//MUX1 :
`define ALU_Data 		2'd0
`define Stack_Data 	2'd1
`define Heap_Data 	2'd2
`define IMD_Data 		2'd3

//MUX4 :
`define PC_Inc 		2'd0

`define PC_IMD 		2'd1
`define PC_Reg 		2'd2
`define PC_BIOS 		2'd3



//MUX5 :

`define SP_Value		2'd0

`define SP_BIOS		2'd1

//Write :
`define WR_RF 			WR[0]
`define WR_Heap 		WR[1]

//Register File Select :
`define R1 0;
`define R2 1;





//////////////////////////////////////////////////////
//
//
//
//
//
//           Instrictions Started
//
//	
//
//
//
//////////////////////////////////////////////////////


				 //8'b76543210
`define STI 	8'b10000000//8'b10XXXXXR
`define LDI 	8'b11000000//8'b11XXXXXR

`define LRI 	8'b01000000//8'b010XXXXR
`define BRNI 	8'b01100000//8'b011XXXXX

`define SRL 	8'b00110000//8'b0011000R
`define SRA 	8'b00110100//8'b0011010R
`define SRRL 	8'b00111000//8'b0011100R
`define SRRA 	8'b00111100//8'b0011110R
`define SLL 	8'b00100000//8'b0010000R
`define SLA 	8'b00100100//8'b0010010R
`define SLRL 	8'b00101000//8'b0010100R
`define SLRA 	8'b00101100//8'b0010110R

`define PUSH 	8'b00001000//8'b0000100R
`define POP 	8'b00001100//8'b0000110R
`define BRNR 	8'b00000000//8'b0000000R
`define MOV 	8'b00000010//8'b0000001R

`define CLE 	8'b00000100//8'b00000100
`define HLT 	8'b00000101//8'b00000101
`define CLZ 	8'b00000110//8'b00000110

`define NOT 	8'b00010000//8'b0001000R
`define INC 	8'b00010010//8'b0001001R
`define DEC 	8'b00010100//8'b0001010R
`define CLR 	8'b00010110//8'b0001011R

`define AND 	8'b00011000//8'b0001100R
`define OR 		8'b00011010//8'b0001101R
`define ADD 	8'b00011100//8'b0001110R
`define SUB 	8'b00011110//8'b0001111R



//Masks :

`define Bit6_Mask 8'b11000000

`define Bit5_Mask 8'b11100000

`define Bit1_Mask 8'b11111110



//////////////////////////////////////////////////////
//
//
//
//
//
//           Instrictions Finished
//
//	
//
//
//
//////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////
// Company: 		MANili
// Engineer: 		Mohammad Amin Nili
// 
// Create Date:    	23:21:26 05/14/2014 
// Design Name: 
// Module Name:    	Controller 
// Project Name: 	MAP
// Target Devices: 
// Tool versions: 
// Description: 	This is main module of processor.
//
// Dependencies: 
//
// Revision: 		1.1
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Controller(
	 output reg [1:0] SEL_MUX1,
	 output reg [1:0] SEL_MUX4,

	 output reg [1:0] SEL_MUX5,
	 output reg [4:0] OPMode_Main,

	 output reg [1:0] Stack_Mode,
	 output [1:0] WR
    );
	 
	reg CLK = 1;
	reg HaltFlag = 0;
	wire [7:0] Ins;
	wire ZeroFlag;
	wire E;

	
	initial
		begin

			OPMode_Main <= `NoOp;
			SEL_MUX4 <= `PC_BIOS;

			Stack_Mode <= `SP_INIT;
		end
	
	always
		begin
			if (HaltFlag == 0)
				#5 CLK <= ~CLK;	//CAUTION : Always check for correct delay this 

										//could cause abnormal termination!
			else
					$stop;
		end
	 
	DataPath dataPath(CLK, SEL_MUX1, SEL_MUX4, SEL_MUX5, OPMode_Main, WR, Stack_Mode, ZeroFlag, E, Ins);

	

	assign `WR_Heap = ((Ins & `Bit6_Mask) == `STI);

	assign `WR_RF = ((Ins & `Bit6_Mask) == `LDI) || ((Ins & `Bit5_Mask) == `LRI) || ((Ins & `Bit1_Mask) == `POP) ||

						 ((Ins & `Bit1_Mask) == `SRL) || ((Ins & `Bit1_Mask) == `SRA) || ((Ins & `Bit1_Mask) == `SRRL) || ((Ins & `Bit1_Mask) == `SRRA) ||

						 ((Ins & `Bit1_Mask) == `SLL) || ((Ins & `Bit1_Mask) == `SLA) || ((Ins & `Bit1_Mask) == `SLRL) || ((Ins & `Bit1_Mask) == `SLRA) ||
						 ((Ins & `Bit1_Mask) == `MOV) || ((Ins & `Bit1_Mask) == `NOT) || ((Ins & `Bit1_Mask) == `INC) || ((Ins & `Bit1_Mask) == `DEC) || ((Ins & `Bit1_Mask) == `CLR) ||

						 ((Ins & `Bit1_Mask) == `AND) || ((Ins & `Bit1_Mask) == `OR) || ((Ins & `Bit1_Mask) == `ADD) || ((Ins & `Bit1_Mask) == `SUB);

	

	always @(*)
		begin

		

			
			if (((Ins & `Bit1_Mask) != `PUSH) && ((Ins & `Bit1_Mask) != `POP))

				begin

					Stack_Mode <= `SP_NoOp;

				end

			
		
			if ((Ins & `Bit6_Mask) == `STI)
				begin
					SEL_MUX4 <= `PC_Inc;
				end
				
				
			else if ((Ins & `Bit6_Mask) == `LDI)
				begin
					SEL_MUX1 <= `Heap_Data;
					SEL_MUX4 <= `PC_Inc;
				end
				
				
			else if ((Ins & `Bit5_Mask) == `LRI)
				begin
					SEL_MUX1 <= `IMD_Data;
					SEL_MUX4 <= `PC_Inc;
				end
				
				
			else if (((Ins & `Bit5_Mask) == `BRNI) && ~ZeroFlag)
				begin
					SEL_MUX4 <= `PC_IMD;
				end
				
				
			else if ((Ins & `Bit1_Mask) == `SRL)
				begin

					SEL_MUX1 <= `ALU_Data;
					OPMode_Main <= `ALU_SRL;
					SEL_MUX4 <= `PC_Inc;
				end
				
				
			else if ((Ins & `Bit1_Mask) == `SRA)
				begin

					SEL_MUX1 <= `ALU_Data;
					OPMode_Main <= `ALU_SRA;
					SEL_MUX4 <= `PC_Inc;
				end
				
				
			else if ((Ins & `Bit1_Mask) == `SRRL)
				begin

					SEL_MUX1 <= `ALU_Data;
					OPMode_Main <= `ALU_SRRL;
					SEL_MUX4 <= `PC_Inc;
				end
				
				
			else if ((Ins & `Bit1_Mask) == `SRRA)
				begin

					SEL_MUX1 <= `ALU_Data;
					OPMode_Main <= `ALU_SRRA;
					SEL_MUX4 <= `PC_Inc;
				end
				
				
			else if ((Ins & `Bit1_Mask) == `SLL)
				begin

					SEL_MUX1 <= `ALU_Data;
					OPMode_Main <= `ALU_SLL;
					SEL_MUX4 <= `PC_Inc;
				end
				
				
			else if ((Ins & `Bit1_Mask) == `SLA)
				begin

					SEL_MUX1 <= `ALU_Data;
					OPMode_Main <= `ALU_SLA;
					SEL_MUX4 <= `PC_Inc;
				end
				
				
			else if ((Ins & `Bit1_Mask) == `SLRL)
				begin

					SEL_MUX1 <= `ALU_Data;
					OPMode_Main <= `ALU_SLRL;
					SEL_MUX4 <= `PC_Inc;
				end
				
				
			else if ((Ins & `Bit1_Mask) == `SLRA)
				begin

					SEL_MUX1 <= `ALU_Data;
					OPMode_Main <= `ALU_SLRA;
					SEL_MUX4 <= `PC_Inc;
				end
				
				
			else if ((Ins & `Bit1_Mask) == `PUSH)
				begin
					Stack_Mode <= `SP_PUSH;
					SEL_MUX4 <= `PC_Inc;

					SEL_MUX5 <= `SP_Value;
				end
				
				
			else if ((Ins & `Bit1_Mask) == `POP)
				begin
					Stack_Mode <= `SP_POP;
					SEL_MUX1 <= `Stack_Data;
					SEL_MUX4 <= `PC_Inc;

					SEL_MUX5 <= `SP_Value;
				end
				
				
			else if (((Ins & `Bit1_Mask) == `BRNR) && ~ZeroFlag)
				begin
					SEL_MUX4 <= `PC_Reg;
				end
				
				
			else if ((Ins & `Bit1_Mask) == `MOV)
				begin
					SEL_MUX1 <= `ALU_Data;
					OPMode_Main <= `ALU_MOV;
					SEL_MUX4 <= `PC_Inc;
				end
				
				
			else if (Ins == `CLE)
				begin
					OPMode_Main <= `ALU_CLE;
					SEL_MUX4 <= `PC_Inc;
				end
				
				
			else if (Ins == `HLT)
				begin
					HaltFlag <= 1'b1;
				end
				
				
			else if (Ins == `CLZ)
				begin
					OPMode_Main <= `ALU_CLZ;
					SEL_MUX4 <= `PC_Inc;
				end
				
				
			else if ((Ins & `Bit1_Mask) == `NOT)
				begin
					SEL_MUX1 <= `ALU_Data;
					OPMode_Main <= `ALU_NOT;
					SEL_MUX4 <= `PC_Inc;
				end
				
				
			else if ((Ins & `Bit1_Mask) == `INC)
				begin
					SEL_MUX1 <= `ALU_Data;
					OPMode_Main <= `ALU_INC;
					SEL_MUX4 <= `PC_Inc;
				end
				
				
			else if ((Ins & `Bit1_Mask) == `DEC)
				begin
					SEL_MUX1 <= `ALU_Data;
					OPMode_Main <= `ALU_DEC;
					SEL_MUX4 <= `PC_Inc;
				end
				
				
			else if ((Ins & `Bit1_Mask) == `CLR)
				begin
					SEL_MUX1 <= `ALU_Data;
					OPMode_Main <= `ALU_CLR;
					SEL_MUX4 <= `PC_Inc;
				end
				
				
			else if ((Ins & `Bit1_Mask) == `AND)
				begin
					SEL_MUX1 <= `ALU_Data;
					OPMode_Main <= `ALU_AND;
					SEL_MUX4 <= `PC_Inc;
				end
				
				
			else if ((Ins & `Bit1_Mask) == `OR)
				begin
					SEL_MUX1 <= `ALU_Data;
					OPMode_Main <= `ALU_OR;
					SEL_MUX4 <= `PC_Inc;
				end
				
				
			else if ((Ins & `Bit1_Mask) == `ADD)
				begin
					SEL_MUX1 <= `ALU_Data;
					OPMode_Main <= `ALU_ADD;
					SEL_MUX4 <= `PC_Inc;
				end
				
				
			else if ((Ins & `Bit1_Mask) == `SUB)
				begin
					SEL_MUX1 <= `ALU_Data;
					OPMode_Main <= `ALU_SUB;
					SEL_MUX4 <= `PC_Inc;
				end

				
				
		end

endmodule
