`ifndef AHB_TOP_SV
`define AHB_TOP_SV

`timescale 1ns/1ps

`include "base_test.sv"


module top_tb;
  import uvm_pkg::*;
	`include "uvm_macros.svh"
  import ahb_env_pkg::*;
  //import uvm pkg

  //declaration

  logic          HCLK;
  logic          HRESETn;

  //interface declaration
  ahb_if ahb_if_top(
    .HCLK(HCLK),
    .HRESETn(HRESETn)
  );

  // environment instance
  //ahb_env env; 

  // DUT instance 
  ahb_design_top ahb_design(.ahb_design_top_if(ahb_if_top));

  //Clock init
  // Free running clock
  initial begin
    HCLK = 0;
    forever begin
      #50 HCLK = ~HCLK;
    end
  end

  //UVM Start up
  initial begin
    //env = new("ahb_env");
    // Put the interface into the resource database.
    uvm_resource_db#(virtual ahb_if)::set("*", "ahb_if", ahb_design.ahb_design_top_if,null);
    run_test("base_test");
  end
  //One Way with config_db
  //initial
  //  begin
  //    uvm_config_db #(virtual adpcm_if.mon_mp)::set(null, "uvm_test_top", "ADPCM_vif" , ADPCM);
  //    run_test("adpcm_test");
  //  end

  //Dump waves
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0);
  end

endmodule : top_tb

`endif