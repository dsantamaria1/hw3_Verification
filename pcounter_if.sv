
`ifndef PCOUNTER_IF__SV
`define PCOUNTER_IF__SV

`timescale 1ns / 1ps

/**
 * @brief Pcounter Interface.
 * This interface is used to program the deice.
 * Modports:
 * <ul>
 *  <li> bfm - bus functional model - has bfm_cb clking block </li>
 *  <li> mon - passive monitor - has mon_cb clking block</li>
 * </ul>
 *
 * @param clk bit - input clock
 */
interface pcounter_if (input logic clk);

  logic		cfg_enable_sig;
  logic         cfg_rd_wr_sig;
  logic [2:0] 	cfg_addr_sig;
  logic [9:0] 	cfg_wdata_sig;
  logic         clk_sig; 

 //
 // 
 //

  assign clk_sig = clk;

endinterface: pcounter_if

`endif

