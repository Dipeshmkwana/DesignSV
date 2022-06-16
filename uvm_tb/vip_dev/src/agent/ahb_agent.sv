//----------------
// AHB Design
//----------------
//  Module: ahb_agent
//`include "ahb_agent_config.sv"
//`include "ahb_scoreboard.sv"
//`include "ahb_base_test.sv"
//
//  Class: ahb_agent
//
`ifndef AHB_AGENT_SV
`define AHB_AGENT_SV

import uvm_pkg::*;
`include "uvm_macros.svh"

class ahb_agent extends uvm_agent;
  `uvm_component_utils(ahb_agent)
  

  virtual ahb_if ahb_vif;
  //  Group: Variables

  //  Group: Constraints

  //  Group: Functions

  //  Constructor: new
  function new(string name="ahb_agent",uvm_component parent);
    super.new(name,parent);
  endfunction: new
  
  function void build_phase(uvm_phase phase);
    
  endfunction: build_phase

  function void connect_phase(uvm_phase phase);
    `uvm_info("AGNT_CONN","Started connect phase",UVM_HIGH)
    // Get the interface from the resource database.
  
    //assert(uvm_resource_db#(virtual ahb_if)::read_by_name(
    //  get_full_name(), "ahb_if", ahb_vif
    //));
    `uvm_info("AGNT_CONN","Finished connect phase.",UVM_HIGH)
  endfunction: connect_phase
  
  task run_phase( uvm_phase phase);
    phase.raise_objection(this,"start agent run");
    `uvm_info("AGNT_RUN","Start run phase...",UVM_HIGH)
    #110;
    `uvm_warning("AGNT_RUN","into agent")
    `uvm_info("UVM_RUN","agent: end run phase...",UVM_HIGH)
    phase.drop_objection(this);
  endtask: run_phase
  
endclass: ahb_agent


`endif