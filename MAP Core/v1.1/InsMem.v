`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 		MANili
// Engineer: 		Mohammad Amin Nili
// 
// Create Date:    	15:57:33 05/14/2014 
// Design Name: 
// Module Name:    	InsMem 
// Project Name: 	MAP
// Target Devices: 
// Tool versions: 
// Description: 	This is instruction memory file.
//
// Dependencies: 
//
// Revision: 		1.1
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module InsMem(
    input [7:0] ADDR,
    output reg [7:0] Instruction
    );

	reg [7:0] memory [255:0];
	
	integer file, i;
	reg [7:0] c;
	
	initial
		begin
			/*memory[0] <= 8'b01000000; //Fill R1 with 0x0;
			memory[1] <= 8'b01011111; //Fill R2 with 0xF;
			memory[2] <= 8'b10000000; //Store R1 in heap[0x0];
			memory[3] <= 8'b10000011; //Store R2 in heap[0x1];
			memory[4] <= 8'b11000000; //Load R1 with heap[0x0];
			memory[5] <= 8'b00001001; //Push R2 to stack;
			memory[6] <= 8'b00011100; //R1 = R1 + R2;
			memory[7] <= 8'b10000100; //Store R1 in heap[0x2];
			memory[8] <= 8'b01000011; //Fill R2 with 0x1;
			memory[9] <= 8'b00011001; //R2 = R1 & R2;
			memory[10] <= 8'b01011100; //Fill R1 with 0xE;
			memory[11] <= 8'b00000000; //Branch to Ins[R1];
			memory[14] <= 8'b10000111; //Store R2 in heap[0x3];
			memory[15] <= 8'b00001000; //Push R1 to stack;
			memory[16] <= 8'b00001101; //Pop to R2;
			memory[17] <= 8'b00000101; //Halt;*/
			
			
			
         i = 0;
         file = $fopen("C:\\Users\\Win\\Desktop\\Example.mexe", "r"); //This is your mexe file address.
         while (c !== 8'b11111111)
				begin
					c = $fgetc(file);
					memory[i][7:0] = c;
					i = i + 1;
				end
		end
	
	always @(*)
		begin
			Instruction <= memory[ADDR];
			$display("Instruction is : %b", memory[ADDR]);
		end

endmodule
