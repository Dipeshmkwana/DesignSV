  // Driver, uses get_next_item(), item_done() approach
  class driver extends uvm_driver #(base_seq_item);

    // instance of sequence
    base_seq_item bsi;

    // interface instance 

    // new call
    function new(string name="driver", uvm_component parent = null);
      super.new(name, parent);
    endfunction

    task run_phase(uvm_phase phase);
    
    endtask: run_phase

  endclass: driver