/* -.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-. 
* File Name     : top.sv
* File Directory: env
* Description   : 
* Author        : Dipesh Makwana 
* Creation Date : 28-05-2019
* Last Modified : Mon 24 Jun 2019 03:26:16 PM +0530
* Organization  : Eitra 
* Copyright (c) 2019 Eitra. All rights reserved.
* -.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-. */ 
module apb3_ms_top;

  bit PCLK;
  bit PRESETn;
  wire PSLVERR;
  wire PREADY;
  wire PWRITE;
  wire PENABLE;
  wire PSELx;
  wire[31:0] PADDR;
  wire[31:0] PWDATA;
  wire[31:0] PRDATA;
  wire PSTRB;
  wire PPROT;
  
  apb3_m_intf mst_intf(PCLK,PRESETn);
  apb3_s_intf slv_intf(PCLK,PRESETn);
  apb3_ms_tst_bs_c test;
  string test_name;
  
  always #5 PCLK = ~PCLK;

  assign PSLVERR  = slv_intf.PSLVERR;
  assign PREADY   = slv_intf.PREADY;
  assign PWRITE   = mst_intf.PWRITE;
  assign PENABLE  = mst_intf.PENABLE;
  assign PSELx    = mst_intf.PSELx;
  assign PADDR    = mst_intf.PADDR;
  assign PWDATA   = mst_intf.PWDATA;
  assign PRDATA   = slv_intf.PRDATA;
  assign PSTRB    = slv_intf.PSTRB;
  assign PPROT    = slv_intf.PPROT;

  assign mst_intf.PSLVERR = PSLVERR; 
  assign mst_intf.PREADY = PREADY; 
  assign slv_intf.PWRITE = PWRITE; 
  assign slv_intf.PENABLE = PENABLE; 
  assign slv_intf.PSELx = PSELx; 
  assign slv_intf.PADDR = PADDR; 
  assign slv_intf.PWDATA = PWDATA; 
  assign mst_intf.PRDATA = PRDATA; 
  assign mst_intf.PSTRB = PSTRB; 
  assign mst_intf.PPROT = PPROT; 

  initial begin 
    PRESETn = 0;
    #5 PRESETn =1;
  end
  initial 
    begin
      if($value$plusargs("TEST_CASE=%s",test_name)) begin
        case (test_name)                     // Simplest Factory Implementation
          "apb3_ms_tst_bs_c" : test = new(mst_intf,slv_intf);
          "apb3_ms_tst_sgl_wr_wo_et_c" : 
            begin
            	apb3_ms_tst_sgl_wr_wo_et_c t1;
            	t1 = new(mst_intf,slv_intf);
            	test =t1; 
            end
          "apb3_ms_tst_sgl_rd_wo_et_c" :
            begin
              apb3_ms_tst_sgl_rd_wo_et_c t1;
              t1 = new(mst_intf,slv_intf);
              test =t1; 
            end
          "apb3_ms_tst_mlt_wr_wo_et_c" :
            begin
              apb3_ms_tst_mlt_wr_wo_et_c t1;
              t1 = new(mst_intf,slv_intf);
              test =t1; 
            end
          "apb3_ms_tst_mlt_rd_wo_et_c" :
            begin
              apb3_ms_tst_mlt_rd_wo_et_c t1;
              t1 = new(mst_intf,slv_intf);
              test =t1; 
            end
          "apb3_ms_tst_mlt_rd_wr_wo_et_c" :
            begin
              apb3_ms_tst_mlt_rd_wr_wo_et_c t1;
              t1 = new(mst_intf,slv_intf);
              test =t1; 
            end
          "apb3_ms_tst_sgl_wr_w_et_c" :
            begin
              apb3_ms_tst_sgl_wr_w_et_c t1;
              t1 = new(mst_intf,slv_intf);
              test =t1; 
            end
          "apb3_ms_tst_sgl_rd_w_et_c" :
            begin
              apb3_ms_tst_sgl_rd_w_et_c t1;
              t1 = new(mst_intf,slv_intf);
              test =t1; 
            end
          "apb3_ms_tst_mlt_wr_w_et_c" :
            begin
              apb3_ms_tst_mlt_wr_w_et_c t1;
              t1 = new(mst_intf,slv_intf);
              test =t1; 
            end
          "apb3_ms_tst_mlt_rd_w_et_c" :
            begin
              apb3_ms_tst_mlt_rd_w_et_c t1;
              t1 = new(mst_intf,slv_intf);
              test =t1; 
            end
        endcase
        $display("test_name = %s", test_name);
      end
    test.run();
    #1 $finish;
  end
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
    #3000 $finish;
  end 
  
  
  initial $vcdpluson;
  

 endmodule 
