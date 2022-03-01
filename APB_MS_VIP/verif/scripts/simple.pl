#!/usr/bin/perl

#$abs_path= $ENV{PWD};

use File::Basename;
use Cwd 'abs_path';
@spl=split("/",abs_path(dirname $0));pop @spl;pop @spl;
$path=join '/',@spl;

$env_dir = "$path/verif/env";
$testcase_dir =" $path/verif/tests";
$agent_dir="$path/development/src/apb3_ms_agent";
$inc_dir="$path/development/include";

$top      = "$env_dir/apb3_ms_top.sv";
$tc_cfg   = "$testcase_dir/apb3_ms_testcase_config.sv";
$env      = "$env_dir/apb3_ms_env.sv";
$env_cfg  = "$env_dir/apb3_ms_env_config.sv";

$tc_b = "$testcase_dir/apb3_ms_tst_bs.sv";
$tc_1 = "$testcase_dir/apb3_ms_tst_sgl_wr_wo_et.sv";
$tc_2 = "$testcase_dir/apb3_ms_tst_sgl_rd_wo_et.sv";
$tc_3 = "$testcase_dir/apb3_ms_tst_mlt_wr_wo_et.sv";
$tc_4 = "$testcase_dir/apb3_ms_tst_mlt_rd_wo_et.sv";
$tc_5 = "$testcase_dir/apb3_ms_tst_mlt_rd_wr_wo_et.sv";
$tc_6 = "$testcase_dir/apb3_ms_tst_sgl_wr_wo_et.sv";
$tc_7 = "$testcase_dir/apb3_ms_tst_sgl_rd_wo_et.sv";
$tc_8 = "$testcase_dir/apb3_ms_tst_mlt_wr_wo_et.sv";
$tc_9 = "$testcase_dir/apb3_ms_tst_mlt_rd_wo_et.sv";



$m_intf     = "$env_dir/apb3_m_interface.sv";
$s_intf     = "$env_dir/apb3_s_interface.sv";
$m_agt      = "$agent_dir/apb3_m_agent.sv";
$s_agt      = "$agent_dir/apb3_s_agent.sv";
$m_agt_cfg  = "$agent_dir/apb3_m_agent_config.sv";
$s_agt_cfg  = "$agent_dir/apb3_s_agent_config.sv";
$m_drv      = "$agent_dir/apb3_m_driver.sv";
$s_drv      = "$agent_dir/apb3_s_driver.sv";
$m_gen      = "$agent_dir/apb3_m_generator.sv";
$s_gen      = "$agent_dir/apb3_s_generator.sv";
$m_mon      = "$agent_dir/apb3_m_monitor.sv";
$s_mon      = "$agent_dir/apb3_s_monitor.sv";
$txn        = "$agent_dir/apb3_ms_txn.sv";

$m_scb      = "$env_dir/apb3_m_scoreboard.sv";
$pkg= "$inc_dir/apb3_ms_pkg.sv";

print("##################### Compilation #####################\n");
system("tcsh -c 'vcs -sverilog -debug_access $txn $m_gen $s_gen $m_drv $s_drv $m_mon $s_mon $m_scb $m_agt_cfg $s_agt_cfg $m_agt $s_agt $env $env_cfg $tc_b $tc_2 $tc_1  $tc_cfg $m_intf $s_intf $top  -full64'");
print("##################### Simulation #####################\n");
system("./simv +TEST_CASE=apb3_ms_tst_sgl_rd_wo_et_c -l simulation.log");
print("##################### Cleaning Up #####################\n");
system("rm -rf *.vdb ./simv simv.daidir work csrc vc_hdrs.h ucli.key *.log *.DB");
print("##################### END #####################\n");
exit 42;
#*.vpd

 
