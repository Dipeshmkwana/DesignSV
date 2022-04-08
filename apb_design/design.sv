// Code your design here
//  Module: apb_add_master
//
module apb_add_master
  (
    input logic pclk,
    input logic preset_n, // Active low reset

    input logic[1:0] add_i, // 1'b00 - NOP, 2'b01 - Read, 2'b11 write

    output  logic       psel_o,
    output  logic       penable_o,
    output  logic[31:0] paddr_o,
    output  logic[31:0] pwdata_o,
    output  logic       pwrite_o,
    input   logic[31:0] prdata_i,
    input   logic       pready_i
  );

  typedef enum logic[1:0] {
    ST_IDLE,
    ST_SETUP,
    ST_ACCESS
  } apb_state_t;

  apb_state_t state_q;    //Current state
  apb_state_t next_state; //next state

  logic apb_state_setup;
  logic apb_state_access;

  logic next_pwrite;
  logic pwrite_q;

  logic[31:0] next_rdata;
  logic[31:0] rdata_q;

  always_ff @(posedge  pclk or negedge preset_n)
    if (~preset_n)
      state_q <= ST_IDLE;
    else 
      state_q <= next_state;

  //state machine
  always_comb begin: apb_state_machine
    next_pwrite = pwrite_q;
    case (state_q)
      ST_IDLE:
        if (add_i[0]) begin
          next_state = ST_SETUP;
          next_pwrite = add_i[1];
        end else begin
          next_state = ST_IDLE;
        end
      ST_SETUP: next_state = ST_ACCESS;
      ST_ACCESS:
      if(pready_i) begin
        if(~pwrite_q)
          next_rdata = prdata_i;
        next_state = ST_IDLE;
      end else
        next_state = ST_ACCESS;
      default: next_state = ST_IDLE;
    endcase
  end: apb_state_machine

  assign apb_state_access =  (state_q == ST_ACCESS);
  assign apb_state_setup =   (state_q == ST_SETUP);

  assign psel_o =  apb_state_setup | apb_state_access;
  assign penable_o = apb_state_access;

  // APB Address 
  assign paddr_o = {32{apb_state_access}} & 32'hA000;

  // APB PWRITE control signal
  always_ff @(posedge pclk or negedge preset_n)
    if (~preset_n)
      pwrite_q <= 1'b0;
    else
      pwrite_q <= next_pwrite;

  assign pwrite_o = pwrite_q;
  // APB PDATA data signal
  //ADDER
  //Read a value from the slave at address 0xA000
  //INcarement that vlaue 
  //Send that value back during the write operation to address 0xA000
  assign pwdata_o = {32{apb_state_access}} & (rdata_q + 32'h1);

  always_ff @(posedge pclk or negedge preset_n)
  if(~preset_n)
    rdata_q <= 32'h0;
  else
    rdata_q <= next_rdata;

  
endmodule: apb_add_master
