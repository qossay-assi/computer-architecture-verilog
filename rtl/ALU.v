module alu (
    input wire [15:0] operandA,  
    input wire [15:0] operandB, 
    input wire [3:0] opcode,    
    input wire [2:0] func,       
    
    output reg [15:0] result, 
    output reg takeBranch      
);

    parameter R_TYPE = 4'b0000;
    parameter AND = 3'b000;
    parameter OR = 3'b001;
    parameter NOR = 3'b010;
    parameter XOR = 3'b011;
    parameter ADD = 3'b100;
    parameter SLT = 3'b101;
    parameter SUB = 3'b110;
    parameter JR = 3'b111;
    parameter ANDI = 4'b1000;
    parameter ORI = 4'b1001;
    parameter ADDI = 4'b0100;
    parameter SLTI = 4'b0101;
    parameter LW = 4'b0110;
    parameter SW = 4'b0111;
    parameter BEQ = 4'b1010;
    parameter BNE = 4'b1011;
    parameter J = 4'b1100;
    parameter JAL = 4'b1101;
    parameter LUI = 4'b1111;

    always @* begin
        result = 16'b0;
        takeBranch = 1'b0;

        case(opcode)
            R_TYPE: begin
                case(func)
                    ADD:  result = operandA + operandB;
                    SUB:  result = operandA - operandB;
                    AND:  result = operandA & operandB;
                    OR:   result = operandA | operandB;
                    SLT:  result = operandA < operandB ? 16'd1 : 16'd0;
                    JR:   result = operandA;	 
					XOR:	result = operandA ^ operandB;
					NOR:	result = ~(operandA | operandB);
                    default: begin
                        result = 16'b0;
                    end
                endcase
            end
            
            ADDI:    result = operandA + operandB;
            ANDI:    result = operandA & operandB;
            ORI:     result = operandA | operandB;
            SLTI:    result = operandA < operandB ? 16'd1 : 16'd0;

            LW:      result = operandA + operandB;
            SW:      result = operandA + operandB;
            
            BEQ:     takeBranch = (operandA == operandB);
            BNE:     takeBranch = (operandA != operandB);

            J:       result = operandA + operandB;
            JAL:     result = operandA + operandB;	
			LUI:     result = {operandB[11:0], 4'b0000};
            
            default: begin
                result = 16'b0;
                takeBranch = 1'b0;
            end
        endcase
    end
endmodule