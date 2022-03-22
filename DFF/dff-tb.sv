// Code your testbench here
// or browse Examples
module test;
  
    reg clk;
    reg reset;
    reg d;
    wire q;
    wire qb;
    
    //instantiate design under test 
    dff DFF(
      .clk(clk),
      .reset(reset),
      .d(d),
      .qb(qb)
    );
    
    initial begin
      $dumpfile("dmp.vcd");
      $dumpvars(1);
      
      $display("reset flop");
      clk=0;
      reset = 1;
      d = 1'bx;
      display;//task
      
      $display("Toggle clk.");
      clk = 1;
      display;
    end
    
    task display;
      #1 $display("d:%0h, q:%0h, qb: %0h", d, q, qb);
    endtask
    
  endmodule