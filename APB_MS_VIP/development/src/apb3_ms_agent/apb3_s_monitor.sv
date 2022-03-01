/* -.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-. 
* File Name     : apb3_s_monitor.sv
* File Directory: apb3_ms_agent
* Description   : 
* Author        : kausha solanki 
* Creation Date : 10-06-2019
* Last Modified : Wed 19 Jun 2019 02:59:43 PM +0530
* Organization  : Eitra 
* Copyright (c) 2019 Eitra. All rights reserved.
* -.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-. */ 
`define MON_IF apb3_ms_vif.s_mon
class apb3_slv_mon_c;
 
 virtual apb3_s_intf apb3_ms_vif;
 mailbox s_mon2scb;
 apb3_s_txn_c trans;
// apb3_ms_coverage cov; 
 
  function new(virtual apb3_s_intf apb3_ms_vif,mailbox s_mon2scb);
    this.apb3_ms_vif = apb3_ms_vif;
    this.s_mon2scb = s_mon2scb;
    trans = new();
  //  cov=new;
  endfunction
  
  task apb3_slv_mon_run_t;
    forever begin
	  @(negedge apb3_ms_vif.PCLK);
	  if(`MON_IF.PSELx  && `MON_IF.PENABLE) begin
	  trans.PADDR	= `MON_IF.PADDR;
	  trans.PWDATA	=`MON_IF.PWDATA;
	  trans.PWRITE	= `MON_IF.PWRITE;
	  trans.PREADY	= `MON_IF.PREADY;
	  trans.PRDATA	= `MON_IF.PRDATA;
    //      cov.slave_variable_coverage.sample(trans);
	  s_mon2scb.put(trans);
	  end
    end	
  endtask:apb3_slv_mon_run_t

endclass:apb3_slv_mon_c
