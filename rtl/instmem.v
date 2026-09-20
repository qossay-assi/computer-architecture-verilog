module instmem (
    input wire [15:0] inputPC,
    output reg [15:0] instruction
);

    reg [15:0] mem[127:0];

	parameter R_TYPE = 4'b0000;
	parameter AND  = 3'b000;
	parameter OR   = 3'b001;
	parameter NOR  = 3'b010;
	parameter XOR  = 3'b011;
	parameter ADD  = 3'b100;
	parameter SLT  = 3'b101;
	parameter SUB  = 3'b110;
	parameter JR   = 3'b111;
	parameter ANDI = 4'b1000;
	parameter ORI  = 4'b1001;
	parameter ADDI = 4'b0100;
	parameter SLTI = 4'b0101;
	parameter LW   = 4'b0110;
	parameter SW   = 4'b0111;
	parameter BEQ  = 4'b1010;
	parameter BNE  = 4'b1011;
	parameter J    = 4'b1100;
	parameter JAL  = 4'b1101;
	parameter LUI  = 4'b1111; 
	
	
	// change the starting address of instructions in pc register to swap between the 2 programs
	initial begin
			//PART A -- PROGRAM TO INITIATE AN ARRAY AND SUM IT
		// R0=0, R1=1, R2=2, R3=3, R4=4, R7=7
		
		// main procedure: Initialize a 3-element array at memory address 10
		// array values will be {5, 20, 15}
		mem[0]  = {ADDI, 3'd0, 3'd1, 6'd10};   // 404A | ADDI R1, R0, 10    (array base address)
		mem[1]  = {ADDI, 3'd0, 3'd4, 6'd5};    // 4105 | ADDI R4, R0, 5     (load value 5 into temp reg)
		mem[2]  = {SW,   3'd1, 3'd4, 6'd0};    // 7300 | SW   R4, 0(R1)      (mem[10] = 5)
		mem[3]  = {ADDI, 3'd0, 3'd4, 6'd20};   // 4114 | ADDI R4, R0, 20    (load value 20)
		mem[4]  = {SW,   3'd1, 3'd4, 6'd1};    // 7301 | SW   R4, 1(R1)      (mem[11] = 20)
		mem[5]  = {ADDI, 3'd0, 3'd4, 6'd15};   // 410F | ADDI R4, R0, 15    (load value 15)
		mem[6]  = {SW,   3'd1, 3'd4, 6'd2};    // 7302 | SW   R4, 2(R1)      (mem[12] = 15)
		
		// setup parameters and call the sum_array procedure
		mem[7]  = {ADDI, 3'd0, 3'd1, 6'd10};   // 404A | ADDI R1, R0, 10    (Parameter 1: R1 = array address)
		mem[8]  = {ADDI, 3'd0, 3'd2, 6'd3};    // 4083 | ADDI R2, R0, 3     (Parameter 2: R2 = element count)
		mem[9]  = {JAL,  12'd2};              // D002 | JAL 2             (Call procedure at address 11)
		
		// Halt program by jumping to self
		mem[10] = {J,    12'd0};              // C000 | J 0               (Infinite loop)
		
		// sum_array procedure: Starts at address 11
		// Inputs: R1 (address), R2 (count). Output: R3 (sum)
		mem[11] = {ADDI, 3'd0, 3'd3, 6'd0};    // 40C0 | ADDI R3, R0, 0     (Initialize sum = 0)
		
		// loop_start is at address 12
		mem[12] = {LW,   3'd1, 3'd4, 6'd0};    // 6300 | LW   R4, 0(R1)      (Load array element)
		mem[13] = {R_TYPE, 3'd3, 3'd4, 3'd3, ADD}; // 071C | ADD  R3, R3, R4     (Add to sum)
		mem[14] = {ADDI, 3'd1, 3'd1, 6'd1};    // 4241 | ADDI R1, R1, 1     (Increment address pointer)
		mem[15] = {ADDI, 3'd2, 3'd2, 6'b111111};  // 44BF | ADDI R2, R2, -1    (Decrement counter)
		mem[16] = {BNE,  3'd2, 3'd0, 6'b111100};  // B43C | BNE  R2, R0, 12     (Branch to loop_start if R2 != 0)
		
		// Return to caller
		mem[17] = {R_TYPE, 3'd7, 3'd0, 3'd0, JR};  // 0E07 | JR   R7             (Return) 	
		
		
		
		
		//----------------------------------------------------------------------------------------------------------------------------------------------------------------------
		
		
		
		
		
			// PART B -- TESTING EVERY INSTRUCTION 
		// R0=0, R1=1, R2=2, R3=3, R4=4, R5=5, R6=6, R7=7

		// Test Logical R-Type Instructions
		mem[30] = {ADDI, 3'd0, 3'd1, 6'd12};   // 404C | ADDI R1, R0, 12    (R1 = 12, or 0...1100)
		mem[31] = {ADDI, 3'd0, 3'd2, 6'd10};   // 408A | ADDI R2, R0, 10    (R2 = 10, or 0...1010)
		mem[32] = {R_TYPE, 3'd1, 3'd2, 3'd3, AND}; // 0298 | AND R3, R1, R2     (R3 should be 8)
		mem[33] = {R_TYPE, 3'd1, 3'd2, 3'd4, OR};  // 02A1 | OR  R4, R1, R2     (R4 should be 14)
		mem[34] = {R_TYPE, 3'd1, 3'd2, 3'd5, NOR}; // 02AA | NOR R5, R1, R2     (R5 should be -15)
		mem[35] = {R_TYPE, 3'd1, 3'd2, 3'd6, XOR}; // 02B3 | XOR R6, R1, R2     (R6 should be 6)

		// Test Arithmetic/Comparison R-Type Instructions
		mem[36] = {R_TYPE, 3'd1, 3'd2, 3'd7, SUB}; // 02BE | SUB R7, R1, R2     (R7 should be 2)
		mem[37] = {R_TYPE, 3'd2, 3'd1, 3'd3, SLT}; // 045D | SLT R3, R2, R1     (10 < 12 is true, R3 should be 1)
		mem[38] = {R_TYPE, 3'd1, 3'd2, 3'd4, SLT}; // 02A5 | SLT R4, R1, R2     (12 < 10 is false, R4 should be 0)

		// Test Logical/Comparison I-Type Instructions
		mem[39] = {ANDI, 3'd1, 3'd5, 6'd7};    // 8347 | ANDI R5, R1, 7     (12 & 7 = 4, R5 should be 4)
		mem[40] = {ORI,  3'd2, 3'd6, 6'd3};    // 9583 | ORI  R6, R2, 3     (10 | 3 = 11, R6 should be 11)
		mem[41] = {SLTI, 3'd1, 3'd7, 6'd20};   // 53D4 | SLTI R7, R1, 20    (12 < 20 is true, R7 should be 1)
		
		// Test Branch Instruction (BEQ)
		mem[42] = {ADDI, 3'd0, 3'd1, 6'd5};    // 4045 | ADDI R1, R0, 5
		mem[43] = {ADDI, 3'd0, 3'd2, 6'd5};    // 4085 | ADDI R2, R0, 5
		mem[44] = {BEQ, 3'd1, 3'd2, 6'd2};   // A282 | BEQ R1, R2, 46     (branch if equal)
		mem[45] = {ADDI, 3'd0, 3'd7, 6'd31};   // 41DF | ADDI R7, R0, 31    (should be skipped)
		mem[46] = {BNE, 3'd1, 3'd2, 6'd2};   // B282 | BNE R1, R2, 48     (branch if not equal, won't branch)
		mem[47] = {J, 12'd2};                     // C002 | J 49               (jump over next instruction)
		mem[48] = {ADDI, 3'd0, 3'd7, 6'd1};    // 41C1 | ADDI R7, R0, 1     (R7=1, jumped over)
		
		// Test LUI (Load Upper Immediate)
		// LUI loads the 12-bit immediate into the upper bits of R1, shifting it left by 4
		mem[49] = {LUI, 12'hABC};              // FABC | LUI 0xABC          (R1 should become 0xABC0)
		// combine with ORI to load a full 16-bit value
		mem[50] = {ORI, 3'd1, 3'd1, 6'hF};     // 924F | ORI R1, R1, 0xF    (R1 becomes 0xABCF)
		
		// loop at the end of the test suite
		mem[51] = {J, 12'd0};                     // C000 | J 50
	end

    always @* begin
        instruction = mem[inputPC];
    end

endmodule		 

module tb_instmem;

    reg [15:0] inputPC;
    wire [15:0] instruction;

    instmem uut (
        .inputPC(inputPC),
        .instruction(instruction)
    );	
	
	integer i;

    initial begin
        $monitor("inputPC=%h, instruction=%h", inputPC, instruction);
        inputPC = 16'h0000;											 
		for(i = 1; i < 10; i = i+1) begin
			
        #10 inputPC = inputPC + 1;
		end
        #10 $finish;
    end

endmodule
