module ControlUnit(
    input  wire [3:0] instructionOpcode, 
    input  wire [2:0] instructionFunction,
    output reg  PCwrite,
    output reg  memoryWrite,
    output reg  RdWrite,
    output reg  RdInput,
    output reg  [1:0] PCinput,
    output reg  [1:0] RdDataInput,
    output reg  operandBinput,
	output reg	extenderInput,
	output reg 	R7,
	output reg 	R1,
    output wire [3:0] ALUopcode,
    output wire [2:0] ALUfunction
);   

assign ALUfunction = instructionFunction;
assign ALUopcode   = instructionOpcode;

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

always @(*) begin
    PCwrite     = 1'b1;
    memoryWrite = 1'b0;
    RdWrite    = 1'b0;
    RdInput       = 2'b00;
    PCinput    = 2'b00;
    RdDataInput  = 2'b00;
    operandBinput   = 1'b0;
	R7	=	1'b0;
	R1	=	1'b0;
	extenderInput	=	1'b0;

    case(instructionOpcode)
        R_TYPE: begin
            RdInput      = 1'b0;
            RdDataInput = 2'b00;
            operandBinput  = 1'b0;
            if(instructionFunction == JR) begin
                PCinput = 2'b01;
                PCwrite  = 1'b1;
                RdWrite = 1'b0;
            end else begin
                RdWrite = 1'b1;
                PCinput = 2'b00;
            end
        end

        ANDI, ADDI, SLTI, ORI: begin
            RdInput      = 1'b1;
            RdDataInput = 2'b00;
            operandBinput  = 1'b1;
            RdWrite   = 1'b1;
            PCinput   = 2'b00;
        end

        LW: begin
            RdInput      = 1'b1;
            RdDataInput = 2'b01;
            operandBinput  = 1'b1;
            RdWrite   = 1'b1;
            PCinput   = 2'b00;
        end

        SW: begin
            operandBinput   = 1'b1;
            memoryWrite = 1'b1;
            PCinput    = 2'b00;
        end

        BEQ, BNE: begin
            operandBinput = 1'b0;
            PCinput  = 2'b10;
        end

        J: begin
            PCinput = 2'b11;
			extenderInput = 1'b1;
        end

        JAL: begin
            PCinput   = 2'b11;
            RdInput      = 1'b0;
            RdDataInput = 2'b10;
            RdWrite   = 1'b1;
			R7	=	1'b1; 
			extenderInput = 1'b1;
        end

        LUI: begin
            RdInput      = 1'b0;
            RdDataInput = 2'b00;
            operandBinput  = 1'b1;
            RdWrite   = 1'b1;
			R1	=	1'b1;
			extenderInput = 1'b1;
        end
    endcase
end

endmodule