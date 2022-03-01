/* -.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-. 
* File Name     : apb3_s_driver.sv
* File Directory: apb3_ms_agent
* Description   : 
* Author        : lavina sanadhya 
* Creation Date : 10-06-2019
* Last Modified : Tue 18 Jun 2019 11:47:38 AM +0530
* Organization  : Eitra 
* Copyright (c) 2019 Eitra. All rights reserved.
* -.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-. */ 

`define DRIV_IF apb3_ms_vir_intf.s_drv
`define IDLE 2'b00
`define SETUP 2'b01
`define ENABLE 2'b10
class apb3_slv_drv_c;
  int no_transactions;
  reg [31:0] mem[256];
  reg [1:0] curr_apb_state,next_apb_state;
  virtual apb3_s_intf apb3_ms_vir_intf;
  mailbox gen2driv;
  int repeat_count;
  apb3_s_txn_c trans;

  function new(virtual apb3_s_intf apb3_ms_vir_intf,mailbox gen2driv);
      this.apb3_ms_vir_intf = apb3_ms_vir_intf;
      this.gen2driv = gen2driv;
  endfunction

  task apb3_slv_drv_reset_t;
     wait(!apb3_ms_vir_intf.PRESETn);
      $display("--------- [DRIVER] Reset Started ---------");
      `DRIV_IF.PREADY = 0;
      `DRIV_IF.PRDATA = 0;        
     wait(apb3_ms_vir_intf.PRESETn);
      $display("--------- [DRIVER] Reset Ended ---------");
  endtask:apb3_slv_drv_reset_t


  task apb3_slv_drv_main_t;
    gen2driv.get(trans);
    forever begin
      @(posedge apb3_ms_vir_intf.PCLK);  
	#1;
    $display("%0t *******************[SLAVE-DRIVER-TRANSFER=%0d]***********",$time,no_transactions);
      if(`DRIV_IF.PSELx && `DRIV_IF.PENABLE) begin
      	if(!`DRIV_IF.PWRITE) begin:read
	   repeat(trans.num_of_wait_cycle)begin
	      `DRIV_IF.PREADY<=0;
	      @(posedge `DRIV_IF.PCLK);
	   end
          `DRIV_IF.PREADY <= 1;
          `DRIV_IF.PRDATA <= trans.PRDATA;
	  @(posedge `DRIV_IF.PCLK);
	  `DRIV_IF.PREADY<=0;
          $display("%0t SLAVE DRIVER WRITE DATA => PADDR =%16h,PWDATA =%16h,PREADY=%b",$time,`DRIV_IF.PADDR,`DRIV_IF.PWDATA,`DRIV_IF.PREADY);
      	  no_transactions++;
        end:read
      else                 //write operation
      begin:pwrite
	repeat(trans.num_of_wait_cycle)begin
	     `DRIV_IF.PREADY <= 0;
	      @(posedge `DRIV_IF.PCLK);
	end
        `DRIV_IF.PREADY <= 1;
        @(posedge `DRIV_IF.PCLK);
        `DRIV_IF.PREADY <= 0;
        $display("%0t SLAVE DRIVER READ DATA => PADDR =%16h,PRDATA =%16h,PREADY=%b",$time,`DRIV_IF.PADDR,`DRIV_IF.PRDATA,`DRIV_IF.PREADY);
        no_transactions++;
      end:pwrite
    gen2driv.get(trans);
   end
  end
  endtask : apb3_slv_drv_main_t
  task apb3_slv_drv_run_t;
     fork
     wait(apb3_ms_vir_intf.PRESETn);
     apb3_slv_drv_main_t();
     join
  endtask:apb3_slv_drv_run_t
endclass :apb3_slv_drv_c

