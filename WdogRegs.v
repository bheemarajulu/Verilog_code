`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:51:38 06/05/2015 
// Design Name: 
// Module Name:    WdogRegs 
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
//////////////////////////////////////////////////////////////////////////////////
module WdogRegs(
input CLK, KICK,Wdog_TimerEn, Wdog_Timer_disable, WRITE,
input  [31:0] WDATA,
input  [3:0] ADDR,
output [31:0] RDATA,
input Wdog_Timer_CLK
    );

reg [1:0] fsm; //state machine register
reg fsm_tclk; 
reg [31:0]   RDATA;

// Timer
reg [31:0] Counter;
reg [31:0] Load;
reg TimerEn;   // Timer enable

// To enable watchdog 
reg Status_Register; // Status register
reg [31:0] step1; // write address 0x01
reg [31:0] step2; // Read from Address 0x0A
reg [31:0] step3; // write address 0x0F
// Disable sequence in reverse 

// Watchdog timeout sequence for kick 
reg [31:0] key1; // write address 0xAA
reg [31:0] key2; // Read from Address 0x0E
reg [31:0] key3; // write address 0x55
// Disable sequence in reverse 

module tri_buf (write,read,enable);       
        
endmodule
