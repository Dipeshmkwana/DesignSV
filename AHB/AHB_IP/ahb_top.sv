
//  Module: ahb_top
//

`timescale 1ns/1ps


module ahb_top
  /*  package imports  */
  #(
    parameter BUS_WIDTH=32,
    parameter DATA_WIDTH=32
  )(
    HCLK,
    HRESETn,

    HADDR,
    HBURST,
    HMASTLOCK,
    HPROT,
    HSIZE,
    HNONSEC,
    HEXCL,
    HMASTER,
    HTRANS,
    HWDATA,
    HWRITE,

    HRDATA,
    HREADYOUT,
    HRESP,
    HEXOKAY,

    HSELx
  );
  // User defined parameters -----------

  // user defined Ports ----------------

  // Parameters ------------------------

  // INPUT Signals ---------------------

  input         HCLK;
  input         HRESETn;
  input [BUS_WIDTH-1:0]  HADDR;
  input [2:0]   HBURST;
  input         HMASTLOCK;
  input [6:0]   HPROT;
  input [2:0]   HSIZE;
  input         HNONSEC;
  input         HEXCL;
  input [3:0]   HMASTER;
  input [1:0]   HTRANS;
  input [DATA_WIDTH-1:0]  HWDATA;
  input         HWRITE;

  input [DATA_WIDTH-1:0]  HRDATA;
  input         HREADYOUT;
  input         HRESP;
  input         HEXOKAY;
  input         HSELx;

  // Internal signals

  // FLOP signals


  
endmodule: ahb_top
