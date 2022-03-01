/* -.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.

* File Name : apb3_ms_functional_coverage.sv

* File Description :

* Project Name :

* Creation Date : 18-06-2019

* Last Modified : Thu 20 Jun 2019 10:10:30 AM +0530

* Created By : kausha solanki 

* version : v1

* organization : EITRA

_._._._._._._._._._._._._._._._._._._._._.*/
class apb3_ms_coverage;
parameter bit [1:0] IDLE=2'b00 , SETUP=2'b01 , ENABLE=2'b10;

function new();
 master_variable_coverage=new;
// slave_variable_coverage=new;
 state_coverage=new;
endfunction

covergroup master_variable_coverage with function sample(apb3_m_txn_c m_pck);
// c1:coverpoint m_pck.PWRITE{
  //                          bins write={0};
    //                        bins read={1};
      //                     }
endgroup

/*covergroup slave_variable_coverage with function sample(apb3_s_txn_c s_pck);
 c3:coverpoint s_pck.PREADY{
                            bins ready={0};
                            bins not_ready={1};
                           }
endgroup*/

covergroup state_coverage with function sample(bit[1:0] current_state);
c4:coverpoint current_state{
                            bins idle2idle=(IDLE => IDLE);
                            bins idle2setup=(IDLE => SETUP);
                            illegal_bins idle2enable=(IDLE => ENABLE);
                            bins setup2enable=(SETUP => ENABLE);
                            illegal_bins setup2idle=(SETUP => IDLE);
                            bins enable2setup=(ENABLE => SETUP);
                            bins enable2enable=(ENABLE => ENABLE);
                           }
endgroup
endclass










