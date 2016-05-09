
/**
 * @brief Testbench Top
 * This is module is the top level testbench for the pcounter  DUT.
 *
 * This top level module instantiates the top of the HDL  (hdl_top),
 *
 * It runs the This top level module instantiates the DUT (pcounter),
 *
 */

`timescale 1 ns / 1 ns
`include "config_item.sv"

module tb_top ();

  logic clk;
  logic rst;

  hdl_top     hdl_top_i();

  config_item   c1; 
  virtual pcounter_if      pc_vif ;

 /**
   * @brief initialize the pcounter interface
   *
   * @param none
   * @return void
   */


  function void initialize_pcounter_if();
       hdl_top_i.get_interface(pc_vif);
  endfunction


 /**
   * @brief drives the transaction on the hardware
   *
   * @param config_item seq - the item to be driven
   * @return void
   */


  task drive_transaction(config_item  item); 
  // sets the enable sig and drives the data
  // and addr values on the interface
  // It resets the enable sig after one clock
  // cycle

    pc_vif.cfg_enable_sig = 1;
    pc_vif.cfg_rd_wr_sig = 0;
    pc_vif.cfg_addr_sig = item.get_addr();
    pc_vif.cfg_wdata_sig = item.get_data();
   
    @(posedge pc_vif.clk_sig);
    //dsm_tmp
    @(posedge pc_vif.clk_sig);
    pc_vif.cfg_enable_sig = 0;


  endtask

 /**
   * @brief checks if the counteroutput is of a given value
   *
   * @param int val - the value that is expected
   * @return int 
   */

  function int xcheck_dut (int val);
    if ($root.tb_top.hdl_top_i.dut.counter_o_sig != val) begin
      $display("----------------------------------");
      $display("(%t) Consistency Check Failed", $time());;
      $display("----------------------------------");
      $finish();
    end
    else
      $display("----------------------------------");
      $display("(%t) Consistency Check passed", $time());;
      $display("----------------------------------");
      return(0);
  endfunction
     

  // TB Top Process
  initial begin
    $timeformat(-9, 0, " ns", 5); // show time in ns
    initialize_pcounter_if();
    #500; 
 
    // Fixme: Lab1 -Begin
      // Create a new config_item object and assign to variable c1
      c1 = new();
      // Set addr to 0 and data to 1 for c1
      c1.set_addr(3'h0);
      c1.set_data(10'h1);

      // Call method print for c1
      c1.print();
      // Call task drive_transaction with config_item c1 as argument
      drive_transaction(c1);

    //DSM
    // Fixme: Lab1 -End

    #500; 

    // Fixme: Lab1 -Begin
      // Create a new config_item object and assign to variable c1
      c1 = new();
      // Set addr to 3 and data to 3 for c1
      c1.set_addr(3'h3);
      c1.set_data(10'h3);
      // Call method print for c1
      c1.print();
      // Call task drive_transaction with config_item c1 as argument
      drive_transaction(c1);

    // Fixme: Lab1 -End

    #500; 

    $finish();

  end

    // Dump waves
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, tb_top);
  end
endmodule : tb_top
