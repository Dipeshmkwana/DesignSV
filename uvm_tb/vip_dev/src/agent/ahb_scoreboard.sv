//----------------
// AHB Design
//----------------
//  Module: ahb_scb
//`include "ahb_scb_config.sv"
//`include "ahb_scoreboard.sv"
//`include "ahb_base_test.sv"
//
//  Class: ahb_scb
//
`ifndef AHB_SCB_SV
`define AHB_SCB_SV

import uvm_pkg::*;
`include "uvm_macros.svh"

class ahb_scb extends uvm_scoreboard;
  `uvm_component_utils(ahb_scb)
  function new(string name="ahb_scb", uvm_component parent=null);
    super.new(name, parent);
  endfunction

  uvm_analysis_imp #(switch_item, ahb_scb) m_analysis_imp;

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    m_analysis_imp = new("m_analysis_imp", this);
  endfunction

  virtual function write(switch_item item);
      if (item.addr inside {[0:'h3f]}) begin
        if (item.addr_a != item.addr | item.data_a != item.data)
          `uvm_error("SCBD", $sformatf("ERROR! Mismatch addr=0x%0h data=0x%0h addr_a=0x%0h data_a=0x%0h", item.addr, item.data, item.addr_a, item.data_a))
        else
          `uvm_info("SCBD", $sformatf("PASS! Match addr=0x%0h data=0x%0h addr_a=0x%0h data_a=0x%0h", item.addr, item.data, item.addr_a, item.data_a), UVM_LOW)

      end else begin
        if (item.addr_b != item.addr | item.data_b != item.data)
          `uvm_error("SCBD", $sformatf("ERROR! Mismatch addr=0x%0h data=0x%0h addr_b=0x%0h data_b=0x%0h", item.addr, item.data, item.addr_b, item.data_b))
        else
          `uvm_info("SCBD", $sformatf("PASS! Match addr=0x%0h data=0x%0h addr_b=0x%0h data_b=0x%0h", item.addr, item.data, item.addr_b, item.data_b), UVM_LOW)
      end
  endfunction
endclass: ahb_scb

`endif