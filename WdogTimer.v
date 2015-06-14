`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:51:56 06/05/2015 
// Design Name: 
// Module Name:    WdogTimer 
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
// Changing of the interval will only be allowed when the Watch Dog Timer is in the disabled state.
//////////////////////////////////////////////////////////////////////////////////

module WdogTimer(
input CLK, KICK,Wdog_TimerEn, Wdog_Timer_disable, WRITE,
input  [31:0] WDATA,
input  [3:0] ADDR,
output [31:0] RDATA,
input Wdog_Timer_CLK
    );

reg READY;
reg [1:0] fsm; //state machine 
reg fsm_tclk;  
reg [31:0]   RDATA;

// Timer
reg [31:0] Counter;
reg [31:0] Load;
reg TimerEn;   // Timer enable
reg LoadEnReg; // Register Load enable

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
        
         

always@(posedge Wdog_Timer_CLK or negedge KICK)
if(~KICK)
  begin
    Counter <= 32'h00000000;
  end
else
  begin
    if(Wdog_Timer_disable == 1'b1)
      begin
        Counter <= 32'h00000000;
      end
    else if(Wdog_TimerEn == 1'b1)
      begin
        if(Counter == Load) // load Interval 0x00000001 to 0xFFFFFFFF
          begin
            Counter <= 32'h00000000;
          end
        else
          begin
            Counter <= Counter + 1;
          end
      end
  end

endmodule
