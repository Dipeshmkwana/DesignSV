
//  Module: ahb_design_top
//

`timescale 1ns/1ps

module ahb_design_top
  /*  package imports  */
  #(
    parameter BUS_WIDTH=32,
    parameter DATA_WIDTH=32
  )(
    ahb_if ahb_m_if
  );
  // User defined parameters -----------

  // user defined Ports ----------------

  // Parameters ------------------------

  // INPUT Signals // interface implementation ---------------------

  always @(posedge ahb_design_top_if.HCLK) ahb_design_top_if.HADDR <= 'h0;

  // Internal signals

  // FLOP signals

  typedef enum logic[1:0] {
    ST_IDLE,
    ST_ADD,
    ST_DATA,
    ST_WAIT,
    ST_LOCK
  } ahb_state_t;
  
  ahb_State_t state_q; //CUrrent state
  ahb_state_t next_state; // Next state
  
  //flop IO
  
  // RESET CLK
  always_ff @(posedge HCLK) begin: reset_clk_ff
    if(~HRESETn)
      state_q <= ST_IDLE;
    else
      state_q <= next_state;
  
  // State machine 
  always_comb begin: ahb_state_machine
    case (state_q)
      ST_IDLE:
      ST_ADD:
      ST_DATA:
      ST_WAIT:
      ST_LOCK:
      default: 
  end: ahb_state_machine
    
  end: reset_clk_ff
  


  
endmodule: ahb_design_top
