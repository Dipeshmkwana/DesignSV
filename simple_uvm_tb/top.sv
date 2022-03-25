module top;

  bit clk;
  env environment;
  ADD_SUB dut(.clk (clk));

  initial begin
    environment = new("env");
    // Put the interface into the resource database.
    uvm_resource_db#(virtual add_sub_if)::set("env",
      "add_sub_if", dut.add_sub_if0);
    clk = 0;
    run_test();
  end
  
  initial begin
    forever begin
      #(50) clk = ~clk;
    end
  end
  
  initial begin
    // Dump waves
    $dumpvars(0, top);
  end
  
endmodule