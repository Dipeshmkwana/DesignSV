  // sequencer 
  class sequencer extends uvm_sequencer #(base_seq_item);
    `uvm_component_utils(sequencer)

    function new(string name="sequencer", uvm_component parent = null);
      super.new(name, parent);
    endfunction
  endclass: sequencer