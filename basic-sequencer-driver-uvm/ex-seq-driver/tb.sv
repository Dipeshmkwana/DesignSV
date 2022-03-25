//
// This example illustrates how to implement a unidirectional sequence-driver
// use model. The example used is an ADPCM like undirectional comms protocol.
// There is no response, so there is no DUT, just an interface ---->
//
`include "pkg.sv";

    module top_tb;
    
    import uvm_pkg::*;
    import adpcm_pkg::*;
    
    adpcm_if ADPCM();
    
    // Free running clock
    initial
      begin
        ADPCM.clk = 0;
        forever begin
          #10 ADPCM.clk = ~ADPCM.clk;
        end
      end
    
    // UVM start up:
    initial
      begin
        uvm_config_db #(virtual adpcm_if.mon_mp)::set(null, "uvm_test_top", "ADPCM_vif" , ADPCM);
        run_test("adpcm_test");
      end
      
    // Dump waves
      initial $dumpvars(0, top_tb);
    
    endmodule: top_tb
