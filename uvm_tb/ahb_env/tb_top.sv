`ifndef AHB_TOP_SV
`define AHB_TOP_SV

//`timescale 1ns/1ps

`include "base_test.sv"
`include "ahb_if.sv"

module ahb_top_tb;
  import uvm_pkg::*;
	`include "uvm_macros.svh"
  //import uvm pkg

  //declaration

  logic          HCLK;
  logic          HRESETn;

  //interface declaration
  ahb_if ahb_if_top(
    .HCLK(HCLK),
    .HRESETn(HRESETn)
  );

  // DUT instance 
  ahb_design_top ahb_design(.ahb_design_top_if(ahb_if_top));

  //Clock init
  // Free running clock
  initial begin
    HCLK = 0;
    //#100; basetest time it will exit
  end
  
  always #1 HCLK= ~HCLK;

  //UVM Start up
  initial begin
    // Put the interface into the resource database.
    uvm_resource_db#(virtual ahb_if)::set("*", "ahb_if", ahb_design.ahb_design_top_if,null);
    run_test("base_test");
  end
  
  //VCD DUmp
  initial begin
    $dumpfile("ahb_master.vcd");
    $dumpvars(2,ahb_top_tb);
  end

endmodule : ahb_top_tb

`endif