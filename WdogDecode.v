`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:51:00 06/05/2015 
// Design Name: 
// Module Name:    WdogDecode 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
// "WdogDecode.v" will decode the address inputs to the module.
//
//////////////////////////////////////////////////////////////////////////////////
module WdogDecode(
input CLK, KICK,Wdog_TimerEn, Wdog_Timer_disable, WRITE,
input  [31:0] WDATA,
input  [3:0] ADDR,
output [31:0] RDATA,
input Wdog_Timer_CLK
    );

reg [31:0]   RDATA;
reg Interval_valid; // Register Load enable

// To enable watchdog 
reg Status_Register; // Status register
  

always @*
case (ADDR)
         4'h0: RDATA = Status_Register;
         4'h1: RDATA = Interval_valid;
         4'h2: RDATA = 8'bxxxxxxxx; 
         4'h3: RDATA = 8'bxxxxxxxx;
         4'h4: RDATA = 8'bxxxxxxxx;
         4'h5: RDATA = 8'bxxxxxxxx;
         4'h6: RDATA = 8'bxxxxxxxx;
         4'h7: RDATA = 8'bxxxxxxxx;
         4'h8: RDATA = 8'bxxxxxxxx;
         4'h9: RDATA = 8'bxxxxxxxx;
         4'ha: RDATA = 8'bxxxxxxxx;
         4'hb: RDATA = 8'bxxxxxxxx;
         4'hc: RDATA = 8'bxxxxxxxx;
         4'hd: RDATA = 8'bxxxxxxxx;
         4'he: RDATA = 8'bxxxxxxxx;
         4'hf: RDATA = 8'bxxxxxxxx;
			4'h55: RDATA = 8'bxxxxxxxx;
      endcase
endmodule
