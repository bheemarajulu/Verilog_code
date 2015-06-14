`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:51:18 06/05/2015 
// Design Name: 
// Module Name:    WdogSM 
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
// "WdogSM.v" will implement the Watch Dog state machine control function.
//////////////////////////////////////////////////////////////////////////////////
module WdogSM(
input CLK, KICK,Wdog_TimerEn, Wdog_Timer_disable, WRITE,
input  [31:0] WDATA,
input  [3:0] ADDR,
output [31:0] RDATA,
input Wdog_Timer_CLK
    );

reg Wdog_ENABLE;
reg WRITE;
reg [3:0] ADDR;
reg [31:0] WDATA;
reg [1:0] fsm; //state machine 
reg fsm_tclk;  
reg [31:0]   RDATA;

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
        
  

// Wachdog timer enable or diable 
always@(posedge Wdog_Timer_CLK or negedge KICK)
if(~KICK)
  begin
  TimerEn <= 1'b0;   
  end
else
  begin
  TimerEn <= 0'b0;   
	 end

// Watchdog Enable Sequence 
always@(posedge Wdog_Timer_CLK or negedge KICK)
if(~KICK)
  begin
      fsm <= 2'b00;
      Wdog_ENABLE <= 1'b1;
      end
else
  begin
  case (fsm)
     2'b00 :  begin
                  step1 <= 4'h01; // Write to address 0x01
						WDATA <= step1; // write data
						ADDR <= WDATA;
						fsm <= 2'b01;   // Next step to read                   
               end

     2'b01 :  begin
                  step2 <= 4'h01; // Read from address 0x0A
						RDATA <= step2; // read data
						RDATA <= ADDR;
						fsm <= 2'b10;   // Next step to write                   
               end

     2'b10 :  begin
                  step3 <= 4'h0F; // Write to address 0x0F
						WDATA <= step3; // write data
						ADDR <= WDATA;
						fsm <= 2'b11;   // Next step to write                   
               end

     2'b11 :  begin 
					 Wdog_ENABLE <= 1'b0; // Watchdog enabled
                fsm <= 2'b00;
              end

    default : fsm <= 2'b00;
  endcase
end

// Watchdog Disable Sequence 
always@(posedge Wdog_Timer_CLK or negedge KICK)
if(~KICK)
  begin
      fsm <= 2'b00;
      Wdog_ENABLE <= 1'b1;
      end
else
  begin
  case (fsm)
     2'b00 :  begin
                  step1 <= 4'h0F; // Write to address 0x0F
						WDATA <= step1; // write data
						ADDR <= WDATA;
						fsm <= 2'b01;   // Next step to read                   
               end

     2'b01 :  begin
                  step2 <= 4'h0A; // Read from address 0x0A
						RDATA <= step2; // read data
						RDATA <= ADDR;
						fsm <= 2'b10;   // Next step to write                   
               end

     2'b10 :  begin
                  step3 <= 4'h01; // Write to address 0x01
						WDATA <= step3; // write data
						ADDR <= WDATA;
						fsm <= 2'b11;   // Next step to write                   
               end

     2'b11 :  begin 
					 Wdog_ENABLE <= 0'b0; // Watchdog Disabled
                fsm <= 2'b00;
              end

    default : fsm <= 2'b00;
  endcase
end

// Watchdog Kick sequence 0xE--> 0xAA & 0x55 --> 0x55 
// Watchdog timeout sequence for kick 
always@(posedge Wdog_Timer_CLK or negedge KICK)
if(~KICK)
  begin
      fsm <= 2'b00;
      Wdog_ENABLE <= 1'b1;
      end
else
  begin
  case (fsm)
     2'b00 :  begin
                  key1 <= 4'hAA; // Write to address 0xAA
						WDATA <= step1; // write data
						ADDR <= WDATA;
						fsm <= 2'b01;   // Next step to read                   
               end

     2'b01 :  begin
                  step2 <= 4'h0E; // Read from address 0x0E
						RDATA <= step2; // read data
						RDATA <= ADDR;
						fsm <= 2'b10;   // Next step to write                   
               end

     2'b10 :  begin
                  step3 <= 4'h55; // Write to address 0x55
						WDATA <= step3; // write data
						ADDR <= WDATA;
						fsm <= 2'b11;   // Next step to write                   
               end

     2'b11 :  begin 
					 Wdog_Timer_disable <= 0'b1; // Watchdog Timer to zero
                fsm <= 2'b00;
              end

    default : fsm <= 2'b00;
  endcase
end
endmodule
