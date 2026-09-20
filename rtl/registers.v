module registers(
	input clk,
	input wire en,
	input wire [2:0] rs,
	input wire [2:0] rt,
	input wire [2:0] rd,
	input wire [15:0] BUSW,
	output reg [15:0] BUSA,
	output reg [15:0] BUSB
);		

	reg [15:0] register [7:0];	
	integer i;
	
	initial begin
		for (i = 0; i < 8; i = i + 1) begin
			register[i] = 16'd0;
		end
	end

	always @(posedge clk) begin
		if (en && (rd != 3'b000)) begin
			register[rd] <= BUSW;
		end		   			   
	end	
	
	always @* begin
		BUSA = register[rs];
		BUSB = register[rt];
	end
	
endmodule		

module tb_registers;
    reg clk, en;
    reg [2:0] rs, rt, rd;
    reg [15:0] BUSW;
    wire [15:0] BUSA, BUSB;	 

    registers uut (
        .clk(clk),
        .en(en),
        .rs(rs),
        .rt(rt),
        .rd(rd),
        .BUSW(BUSW),
        .BUSA(BUSA),
        .BUSB(BUSB)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        $monitor("clk=%b, en=%b, rs=%b, rt=%b, rd=%b, BUSW=%h, BUSA=%h, BUSB=%h, reg[rs]=%h, reg[rt]=%h, reg[rd]=%h", clk, en, rs, rt, rd, BUSW, BUSA, BUSB, uut.register[rs], uut.register[rt], uut.register[rd]);
        en = 1; rd = 3'b000; BUSW = 16'hAAAA;
        #10 rs = 3'b001; rt = 3'b000;
        #10 rd = 3'b010; BUSW = 16'h5555;
        #10 rs = 3'b010; rt = 3'b001;
        #10 $finish;
    end
endmodule
