/* -.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-. 
* File Name     : apb3_m_scoreboard.sv
* File Directory: Master
* Description   : 
* Author        : kausha solanki 
* Creation Date : 31-05-2019
* Last Modified : Mon 17 Jun 2019 02:51:19 PM +0530
* Organization  : Eitra 
* Copyright (c) 2019 Eitra. All rights reserved.
* -.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-. */ 
class apb3_mst_scb_c;
  mailbox mon2scb,s_mon2scb;
  
  int no_transactions;
    int success,fail;
    apb3_m_txn_c trans;
    apb3_s_txn_c txn;
  
  function new(mailbox mon2scb,mailbox s_mon2scb);
    this.mon2scb = mon2scb;
    this.s_mon2scb = s_mon2scb;
    trans=new;
    txn=new;
  endfunction
  
  task apb3_mst_scb_run_t;
   forever begin
    mon2scb.get(trans);
    s_mon2scb.get(txn);
     if(trans.PWRITE) begin
       $display("inside");
        if(trans.PADDR == txn.PADDR && trans.PWDATA==txn.PWDATA ) 
          begin
          trans.print();
          txn.print();
          $display("SUCCESSFULL");
          success++;
          end
        else
          begin
          trans.print();
          txn.print();
          $display("FAIL");
          fail++;
          end
      end
      else begin 
          $display("inside");
          trans.print();
          txn.print();
          if(trans.PADDR == txn.PADDR && trans.PRDATA==txn.PRDATA ) 
          begin
          trans.print();
          txn.print();
          $display("SUCCESSFULL");
          success++;
          end
          else
          begin
          trans.print();
          txn.print();
          $display("FAIL");
          fail++;
          end
      end
      
      no_transactions++;
  $display("no_of_transcation:%0d    success:%0d     fail:%0d",no_transactions,success,fail);
end  
endtask



endclass : apb3_mst_scb_c
