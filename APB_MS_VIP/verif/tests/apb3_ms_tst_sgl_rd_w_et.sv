// Text File
//--------------------------------------------------
// AUTHOR: kausha solanki
// PROJECT: tests
// FILE: apb3_ms_tst_sgl_rd_w_et.sv
// PATH: /home/lsanadhya/Desktop/APB_PROJECT/G4_APB_MS_VIP/verif
// CREATED: 10-Jun-2019 05:34:19 PM
// MODIFIED: 10-Jun-2019 05:34:19 PM
// ORGANIZATION: eITRA 
// DESCRIPTION: TODO (some explanation)
//--------------------------------------------------
class apb3_m_rd_testcase_txn_c extends apb3_m_txn_c;
  constraint c11 { PWRITE == 0; PSELx == 1; PENABLE==1;}
endclass

class apb3_s_rd_testcase_txn_c extends apb3_s_txn_c;
 constraint c12{num_of_wait_cycle inside{[1:16]};}
 
endclass

class apb3_ms_tst_sgl_rd_w_et_c extends apb3_ms_tst_bs_c;
   // environment object created
  apb3_ms_env_c apb3_ms_env1;
  apb3_m_rd_testcase_txn_c m_txn;
  apb3_s_rd_testcase_txn_c s_txn;
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
    apb3_ms_env1.mst_agnt.mst_gen.repeat_count = 1;// assigning repeat count=15
    apb3_ms_env1.slv_agnt.s_gen.repeat_count = 1;
    apb3_ms_env1.apb3_ms_env_run_t();
  endtask
endclass: apb3_ms_tst_sgl_rd_w_et_c

