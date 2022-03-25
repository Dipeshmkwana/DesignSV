`ifndef AHB_TOP_SV
`define AHB_TOP_SV

`include "ahb_test_pkg.sv"
`timescale 1ns/1ps

module top_tb;
  //import uvm pkg

  //declaration

  bit          HCLK;
  bit          HRESETn;

  wire [31:0]  HADDR;
  wire [2:0]   HBURST;
  wire         HMASTLOCK;
  wire [6:0]   HPROT;
  wire [2:0]   HSIZE;
  wire         HNONSEC;
  wire         HEXCL;
  wire [3:0]   HMASTER;
  wire [1:0]   HTRANS;
  wire [31:0]  HWDATA;
  wire         HWRITE;

  wire [31:0]  HRDATA;
  wire         HREADYOUT;
  wire         HRESP;
  wire         HEXOKAY;

  wire         HSELx;

  //interface declaration
  

  // environment instance 

  // DUT instance 

  //Clock init

  //UVM Start up

  //Dump waves

endmodule : top_tb

