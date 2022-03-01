/* -.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-. 
* File Name     : interface.sv
* File Directory: Master
* Description   : 
* Author        : dipesh makwana 
* Creation Date : 28-05-2019
* Last Modified : Mon 24 Jun 2019 05:14:43 PM +0530
* Organization  : Eitra 
* Copyright (c) 2019 Eitra. All rights reserved.
* -.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-. */ 
`ifndef APB_MS_IF_SV
  `define APB_IF_SV
  `ifndef APB_MS_MX_DATA_WIDTH
    `define APB_MS_MX_DATA_WIDTH 32
  `endif
  `ifndef APB_MS_MX_ADDR_WIDTH
    `define APB_MS_MX_ADDR_WIDTH 32
  `endif
  `define APB_MS_PROT_WIDTH 3

	`ifndef APB_MS_MAX_STROBE_WIDTH
		`define APB_MS_MAX_STROBE_WIDTH 2
	`endif

	`ifndef APB_MS_MAX_SEL_WIDTH
		`define APB_MS_MAX_SEL_WIDTH 16
	`endif
interface apb3_s_intf(input logic PCLK,PRESETn);

  logic                                 PSLVERR;
  logic                                 PREADY;
  logic                                 PWRITE;
  logic                                 PENABLE;
  logic                                 PSELx;
  logic [`APB_MS_MX_ADDR_WIDTH-1:0]     PADDR;
  logic [`APB_MS_MX_DATA_WIDTH-1:0]     PWDATA;
  logic [`APB_MS_MX_DATA_WIDTH-1:0]     PRDATA;
  logic [`APB_MS_MAX_STROBE_WIDTH-1:0]  PSTRB;
  logic [`APB_MS_PROT_WIDTH-1:0]        PPROT;

  modport s_drv(output PSLVERR,PRDATA,PREADY,input PCLK,PRESETn,PSELx,PWRITE,PADDR,PWDATA,PENABLE,PSTRB);
  modport s_mon(input PCLK,PRESETn,PSLVERR,PRDATA,PREADY,PSELx,PWRITE,PADDR,PWDATA,PENABLE,PSTRB);



////////////////////////  assertion  ////////////////////////////////////

sequence apb_idle;
  !PSELx;
endsequence

sequence apb_phase_1;
  PSELx && !PENABLE && !PREADY;
endsequence

sequence apb_phase_2;
  PSELx && PENABLE;
endsequence

sequence apb_pready;
  PREADY;
endsequence


sequence apb_no_wait_cycle;
  apb_phase_1 ##1 apb_phase_2;
endsequence

sequence apb_wait_cycle;
  apb_phase_1 ##1 apb_phase_2;
endsequence

sequence apb_read_cycle_with_no_wait;
  (!PWRITE) throughout apb_no_wait_cycle;
endsequence

sequence apb_read_cycle_with_wait;
  (!PWRITE && !PREADY) throughout apb_wait_cycle;
endsequence

sequence apb_write_cycle_with_no_wait;
  (PWRITE) throughout apb_no_wait_cycle;
endsequence
 
sequence apb_write_cycle_with_wait;
  (PWRITE && !PREADY) throughout apb_wait_cycle;
endsequence

//to check idle cycle
property idle_cycle;
@(posedge PCLK) (apb_idle);
endproperty

property apb_cycle_are_complete;
    // Once a cycle has started, it must complete
    @(posedge PCLK) ((PSELx && !PENABLE) |-> apb_no_wait_cycle);
endproperty


property apb_no_penable_outside_cycle2;
    // If we see PENABLE, it must be in the second clock of a cycle,and it must then go away
    @(posedge PCLK) (PENABLE |-> $stable(PSELx) ##1 (!PENABLE));
endproperty

property apb_write_and_addr_stable;
    // PWRITE and PADDR must be stable throughout the cycle
    @(posedge PCLK) ((PSELx && PENABLE) |-> $stable({PWRITE, PADDR}));
endproperty

property apb_write_data_stable;
    // PWDATA must be stable throughout a write cycle
    @(posedge PCLK) ((PREADY && PENABLE && PWRITE) |-> $stable(PWDATA));
endproperty

property apb_complete_cycles_with_valid_addr;
    // PWRITE and PADDR must be valid throughout the cycle (no X, Z)
    @(posedge PCLK) ( (PSELx && !PENABLE && !PREADY) |->
                    ( ((^{PWRITE, PADDR}) !== 1'bx) throughout apb_no_wait_cycle)
                    );
endproperty

property for_extended_write_transfer;
// for write extended transfer PSELx,PWRITE,PADDR,PWDATA,PREADY should be stable throughout wait cycle and after wait cycle PREADY should rise
  @(posedge PCLK)
 apb_write_cycle_with_wait|-> $stable({PSELx,PWRITE,PADDR,PWDATA,PREADY }) ##[1:16] $rose(PREADY);
endproperty

property for_extended_read_transfer;
// for read extended transfer PSELx,PWRITE,PADDR,PWDATA,PREADY should be stable throughout wait cycle and after wait cycle PREADY should rise
  @(posedge PCLK)
 apb_read_cycle_with_wait|-> $stable({PSELx,!PWRITE,PADDR,PWDATA,PREADY }) ##[1:16] $rose(PREADY);
endproperty

property for_no_extended_write_transfer;
// for write no extended transfer if PSELx,PWRITE,PENABLE is high PREADY should be 1 and after one clock cycle PREADY should be zero
  @(posedge PCLK) (apb_write_cycle_with_no_wait|->PREADY==1 ##1 PREADY==0);
endproperty

property for_no_extended_read_transfer;
// for read no extended transfer if PSELx,PWRITE,PENABLE is high PREADY should be 1 and after one clock cycle PREADY should be zero
  @(posedge PCLK) (apb_read_cycle_with_no_wait|->PREADY==1 ##1 PREADY==0);
endproperty


  // Assertions to check the safety properties
  for_idle_cycle    : assert property (idle_cycle);
  cycles_complete   : assert property (apb_cycle_are_complete);
  penable_valid     : assert property (apb_no_penable_outside_cycle2);
  controls_stable   : assert property (apb_write_and_addr_stable);
  write_data_stable : assert property (apb_write_data_stable);
  complete_cycle_with_valid_addr  : assert property (apb_complete_cycles_with_valid_addr);
  extended_write_transfer : assert property(for_extended_write_transfer);
  extended_read_transfer : assert property(for_extended_read_transfer); 
  no_extended_write_transfer : assert property(for_no_extended_write_transfer);
  no_extended_read_transfer : assert property(for_no_extended_read_transfer);
  

endinterface
`endif
