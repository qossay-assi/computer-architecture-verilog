//-----------------------------------------------------------------------------
//
// Title       : 
// Design      : arch2
// Author      : 
// Company     : 
//
//-----------------------------------------------------------------------------
//
// Local workstation path omitted.
// Generated   : Wed Sep 17 20:27:45 2025
// Local workstation path omitted.
// By          : Bde2Verilog ver. 2.01
//
//-----------------------------------------------------------------------------
//
// Description : 
//
//-----------------------------------------------------------------------------

`ifdef _VCP
`else
`define library(a,b)
`endif


// ---------- Design Unit Header ---------- //
`timescale 1ps / 1ps

module design2 (clk) ;

// ------------ Port declarations --------- //
input clk;
wire clk;

// ----------- Signal declarations -------- //
wire NET10369;
wire NET10649;
wire NET10677;
wire NET10857;
wire NET10876;
wire NET11018;
wire NET11063;
wire NET11382;
wire NET11473;
wire [15:0] BUS10048;
wire [15:0] BUS10304;
wire [3:0] BUS10409;
wire [2:0] BUS10448;
wire [2:0] BUS10482;
wire [3:0] BUS10596;
wire [1:0] BUS10684;
wire [1:0] BUS11026;
wire [15:0] BUS11801;
wire [15:0] BUS9015;
wire [15:0] BUS9043;
wire [2:0] BUS9050;
wire [2:0] BUS9058;
wire [2:0] BUS9062;
wire [2:0] BUS9105;
wire [15:0] BUS9173;
wire [5:0] BUS9224;
wire [11:0] BUS9237;
wire [15:0] BUS9269;
wire [15:0] BUS9298;
wire [15:0] BUS9352;
wire [15:0] BUS9418;
wire [15:0] BUS9433;
wire [15:0] BUS9462;
wire [15:0] BUS9493;

// -------- Component instantiations -------//

// synthesis translate_off
`library("U10","arch2")
// synthesis translate_on
adder U10
(
	.in1(BUS11801),
	.in2(BUS9352),
	.out(BUS10304)
);



mux2x1 U11
(
	.a(BUS9462),
	.b(BUS9352),
	.sel(NET11018),
	.out(BUS9269)
);



// synthesis translate_off
`library("U12","arch2")
// synthesis translate_on
datamem U12
(
	.clk(clk),
	.address(BUS9418),
	.datain(BUS9462),
	.memwrite(NET10649),
	.dataout(BUS9493)
);



alu U13
(
	.operandA(BUS9173),
	.operandB(BUS9269),
	.opcode(BUS10596),
	.func(BUS10482),
	.result(BUS9418),
	.takeBranch(NET10369)
);



// synthesis translate_off
`library("U14","arch2")
// synthesis translate_on
mux2x1_3bit U14
(
	.in1(BUS9062),
	.in2(BUS9105),
	.sel(NET10876),
	.out(BUS9058)
);



mux2x1 U17
(
	.a(BUS10048),
	.b(BUS10304),
	.sel(NET10369),
	.out(BUS9298)
);



PCreg U2
(
	.clk(clk),
	.en(NET10677),
	.in(BUS9015),
	.out(BUS11801)
);



mux3x1 U21
(
	.a(BUS9418),
	.b(BUS9493),
	.c(BUS10048),
	.sel(BUS11026),
	.out(BUS9433)
);



ControlUnit U24
(
	.instructionOpcode(BUS10409),
	.instructionFunction(BUS10448),
	.PCwrite(NET10677),
	.memoryWrite(NET10649),
	.RdWrite(NET10857),
	.RdInput(NET10876),
	.PCinput(BUS10684),
	.RdDataInput(BUS11026),
	.operandBinput(NET11018),
	.extenderInput(NET11063),
	.R7(NET11382),
	.R1(NET11473),
	.ALUopcode(BUS10596),
	.ALUfunction(BUS10482)
);



instmem U3
(
	.inputPC(BUS11801),
	.instruction(BUS9043)
);



mux4x1 U4
(
	.a(BUS10048),
	.b(BUS9173),
	.c(BUS9298),
	.d(BUS10304),
	.sel(BUS10684),
	.out(BUS9015)
);



PCinc U5
(
	.inputPC(BUS11801),
	.outPC(BUS10048)
);



extender_mux U7
(
	.in1(BUS9224),
	.in2(BUS9237),
	.sel(NET11063),
	.out(BUS9352)
);



InstructionRegister U8
(
	.instruction(BUS9043),
	.R7(NET11382),
	.R1(NET11473),
	.opcode(BUS10409),
	.rs(BUS9050),
	.rt(BUS9105),
	.rd(BUS9062),
	.fn(BUS10448),
	.imm6(BUS9224),
	.imm12(BUS9237)
);



registers U9
(
	.clk(clk),
	.en(NET10857),
	.rs(BUS9050),
	.rt(BUS9105),
	.rd(BUS9058),
	.BUSW(BUS9433),
	.BUSA(BUS9173),
	.BUSB(BUS9462)
);



endmodule 
