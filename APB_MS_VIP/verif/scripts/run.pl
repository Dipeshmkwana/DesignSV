#!/usr/bin/perl

use File::Basename;
use Cwd 'abs_path';
@spl=split("/",abs_path(dirname $0));pop @spl;pop @spl;
$path=join '/',@spl;

$env_dir = "$path/verif/env";
$testcase_dir =" $path/verif/tests";
$agent_dir="$path/development/src/apb3_ms_agent";
$inc_dir="$path/development/include";

$top      = "$env_dir/apb3_ms_top.sv";
$tc_b       = "$testcase_dir/apb3_ms_tst_bs.sv";
$tc_1       = "$testcase_dir/apb3_ms_tst_sgl_wr_wo_et.sv";
$tc_2       = "$testcase_dir/apb3_ms_tst_sgl_rd_wo_et.sv";
$tc_3       = "$testcase_dir/apb3_ms_tst_mlt_wr_wo_et.sv";
$tc_4       = "$testcase_dir/apb3_ms_tst_mlt_rd_wo_et.sv";
$tc_5       = "$testcase_dir/apb3_ms_tst_mlt_rd_wr_wo_et.sv";
$tc_6       = "$testcase_dir/apb3_ms_tst_sgl_wr_w_et.sv";
$tc_7       = "$testcase_dir/apb3_ms_tst_sgl_rd_w_et.sv";
$tc_8       = "$testcase_dir/apb3_ms_tst_mlt_wr_w_et.sv";
$tc_9       = "$testcase_dir/apb3_ms_tst_mlt_rd_w_et.sv";

$tc_cfg   = "$testcase_dir/apb3_ms_testcase_config.sv";
$env      = "$env_dir/apb3_ms_env.sv";

$env_cfg  = "$env_dir/apb3_ms_env_config.sv";
$fun_cov  = "$env_dir/apb3_ms_functional_coverage.sv";

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
help();
$usr_in;
BEGIN: 
$usr_in = <STDIN>;chomp $usr_in;
if($usr_in eq "help" or $usr_in eq "" ) {print"\nhelp";}
else{if($usr_in eq "comp") { compile(); }#compile();}
else{if($usr_in eq "simula") { simula(); }#list_testcase(); simula();}
else{if($usr_in eq "run") {clean();compile(); simula();}#compile(); simula();}clean()
else{if($usr_in eq "clean") {clean();}
else{if($usr_in eq "urg") {urg();}
else{if($usr_in eq "exit" || $usr_in == "Exit" ) {exit 42;}#exit 42; }
else{
print("\nInvelid option");
print("\n\t Enter Again : ");
}}}}}}}
goto BEGIN;
exit 42;


sub get_tc() {
  if($test eq "1"){@t=split("/",$tc_1);$test=pop@t;$test=~ s{\.[^.]+$}{}; $test="$test"."_c";}
  if($test eq "2"){@t=split("/",$tc_2);$test=pop@t;$test=~ s{\.[^.]+$}{}; $test="$test"."_c";}
  if($test eq "3"){@t=split("/",$tc_3);$test=pop@t;$test=~ s{\.[^.]+$}{}; $test="$test"."_c";}
  if($test eq "4"){@t=split("/",$tc_4);$test=pop@t;$test=~ s{\.[^.]+$}{}; $test="$test"."_c";}
  if($test eq "5"){@t=split("/",$tc_5);$test=pop@t;$test=~ s{\.[^.]+$}{}; $test="$test"."_c";}
  if($test eq "6"){@t=split("/",$tc_6);$test=pop@t;$test=~ s{\.[^.]+$}{}; $test="$test"."_c";}
  if($test eq "7"){@t=split("/",$tc_7);$test=pop@t;$test=~ s{\.[^.]+$}{}; $test="$test"."_c";}
  if($test eq "8"){@t=split("/",$tc_8);$test=pop@t;$test=~ s{\.[^.]+$}{}; $test="$test"."_c";}
  if($test eq "9"){@t=split("/",$tc_9);$test=pop@t;$test=~ s{\.[^.]+$}{}; $test="$test"."_c";}
}

sub compile() {

print("##################### Compilation Initiated #####################\n");
system("tcsh -c 'vcs -q -sverilog -debug_access $txn $m_gen $s_gen $fun_cov $m_drv $s_drv $m_mon $s_mon $m_scb $m_agt_cfg $s_agt_cfg $m_agt $s_agt $env $env_cfg $tc_b $tc_1 $tc_2 $tc_3 $tc_4 $tc_5 $tc_6 $tc_7 $tc_8 $tc_9 $tc_cfg $m_intf $s_intf $top  -full64'");
print("##################### Compilation Complete: Success #####################\n");

}

sub simula(){
  list_testcase();
  get_tc();
  print("##################### Simulation Initiated #####################\n");
  system("./simv +TEST_CASE=$test -l simulation.log");
  print("##################### Simulation Complete #####################\n");
  exit 42;
}
$test;
sub list_testcase() { 
    print("\n\tEnter test case number from below list");
    print("\n\t1 : Single write without extended transfer");
    print("\n\t2 : Single read without extended transfer");
    print("\n\t3 : Multi write without extended transfer");
    print("\n\t4 : Multi read without extended transfer");
    print("\n\t5 : Multiple read write without extended transfer");
    print("\n\t6 : Single write with extended transfer"); 
    print("\n\t7 : Single read with extended transfer");
    print("\n\t8 : Multi write with extended transfer");
    print("\n\t9 : Multi read with extended transfer");
    print("\n\tEnter: ");
    $test = <STDIN>; chomp $test;
    print("\n");
    return;
  
}
sub help() {
  print("\n\n\t ############################################################### ");
  print(  "\n\t ##              APB AMBA 3 VIP TEST ENVIRONMENT              ## ");
  print(  "\n\t ############################################################### ");
  print(  "\n\t ##               : Command List :                            ## ");
  print(  "\n\t ##\t help   : To get list of commands and options         ## ");
  print(  "\n\t ##\t comp   : To compile                                  ## ");
  print(  "\n\t ##\t simula : To start simulaion                          ## ");
  print(  "\n\t ##\t run    : To compile and Simulate                     ## ");
  print(  "\n\t ##\t clean  : To remove *.vdb ./simv simv.daidir          ## ");
  print(  "\n\t ##\t          work csrc vc_hdrs.h ucli.key *.log *.DB     ## ");
  print(  "\n\t ##\t urg    : To generte URG report                       ## ");
  print(  "\n\t ############################################################### \n");
  print(  "\n\t Enter : ");
  return;
}

sub urg(){
  print("##################### URG #####################\n");
  system("urg -dir simv.vdb -full64");
  print("######################## URG Done ########################\n");
  return;
}

sub clean(){
  print("##################### Cleaning Up #####################\n");
  system("rm -rf *.vdb ./simv simv.daidir work csrc vc_hdrs.h ucli.key *.log *.DB");
  print("######################## clean ########################\n");
  return;
}



#*.vpd
#$tc_b $tc_1 $tc_2 $tc_3 $tc_4 $tc_5
