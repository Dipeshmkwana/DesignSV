//----------------
// environment env
//----------------
class environment extends uvm_env;

  virtual add_sub_if m_if;

  function new(string name, uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
  function void connect_phase(uvm_phase phase);
    `uvm_info("ENV_CON", "Started connect phase.", UVM_HIGH);
    // Get the interface from the resource database.
    assert(uvm_resource_db#(virtual add_sub_if)::read_by_name(
      get_full_name(), "add_sub_if", m_if));
    `uvm_info("ENV_CON", "Finished connect phase.", UVM_HIGH);
  endfunction: connect_phase

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    `uvm_info("ENV_CON", "Started run phase.", UVM_HIGH);
    begin
      int a = 8'h2, b = 8'h3;
      @(m_if.cb);
      m_if.cb.a <= a;
      m_if.cb.b <= b;
      m_if.cb.doAdd <= 1'b1;
      repeat(2) @(m_if.cb);
      `uvm_info("ENV_RUN", $sformatf("%0d + %0d = %0d",
        a, b, m_if.cb.result), UVM_LOW);
    end
    `uvm_info("ENV_RUN", "Finished run phase.", UVM_HIGH);
    phase.drop_objection(this);
  endtask: run_phase
  
endclass: environment