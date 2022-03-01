/* -.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-. 
* File Name     : apb3_ms_multiple_read.sv
* File Directory: tests
* Description   : 
* Author        : Dipesh Makwana 
* Creation Date : 10-06-2019
* Last Modified : Thu 20 Jun 2019 10:13:30 AM +0530
* Organization  : Eitra 
* Copyright (c) 2019 Eitra. All rights reserved.
* -.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-. */ 
class apb3_m_tst_mlt_rd_txn_c extends apb3_m_txn_c;
  constraint c3 { PWRITE == 0;}
endclass : apb3_m_tst_mlt_rd_txn_c

class apb3_s_rd_tst_mlt_txn_wo_t_c extends apb3_s_txn_c;
  constraint c4{num_of_wait_cycle == 0;}
endclass

class apb3_ms_tst_mlt_rd_wo_et_c extends apb3_ms_tst_bs_c;
   // environment object created
  apb3_ms_env_c apb3_ms_env1;
  apb3_m_tst_mlt_rd_txn_c m_txn;
  apb3_s_rd_tst_mlt_txn_wo_t_c s_txn;
  virtual apb3_m_intf mst_vif;
  virtual apb3_s_intf slv_vif;

  function new ( virtual apb3_m_intf mst_vif, virtual apb3_s_intf slv_vif );
    super.new(mst_vif,slv_vif);
    this.mst_vif=mst_vif;
    this.slv_vif=slv_vif;
    apb3_ms_env1 = new(mst_vif, slv_vif);
    m_txn = new;
    s_txn = new;
  endfunction : new

  task run();
    apb3_ms_env1.mst_agnt.mst_gen.trans= m_txn;
    apb3_ms_env1.slv_agnt.s_gen.trans = s_txn;
    apb3_ms_env1.mst_agnt.mst_gen.repeat_count = 10;// assigning repeat count=15
    apb3_ms_env1.slv_agnt.s_gen.repeat_count = 10;
    apb3_ms_env1.apb3_ms_env_run_t();
  endtask
endclass: apb3_ms_tst_mlt_rd_wo_et_c
