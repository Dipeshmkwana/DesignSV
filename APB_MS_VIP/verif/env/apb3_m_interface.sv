/* -.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-. 
* File Name     : interface.sv
* File Directory: Master
* Description   : 
* Author        : dipesh makwana 
* Creation Date : 28-05-2019
* Last Modified : Tue 11 Jun 2019 02:00:36 PM +0530
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
interface apb3_m_intf(input logic PCLK,PRESETn);

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

  modport m_drv(output PSELx,PWRITE,PADDR,PWDATA,PENABLE,PSTRB,input PCLK,PRESETn,PSLVERR,PRDATA,PREADY);
  modport m_mon(input PCLK,PRESETn,PSLVERR,PRDATA,PREADY,PSELx,PWRITE,PADDR,PWDATA,PENABLE,PSTRB);

endinterface
`endif
