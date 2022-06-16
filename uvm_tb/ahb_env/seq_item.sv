//  Class: switch_item
//
`ifndef AHB_ITEM_SV
`define AHB_ITEM_SV

class switch_item extends uvm_sequence_item;
  typedef switch_item this_type_t;
  `uvm_object_utils(switch_item);

  //  Group: Variables
  rand bit [7:0]  	addr;
  rand bit [15:0] 	data;
  bit [7:0] 		addr_a;
  bit [15:0] 		data_a;
  bit [7:0] 		addr_b;
  bit [15:0] 		data_b;

  //  Group: Constraints


  //  Group: Functions
  // Use utility macros to implement standard functions
  // like print, copy, clone, etc
  //`uvm_object_utils_begin(switch_item)
  //	`uvm_field_int (addr, UVM_DEFAULT)
  //	`uvm_field_int (data, UVM_DEFAULT)
  //	`uvm_field_int (addr_a, UVM_DEFAULT)
  //	`uvm_field_int (data_a, UVM_DEFAULT)
  //	`uvm_field_int (addr_b, UVM_DEFAULT)
  //	`uvm_field_int (data_b, UVM_DEFAULT)
  //`uvm_object_utils_end

  //  Constructor: new
  function new(string name = "switch_item");
    super.new(name);
  endfunction: new

  //  Function: do_copy
  // extern function void do_copy(uvm_object rhs);
  //  Function: do_compare
  // extern function bit do_compare(uvm_object rhs, uvm_comparer comparer);
  //  Function: convert2string
  // extern function string convert2string();
  //  Function: do_print
  // extern function void do_print(uvm_printer printer);
  //  Function: do_record
  // extern function void do_record(uvm_recorder recorder);
  //  Function: do_pack
  // extern function void do_pack();
  //  Function: do_unpack
  // extern function void do_unpack();
  
endclass: switch_item


/*----------------------------------------------------------------------------*/
/*  Constraints                                                               */
/*----------------------------------------------------------------------------*/




/*----------------------------------------------------------------------------*/
/*  Functions                                                                 */
/*----------------------------------------------------------------------------*/

`endif