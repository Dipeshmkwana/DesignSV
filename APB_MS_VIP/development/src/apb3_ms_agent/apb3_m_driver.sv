/* -.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-. 
* File Name     : driver.sv
* File Directory: apb3_ms_agent
* Description   : 
* Author        : Dipesh Makwana 
* Creation Date : 27-05-2019
* Last Modified : Wed 19 Jun 2019 02:46:02 PM +0530
* Organization  : Eitra 
* Copyright (c) 2019 Eitra. All rights reserved.
* -.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-. */ 
`define MST_DRIV_IF mem_vif.m_drv
`define IDLE 2'b00
`define SETUP 2'b01
`define ENABLE 2'b10
class apb3_mst_drv_c;
  int no_transactions;
  virtual apb3_m_intf mem_vif;
  mailbox gen2driv;
  bit [1:0] current_state;
  bit [1:0] next_state;
  apb3_m_txn_c trans;
  apb3_ms_coverage cov; 
  function new(virtual apb3_m_intf mem_vif,mailbox gen2driv);
    this.mem_vif = mem_vif;
    this.gen2driv = gen2driv;
    cov=new;
  endfunction
  
  task apb3_mst_drv_reset_t;
    wait(!mem_vif.PRESETn);
    $display("--------- [DRIVER] Reset Started ---------");
    `MST_DRIV_IF.PWRITE   <= 0;
    `MST_DRIV_IF.PENABLE  <= 0;
    `MST_DRIV_IF.PSELx    <= 0;
    `MST_DRIV_IF.PADDR    <= 0;
    `MST_DRIV_IF.PWDATA   <= 0;
    `MST_DRIV_IF.PSTRB    <= 0;
    wait(mem_vif.PRESETn);
    $display("--------- [DRIVER] Reset Ended ---------");
  endtask
  
  task apb3_mst_drv_driver_t;
      gen2driv.get(trans);
      $display("--------- [MASTER-DRIVER-TRANSFER: %0d] ---------",no_transactions);
 forever begin
   cov.state_coverage.sample(current_state);
 case(current_state)
   `IDLE:begin
        @(posedge  mem_vif.m_drv.PCLK);
        if(trans.PADDR>0)
        begin
          current_state=`SETUP;
        end
        else
        begin
          current_state=`IDLE;
        end
        end
   `SETUP:begin
         `MST_DRIV_IF.PSELx=1;
         `MST_DRIV_IF.PWRITE=trans.PWRITE;
         `MST_DRIV_IF.PADDR=trans.PADDR;
         if(trans.PWRITE)
         begin 
          `MST_DRIV_IF.PWDATA=trans.PWDATA;
         end
         @(posedge  mem_vif.m_drv.PCLK);
         `MST_DRIV_IF.PENABLE<=1;
         current_state=`ENABLE;
        end
  `ENABLE:begin
       	 if(`MST_DRIV_IF.PREADY==1 && trans.PWRITE==1)
          begin
          @(negedge `MST_DRIV_IF.PREADY);
         `MST_DRIV_IF.PENABLE=0;
          current_state=`SETUP;
      	  gen2driv.get(trans);
          no_transactions++;
          end
         else if(`MST_DRIV_IF.PREADY==1 && trans.PWRITE==0)
          begin
          @(negedge `MST_DRIV_IF.PREADY);
         `MST_DRIV_IF.PENABLE=0;
          current_state=`SETUP;
      	  gen2driv.get(trans);
      	  no_transactions++;
          end
        else begin
         @(posedge  mem_vif.m_drv.PCLK);
         current_state=`ENABLE;
         end
	end
      endcase
    end
  endtask
  
  task apb3_mst_drv_run_t;  //driver run task
   fork
    wait(mem_vif.PRESETn);
    apb3_mst_drv_driver_t();
   join
  endtask
endclass

