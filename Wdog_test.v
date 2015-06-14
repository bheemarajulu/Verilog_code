`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:20:14 06/05/2015 
// Design Name: 
// Module Name:    Wdog_test 
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
// 1.	 "Wdog.v" will be the top level module that will accept a 4 bit address, 
// 32 bit data, clock, read, write, and provide a reset output.  It will also
// instantiate all lower level modules for the design.
//////////////////////////////////////////////////////////////////////////////////
module Wdog_test(
input CLK, KICK,Wdog_TimerEn, Wdog_Timer_disable, WRITE,
input  [31:0] WDATA,
input  [3:0] ADDR,
output [31:0] RDATA,
input Wdog_Timer_CLK
    );        

WdogDecode comp1
		(.CLK(CLK), .Wdog_TimerEn(Wdog_TimerEn), Wdog_Timer_disable(Wdog_Timer_disable), .KICK(KICK),
       .WRITE(WRITE), .ADDR(ADDR));

WdogSM comp2
		(.CLK(CLK), .Wdog_TimerEn(Wdog_TimerEn), Wdog_Timer_disable(Wdog_Timer_disable), .KICK(KICK),
       .WRITE(WRITE), .ADDR(ADDR));


WdogRegs comp3
		(.CLK(CLK), .Wdog_TimerEn(Wdog_TimerEn), Wdog_Timer_disable(Wdog_Timer_disable), .KICK(KICK),
       .WRITE(WRITE), .ADDR(ADDR));


WdogTimer comp4
		(.CLK(CLK), .Wdog_TimerEn(Wdog_TimerEn), Wdog_Timer_disable(Wdog_Timer_disable), .KICK(KICK),
       .WRITE(WRITE), .ADDR(ADDR));

endmodule
