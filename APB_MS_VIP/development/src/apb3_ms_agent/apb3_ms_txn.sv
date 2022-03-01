/* -.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-. 
* File Name     : apb3_ms_txn.sv
* File Directory: apb3_ms_agent
* Description   : 
* Author        : kausha solanki 
* Creation Date : 10-06-2019
* Last Modified : Thu 20 Jun 2019 11:26:52 AM +0530
* Organization  : Eitra 
* Copyright (c) 2019 Eitra. All rights reserved.
* -.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-. */ 
class apb3_m_txn_c;
  parameter             SIZE=32;
  rand bit              PSELx;
  rand bit              PWRITE;
  rand bit              PENABLE;
  logic                 PREADY;
  rand bit [1:0]        PSTRB;
  randc bit [SIZE-1:0]  PADDR;
  rand bit [SIZE-1:0]   PWDATA;
  logic    [SIZE-1:0]   PRDATA;
  int id;
function void my_fun();
$display("88888888888888888888888888888888888888888original %s",`__FILE__);
endfunction
function apb3_m_txn_c txn1_do_copy(); //deep copy method
    apb3_m_txn_c txn;
   txn = new();
   txn.PSELx   = this.PSELx;
   txn.PWRITE  = this.PWRITE;
   txn.PENABLE = this.PENABLE;
   txn.PSTRB   = this.PSTRB;
   txn.PADDR   = this.PADDR;
   txn.PWDATA  = this.PWDATA;
   return txn;
  endfunction

 function bit apb3_m_txn_compare_c(apb3_m_txn_c com);
  if(this.PSELx==com.PSELx && this.PWRITE==com.PWRITE && this.PENABLE==com.PENABLE && this.PREADY==com.PREADY && this.PADDR==com.PADDR && this.PWDATA==com.PWDATA && this.PRDATA==com.PRDATA) 
    return 1;
  else
    return 0;
 endfunction 

function print();
 $display("MASTER GENERATE : PADDR:%0d, PWDATA:%0d, PSELx:%0b, PENABLE:%0b, PREADY:%0b, PRDATA:%0d ",PADDR,PWDATA,PSELx,PENABLE,PREADY,PRDATA);
endfunction

endclass

class apb3_s_txn_c;
  parameter             SIZE=32;
  logic                 PSELx;
  logic                 PWRITE;
  logic                 PENABLE;
  rand bit                   PREADY;
  logic    [1:0]        PSTRB;
  logic     [SIZE-1:0]  PADDR;
  logic    [SIZE-1:0]   PWDATA;
  rand logic    [SIZE-1:0]   PRDATA;
  rand bit[3:0] num_of_wait_cycle;

 function apb3_s_txn_c txn_do_copy(); //deep copy method
    apb3_s_txn_c txn;
   txn = new();
   txn.PREADY  = this.PREADY;
   txn.PRDATA  = this.PRDATA;
   txn.num_of_wait_cycle = this.num_of_wait_cycle;
   return txn;
  endfunction

function bit apb3_s_txn_compare_c(apb3_s_txn_c com);
  if(this.PSELx==com.PSELx && this.PWRITE==com.PWRITE && this.PENABLE==com.PENABLE && this.PREADY==com.PREADY && this.PADDR==com.PADDR && this.PWDATA==com.PWDATA && this.PRDATA==com.PRDATA) 
    return 1;
  else
    return 0;
endfunction

function print();
 $display("SLAVE GENERATE : PADDR:%0d, PWDATA:%0d, PSELx:%0b, PENABLE:%0b, PREADY:%0b, PRDATA:%0d ",PADDR,PWDATA,PSELx,PENABLE,PREADY,PRDATA);
endfunction
endclass

