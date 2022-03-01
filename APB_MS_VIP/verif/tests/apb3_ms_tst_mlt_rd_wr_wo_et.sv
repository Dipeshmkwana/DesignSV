
class apb3_m_test_multiple_read_write_txn_c extends apb3_m_txn_c;
	constraint c5{if(id%2==0) PWRITE==0; else PWRITE==1;} 
endclass : apb3_m_test_multiple_read_write_txn_c

class apb3_s_test_multiple_read_write_txn_c extends apb3_s_txn_c;
 constraint c6{num_of_wait_cycle==0;} 
endclass


class apb3_ms_tst_mlt_rd_wr_wo_et_c extends apb3_ms_tst_bs_c;
   // environment object created
  apb3_ms_env_c apb3_ms_env1;
  apb3_m_test_multiple_read_write_txn_c m_txn;
  apb3_s_test_multiple_read_write_txn_c s_txn;
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
endclass: apb3_ms_tst_mlt_rd_wr_wo_et_c
