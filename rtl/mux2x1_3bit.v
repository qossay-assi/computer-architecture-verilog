module mux2x1_3bit(
	input wire [2:0] in1,
	input wire [2:0] in2,
	input wire sel,
	output wire [2:0] out
);

assign out = (sel == 0) ? in1 : in2;
endmodule	