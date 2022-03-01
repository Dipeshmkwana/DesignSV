/* -.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-. 
* File Name     : apb3_m_agent.sv
* File Directory: apb3_ms_agent
* Description   : 
* Author        : Dipesh Makwana 
* Creation Date : 10-06-2019
* Last Modified : Tue 18 Jun 2019 11:54:32 AM +0530
* Organization  : Eitra 
* Copyright (c) 2019 Eitra. All rights reserved.
* -.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-. */ 
class apb3_mst_agent_c;

  apb3_mst_agent_config_c mst_cfg;
  apb3_mst_drv_c mst_drv;                   //Driver 
  apb3_mst_gen_c mst_gen;                   // Generator
  apb3_mst_mon_c mst_mon;                   //monitor 
  apb3_mst_scb_c mst_scb;                  //scoreboard 

  mailbox gen2drv;
  mailbox mon2scb;

  event mst_gen_ended;

  virtual apb3_m_intf mem_vif;         // Interface

  function new(virtual apb3_m_intf mem_vif,mailbox mon2scb);
    this.mem_vif = mem_vif;
    this.gen2drv = new();
    this.mon2scb = mon2scb;
    this.mst_cfg = new();
    this.mst_drv = new(mem_vif,gen2drv);
    this.mst_gen = new(gen2drv, mst_gen_ended);
    this.mst_mon = new(mem_vif,mon2scb);
   // this.mst_scb = new(mon2scb);
  endfunction
 
  task pre_build();
   mst_drv.apb3_mst_drv_reset_t;
  endtask

  task build();
    fork
      mst_drv.apb3_mst_drv_run_t();
      mst_gen.apb3_mst_gen_run_t();
      mst_mon.apb3_mst_mon_run_t();
      //mst_scb.apb3_mst_scb_run_t();
    join_any
  endtask

  task post_build();
    wait(mst_gen_ended.triggered);
    wait(mst_gen.repeat_count == mst_drv.no_transactions);
    //wait(mst_gen.repeat_count == mst_scb.no_transactions);
  endtask

  task apb3_mst_agnt_run_t();
    pre_build();
    build();
    post_build();
  endtask

endclass
