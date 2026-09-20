module InstructionRegister(
	input wire [15:0] instruction,
	input wire R7,
	input wire R1,
	output reg [3:0] opcode,
	output reg [2:0] rs,
	output reg [2:0] rt,
	output reg [2:0] rd,
	output reg [2:0] fn,
	output reg [5:0] imm6,
	output reg [11:0] imm12
);

always @* begin
	opcode = instruction[15:12];
	rs = instruction[11:9];
	rt = instruction[8:6];
	rd = instruction[5:3];
	fn = instruction[2:0];
	imm6 = instruction[5:0];
	imm12 = instruction[11:0];
	
	if(R7) begin
		rd = 3'b111;
	end				
	
	if(R1) begin
		rd = 3'b001;
	end
end
endmodule			

module tb_InstructionRegister;
    reg [15:0] instruction;
	reg R7;
	reg R1;
    wire [3:0] opcode;
	wire [2:0] rs, rt, rd, fn;
	wire [5:0] imm6;
	wire [11:0] imm12;

    InstructionRegister uut (
		.instruction(instruction),
		.R7(R7),
		.R1(R1),
	    .opcode(opcode),
	    .rs(rs),
		.rt(rt),
		.rd(rd),
		.fn(fn),
		.imm6(imm6),
		.imm12(imm12)
    );

    initial begin
        $monitor("instruction=%h, opcode=%b, rs=%b, rt=%b, rd=%b, fn=%b, imm6=%b, imm12=%b", instruction, opcode, rs, rt, rd, fn, imm6, imm12);
        instruction = 16'hF123;
        #10 instruction = 16'hA456;
		#10 R7 = 1'b1;
		#10;
		R7 = 1'b0; R1 = 1'b1;
        #10 $finish;
    end
endmodule