/* -.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-. 
* File Name     : apb3_m_monitor.sv
* File Directory: apb3_ms_agent
* Description   : 
* Author        : Dipesh Makwana 
* Creation Date : 10-06-2019
* Last Modified : Wed 19 Jun 2019 02:45:32 PM +0530
* Organization  : Eitra 
* Copyright (c) 2019 Eitra. All rights reserved.
* -.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-. */ 

`define MST_MON_IF mem_vif.m_mon
class apb3_mst_mon_c;
  
  virtual apb3_m_intf mem_vif;
  apb3_m_txn_c trans;
  apb3_ms_coverage cov; 
  mailbox mon2scb;
  
  function new(virtual apb3_m_intf mem_vif,mailbox mon2scb);
      trans = new();
      cov=new;
    this.mem_vif = mem_vif;
    this.mon2scb = mon2scb;
  endfunction
  
  task apb3_mst_mon_run_t();
    forever begin
      @(posedge mem_vif.m_mon.PCLK);
	if(`MST_MON_IF.PREADY && `MST_MON_IF.PWRITE) begin
          trans.PADDR  = `MST_MON_IF.PADDR;
          trans.PWRITE = `MST_MON_IF.PWRITE;
          trans.PWDATA = `MST_MON_IF.PWDATA;
          trans.PSELx = `MST_MON_IF.PSELx;
          trans.PENABLE = `MST_MON_IF.PENABLE;
         cov.master_variable_coverage.sample(trans);
          mon2scb.put(trans);
	end
	else if(`MST_MON_IF.PREADY && (`MST_MON_IF.PWRITE==0)) begin
          trans.PADDR  = `MST_MON_IF.PADDR;
          trans.PWRITE = `MST_MON_IF.PWRITE;
          trans.PRDATA = `MST_MON_IF.PRDATA;
          trans.PSELx = `MST_MON_IF.PSELx;
          trans.PENABLE = `MST_MON_IF.PENABLE;
          cov.master_variable_coverage.sample(trans);
          mon2scb.put(trans);
	end
      //  $display("master monitor  %p",trans);
    end
  endtask
endclass
