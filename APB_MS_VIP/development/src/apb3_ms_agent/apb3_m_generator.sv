/* -.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-. 
* File Name     : apb3_m_generator.sv
* File Directory: apb3_ms_agent
* Description   : 
* Author        : Dipesh Makwana 
* Creation Date : 10-06-2019
* Last Modified : Mon 24 Jun 2019 03:30:13 PM +0530
* Organization  : Eitra 
* Copyright (c) 2019 Eitra. All rights reserved.
* -.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-. */ 

class apb3_mst_gen_c;
  apb3_m_txn_c trans;
 apb3_m_txn_c tr;

  int repeat_count;
  mailbox gen2drv;
  event ended;

  function new(mailbox gen2drv,event ended);
    this.gen2drv = gen2drv;
    this.ended    = ended;
    trans = new();
  endfunction

  task apb3_mst_gen_run_t();
    trans.id=repeat_count;
    //trans = new();
    repeat(repeat_count) begin
    //trans = new();
   // trans.my_fun();
      if( !trans.randomize() ) $display("Mater Gen:: trans randomization failed");
       tr = trans.txn1_do_copy();
      $display("Master Gen:: %p",tr);
      gen2drv.put(tr);
       tr = new();
      trans.id--;
    end
    -> ended;
  endtask
endclass
