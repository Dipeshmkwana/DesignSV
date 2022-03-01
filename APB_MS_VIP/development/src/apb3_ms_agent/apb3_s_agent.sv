/* -.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-. 
* File Name     : apb3_s_agent.sv
* File Directory: apb3_ms_agent
* Description   : 
* Author        : Dipesh Makwana 
* Creation Date : 10-06-2019
* Last Modified : Tue 18 Jun 2019 11:54:23 AM +0530
* Organization  : Eitra 
* Copyright (c) 2019 Eitra. All rights reserved.
* -.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-. */ 
class apb3_slv_agent_c;

  apb3_slv_agent_config_c slave_config;
  apb3_slv_drv_c s_drv;
  apb3_slv_gen_c s_gen;
  apb3_slv_mon_c s_mon;

  event slv_gen_ended;

  mailbox gen2driv;
  mailbox s_mon2scb;

  virtual apb3_s_intf apb3_ms_vif;

  function new(virtual apb3_s_intf apb3_ms_vif,mailbox s_mon2scb);
    this.apb3_ms_vif=apb3_ms_vif;
    slave_config=new();
    
    gen2driv =new();
    this.s_mon2scb = s_mon2scb;
    
    s_drv=new(apb3_ms_vif,gen2driv);
    s_gen=new(gen2driv,slv_gen_ended);
    s_mon=new(apb3_ms_vif,s_mon2scb);
	  //trans=new();
  endfunction

  task pre_build();
     s_drv.apb3_slv_drv_reset_t();
  endtask

  task build();
    fork
      s_drv.apb3_slv_drv_run_t();
      s_gen.apb3_slv_gen_run_t();
      s_mon.apb3_slv_mon_run_t();
    join_any
  endtask

  task post_build();
    wait(slv_gen_ended.triggered);
    wait(s_gen.repeat_count == s_drv.no_transactions);
    $display("End of post_build");
  endtask

  task apb3_slv_agnt_run_t();
    pre_build();
    build();
    post_build();
  endtask

endclass
