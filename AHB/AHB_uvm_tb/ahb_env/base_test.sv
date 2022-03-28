//  Class: base_test
//
`include "ahb_env_pkg.sv"
`include "ahb_if.sv"

import uvm_pkg::*;
	`include "uvm_macros.svh"
import ahb_env_pkg::*;

class base_test extends uvm_test;

  `uvm_component_utils(base_test)
  
  //  instance
  //base_seq base_seq_i;
  //driver driver_i;
  //sequencer sequencer_i;
  ahb_env env;
  
  //  Group: Variables


  //  Group: Constraints


  //  Group: Functions

  //  Constructor: new
  function new(string name = "base_test", uvm_component parent);
     super.new(name,parent);
  endfunction: new

  function void build_phase(uvm_phase phase);
    env = ahb_env::type_id::create("env",this);
    //driver_i = driver::type_id::create("driver_i", this);
    //sequencer_i = sequencer::type_id::ctreat("sequencer_i",this);
  endfunction: build_phase  

  function void connect_phase(uvm_phase phase);
    //driver_i.seq_item_port.connect(sequencer_i.seq_item_export);
    //if(!uvm_config_db #(virtual design_if.mom_mp)::get(this,"", "DESIGN_vif",driver_i.KAIK)) begin  
    //  `uvm_error("connect", "ADPCM_vif not found")
    //end
  endfunction: connect_phase

  task run_phase(uvm_phase phase);
    //base_seq_i = base_seq:: type_id::create("test_seq");

    phase.raise_objection(this, "starting test_sequence");
    #10;
    //base_seq_i.start(sequencer_i);
    `uvm_warning("BASE_TEST", "Hello World!")
    phase.drop_objection(this, "finished objection");

  endtask: run_phase
  
endclass: base_test
