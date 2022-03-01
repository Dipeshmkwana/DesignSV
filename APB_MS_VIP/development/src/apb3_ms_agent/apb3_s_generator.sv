
class apb3_slv_gen_c;
  
  apb3_s_txn_c trans;
  apb3_s_txn_c tr;
  int  repeat_count;
  mailbox gen2driv;
  event apb3_s_gen_ended;
  
  function new(mailbox gen2driv,event apb3_s_gen_ended);
    this.gen2driv = gen2driv;
    this.apb3_s_gen_ended = apb3_s_gen_ended;
    trans=new();
  endfunction
  
  task apb3_slv_gen_run_t();
    $display("GENERATOR VALUE ARE :-");
    repeat(repeat_count) begin
    tr = new();
    if(!trans.randomize()) $display("Gen :: randomization failed");
	tr=trans.txn_do_copy();
    gen2driv.put(tr);
    $display("%0t GEN_V =>  PWRITE=%b,PENABLE=%b,PSELx=%b,PREADY=%b,PADDR=%16h,PWDATA=%16h,PRDATA=%16h",$time,tr.PWRITE,tr.PENABLE,tr.PSELx,tr.PREADY,tr.PADDR,tr.PWDATA,tr.PRDATA);	
    end
	-> apb3_s_gen_ended;
  endtask:apb3_slv_gen_run_t

endclass: apb3_slv_gen_c
