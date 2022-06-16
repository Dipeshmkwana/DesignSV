class my_test extends base_test;

  `uvm_component_utils(my_test)

  ahb_env env;
  
  function new(string name = "my_test", uvm_component parent);
     super.new(name,parent);
  endfunction: new

  function void build_phase(uvm_phase phase);
    env = ahb_env::type_id::create("env",this);
    
  endfunction: build_phase  

  function void connect_phase(uvm_phase phase);
   
  endfunction: connect_phase

  task run_phase(uvm_phase phase);

    phase.raise_objection(this, "starting test_sequence");
    #80;
    `uvm_warning("BASE_TEST", "Hello World! My test ++++++++++++++++++")
    phase.drop_objection(this, "finished objection");

  endtask: run_phase
 
  
endclass: my_test