
//  Module: ahb_design_top
//

`timescale 1ns/1ps

module ahb_design_top
  /*  package imports  */
  #(
    parameter BUS_WIDTH=32,
    parameter DATA_WIDTH=32
  )(
    ahb_if ahb_design_top_if
  );
  // User defined parameters -----------

  // user defined Ports ----------------

  // Parameters ------------------------

  // INPUT Signals // interface implementation ---------------------

  always @(posedge ahb_design_top_if.HCLK) ahb_design_top_if.HADDR <= 'h0;

  // Internal signals

  // FLOP signals


  
endmodule: ahb_design_top
