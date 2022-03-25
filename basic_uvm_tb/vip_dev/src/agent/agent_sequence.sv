
  // Sequence // randomization 
  class base_seq extends uvm_sequence #(base_seq_item);
    `uvm_component_utils(base_seq)

    // sequence item instance

    // ramdonize
    rand int no_reqs = 10;

    // new
    function new(string name ="base_seq");
      super.new(name);
    endfunction

    task body;
      req = base_seq_item::type_id::create("req");
      
      for(int i=0; i< no_reqs; i++) begin
        start_item(req);
        // req.randomize();
        // For modelSim, use $urandom to achieve randomization for your request
        req.delay = $urandom_range(1,20);
        req.delay = $urandom();
        finish_item(req);

        `uvm_info("SEQ_BODY",$sformatf("Transmited frame %0d",i ), UVM_LOW)
      end

    endtask: body

  endclass: base_seq