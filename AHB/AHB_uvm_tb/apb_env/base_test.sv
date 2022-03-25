  //  Class: base_test
  //
  class base_test extends uvm_test;

    `uvm_component_utils(base_test)
    
    //  instance
    base_seq base_seq_i;
    driver driver_i;
    sequencer sequencer_i;
    
    //  Group: Variables
  
  
    //  Group: Constraints
  
  
    //  Group: Functions
  
    //  Constructor: new
    function new(string name = "base_test");
       super.new(name,parent);
    endfunction: new

    function void build_phase(uvm_phase phase);
      driver_i = driver::type_id::create("driver_i", this);
      sequencer_i = sequencer::type_id::ctreat("sequencer_i",this);
    endfunction: build_phase  

    function void connect_phase(uvm_phase phase);
      driver_i.seq_item_port.connect(sequencer_i.seq_item_export);
      if(!uvm_config_db #(virtual design_if.mom_mp)::get(this,"", "DESIGN_vif",driver_i.KAIK)) begin  
        `uvm_error("connect", "ADPCM_vif not found")
      end
    endfunction: connect_phase

    task run_phase(uvm_phase phase);
      base_seq_i = base_seq:: type_id::create("test_seq");

      phase.raise_objection(this, "starting test_sequence");
      base_seq_i.start(sequencer_i);
      phase.drop_objection(this, "finish objection");

    endtask: run_phase
    
  endclass: base_test