//----------------
// AHB Design
//----------------
//  Module: ahb_env
//`include "ahb_env_config.sv"
//`include "ahb_scoreboard.sv"
//`include "ahb_base_test.sv"
//
//  Class: ahb_env
//
`ifndef AHB_ENV_SV
`define AHB_ENV_SV

import uvm_pkg::*;
import ahb_vip_pkg;
`include "uvm_macros.svh"

class ahb_env extends uvm_env;
  `uvm_component_utils(ahb_env)
  

  virtual ahb_if ahb_vif;
  //  Group: Variables

  //  Group: Constraints

  //  Group: Functions

  //  Constructor: new
  function new(string name="ahb_env",uvm_component parent);
    super.new(name,parent);
  endfunction: new
  
  function void build_phase(uvm_phase phase);
    
  endfunction: build_phase

  function void connect_phase(uvm_phase phase);
    `uvm_info("ENV_CONN","Started connect phase",UVM_HIGH)
    // Get the interface from the resource database.
  
    //assert(uvm_resource_db#(virtual ahb_if)::read_by_name(
    //  get_full_name(), "ahb_if", ahb_vif
    //));
    `uvm_info("ENV_CONN","Finished connect phase.",UVM_HIGH)
  endfunction: connect_phase
  
  task run_phase( uvm_phase phase);
    phase.raise_objection(this,"start env run");
    `uvm_info("ENV_RUN","Start run phase...",UVM_HIGH)
    #10;
    `uvm_warning("ENV_RUN","into env")
    `uvm_info("UVM_RUN","env: end run phase...",UVM_HIGH)
    phase.drop_objection(this);
  endtask: run_phase
  
endclass: ahb_env


`endif