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
$tc       = "$testcase_dir/apb3_ms_testcase.sv";
$tc_cfg   = "$testcase_dir/apb3_ms_testcase_config.sv";
$env      = "$env_dir/apb3_ms_env.sv";
$env_cfg  = "$env_dir/apb3_ms_env_config.sv";
$intf     = "$env_dir/apb3_ms_interface.sv";

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

#print("##################### Compilation #####################\n");
system("tcsh -c 'gvim -p $txn $m_gen $s_gen $m_drv $s_drv $m_mon $s_mon $m_scb $m_agt_cfg $s_agt_cfg $m_agt $s_agt $env $env_cfg $tc $tc_cfg $intf $top '");
#print("##################### Simulation #####################\n");
#system("./simv -l simulation.log");
#print("##################### Cleaning Up #####################\n");
#system("rm -rf *.vdb *.vpd ./simv simv.daidir work csrc vc_hdrs.h ucli.key *.log *.DB");
#print("##################### END #####################\n");
exit 0;


<<<<<<< .mine
 
=======

>>>>>>> .r465
