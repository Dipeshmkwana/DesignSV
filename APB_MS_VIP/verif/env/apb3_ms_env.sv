/* -.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-. 
* File Name     : env.sv
* File Directory: env
* Description   : 
* Author        : Dipesh Makwana 
* Creation Date : 28-05-2019
* Last Modified : Mon 17 Jun 2019 02:50:13 PM +0530
* Organization  : Eitra 
* Copyright (c) 2019 Eitra. All rights reserved.
* -.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-. */ 
class apb3_ms_env_c;
  apb3_mst_agent_c mst_agnt;
  apb3_slv_agent_c slv_agnt;
  //apb3_ms_scb_c scb;                  //scoreboard 

  mailbox mon2scb,s_mon2scb;
  virtual apb3_m_intf mst_vif;
  virtual apb3_s_intf slv_vif;

  function new(virtual apb3_m_intf mst_vif,virtual apb3_s_intf slv_vif);
    this.mst_vif = mst_vif;
    this.slv_vif = slv_vif;
    mst_agnt = new(mst_vif,mst_mon2scb); 
    slv_agnt = new(slv_vif,slv_mon2scb);
    mon2scb=new;
    s_mon2scb=new;
    mst_agnt = new(mst_vif,mon2scb); 
    slv_agnt = new(slv_vif,s_mon2scb);
    scb=new(mon2scb,s_mon2scb);
  endfunction
  task apb3_ms_env_run_t();
    fork 
      mst_agnt.apb3_mst_agnt_run_t();
      slv_agnt.apb3_slv_agnt_run_t();
      scb.apb3_mst_scb_run_t();
    join
  endtask
endclass
