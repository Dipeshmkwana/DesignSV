//  Interface: ahb_intrfc
//
interface ahb_if
  /*  package imports  */
  #(
    parameter BUS_WIDTH=32,
    parameter DATA_WIDTH=32
  )(
    input logic HCLK,
    input logic HRESETn

  );

  logic [BUS_WIDTH-1:0]  HADDR;
  logic [2:0]   HBURST;
  logic         HMASTLOCK;
  logic [6:0]   HPROT;
  logic [2:0]   HSIZE;
  logic         HNONSEC;
  logic         HEXCL;
  logic [3:0]   HMASTER;
  logic [1:0]   HTRANS;
  logic [DATA_WIDTH-1:0]  HWDATA;
  logic         HWRITE;

  logic [DATA_WIDTH-1:0]  HRDATA;
  logic         HREADYOUT;
  logic         HRESP;
  logic         HEXOKAY;
  logic         HSELx;

  
endinterface: ahb_if
