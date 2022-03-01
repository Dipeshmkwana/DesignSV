/* -.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-. 
* File Name     : apb3_ms_test_base.sv
* File Directory: tests
* Description   : 
* Author        : Dipesh Makwana 
* Creation Date : 10-06-2019
* Last Modified : Thu 20 Jun 2019 11:28:08 AM +0530
* Organization  : Eitra 
* Copyright (c) 2019 Eitra. All rights reserved.
* -.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-. */ 
class apb3_ms_tst_bs_c;
   // environment object created
  apb3_ms_env_c apb3_ms_env1;
  //apb3_m_txn_c txn;
  virtual apb3_m_intf mst_vif;
  virtual apb3_s_intf slv_vif;

  function new ( virtual apb3_m_intf mst_vif, virtual apb3_s_intf slv_vif );
    this.mst_vif=mst_vif;
    this.slv_vif=slv_vif;
    apb3_ms_env1 = new(mst_vif, slv_vif);
	$display("original test %s",`__FILE__);
   // txn = new;
  endfunction : new

  virtual task run();
    //apb3_ms_env1.mst_agnt.mst_gen.trans= txn;
    apb3_ms_env1.mst_agnt.mst_gen.repeat_count = 10;// assigning repeat count=15
    apb3_ms_env1.slv_agnt.s_gen.repeat_count = 10;
    apb3_ms_env1.apb3_ms_env_run_t();
  endtask
endclass: apb3_ms_tst_bs_c

/*
class apb3_m_testcase_txn_c extends apb3_m_txn_c;
endclass

class apb3_ms_testcase_c;
   // environment object created
  apb3_ms_env_c apb3_ms_env1;
  virtual apb3_m_intf mst_vif;
  virtual apb3_s_intf slv_vif;
  function new ( virtual apb3_m_intf mst_vif, virtual apb3_s_intf slv_vif );
    this.mst_vif=mst_vif;
    this.slv_vif=slv_vif;
    apb3_ms_env1 = new(mst_vif, slv_vif);
  endfunction : new

  task run();
    apb3_ms_env1.mst_agnt.mst_gen.repeat_count = 15;// assigning repeat count=15
    apb3_ms_env1.slv_agnt.s_gen.repeat_count = 15;
    apb3_ms_env1.apb3_ms_env_run_t();
  endtask
endclass: apb3_ms_testcase_c
*/
