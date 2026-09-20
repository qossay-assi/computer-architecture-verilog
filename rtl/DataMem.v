module datamem(				  
	input wire clk,
	input wire [15:0] address,
	input wire [15:0] datain,
	input wire memwrite, 
	output reg [15:0] dataout
);			  

	reg [15:0] mem[31:0];  
	
	initial begin
		for (int i = 0; i < 32; i = i + 1) begin
			mem[i] = 16'd0;
		end
	end
	
	always @(posedge clk) begin
		if (memwrite) begin	
			mem[address] <= datain;
		end
	end	   
	
	always @* begin
		dataout = mem[address];
	end
endmodule			 

module tb_datamem;
  
  reg clk;
  reg [15:0] address;
  reg [15:0] datain;
  reg memread;
  reg memwrite;

  wire [15:0] dataout;

  datamem uut (
    .clk(clk),
    .address(address),
    .datain(datain),
    .memwrite(memwrite),
    .dataout(dataout)
  );

  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  initial begin	 
	  
	$monitor("clk=%h address=%h datain=%h memread=%h memwrite=%h dataout=%h", clk, address, datain, memread, memwrite, dataout);
    address = 0;
    datain = 0;
    memwrite = 0;

    #10;

    // write to address 0
    address = 16'h0000;
    datain = 16'hABCD;
    memwrite = 1'b1;
    #10;
    memwrite = 1'b0;
    #10;

    // write to address 10
    address = 16'h000A;
    datain = 16'hFFFF;
    memwrite = 1'b1;
    #10;
    memwrite = 1'b0;
    #10;

    // read from address 0
    address = 16'h0000;
    #10;

    // read from address 10
    address = 16'h000A;
    $finish;
  end

endmodule

