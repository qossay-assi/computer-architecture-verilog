module extender_mux(
	input wire [5:0] in1,
	input wire [11:0] in2,
	input wire sel,
	output reg [15:0] out
);

	always @* begin
		if (sel == 0) begin
			out[5:0] = in1[5:0];	
			out[15:6] = {10{in1[5]}};
		end else begin
			out[11:0] = in2[11:0];	
			out[15:12] = {4{in2[11]}};
		end
	end
endmodule	   

module tb_extender_mux;
    reg [5:0] in1;
	reg [11:0] in2;
	reg sel;
    wire [15:0] out;

    extender_mux uut (
		.in1(in1), 
		.in2(in2),
		.sel(sel),
        .out(out)
    );

    initial begin
        $monitor("in1=%b, in2=%b, sel=%b, out=%b", in1, in2, sel, out);
        in1 = 6'b101010;
		in2 = 12'h800;	 
		sel = 0;
        #10 in1 = 6'b010101;
		#10 sel = 1;
		#10 in2 = 12'h0ff;
        #10 $finish;
    end
endmodule
