`timescale 1 ns / 1 ns

module hdl_top;


   // ----------------------------------------------------------------
   // -- Signal Declarations
   // ----------------------------------------------------------------
   wire clk;
   wire rst;

   // ----------------------------------------------------------------
   // -- Component Instantiations
   // ----------------------------------------------------------------

   // ----------------------------------------------------------------
   // -- Clock
   // ----------------------------------------------------------------
   clock_driver u_clock(
     .clk(clk),
     .rst(rst));

   // ----------------------------------------------------------------
   // -- DUT (Design Under Test)
   // ----------------------------------------------------------------
   pcounter_wrapper dut(
     .clk(clk),
     .rst(rst));


   pcounter_if pcounter_cfg_if_i(.clk(clk));

   // Input to the design
   assign dut.cfg_enable_sig = pcounter_cfg_if_i.cfg_enable_sig;
   assign dut.cfg_rd_wr_sig  = pcounter_cfg_if_i.cfg_rd_wr_sig;
   assign dut.cfg_addr_sig   = pcounter_cfg_if_i.cfg_addr_sig;
   assign dut.cfg_wdata_sig  = pcounter_cfg_if_i.cfg_wdata_sig;

   // Output from  the design

   //
   // 
   // 

   function void get_interface(output virtual pcounter_if pc_vif);
       pc_vif = pcounter_cfg_if_i;
   endfunction


endmodule

