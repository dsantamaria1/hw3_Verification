
`timescale 1 ns / 1 ns

//________________________________________________________________________
//________________________________________________________________________
//
//          module ClkRstDriver(output reg clock, output reg reset );
//
// Description 
// ----------- 
//               This module generates the clock and reset signala.
//           
//
// Ports
// ------
//   clock       This is the free running ungated clock signal generated
//               by this module. 
//   reset       This is the reset signal  generated     by this module. 
//
//               
// Parameters
// ----------
//
//   CLK_INITIAL_LO
//               This parameter specifies thie initial lo_period for the generated
//               clock. This parameter along with CLK_INITIAL_HI specifies the 
//               clock period of the dssign. However the clock period can be programmed
//               by the using the API provided with this module
// 
//   CLK_INITIAL_HI
//               This parameter specifies thie initial hi_period for the generated
//               clock. This parameter along with CLK_INITIAL_LO specifies the 
//               clock period of the dssign. However the clock period can be programmed
//               by the using the API provided with this module
// 
//   CLK_INITIAL_OFFSET
//               This parameter is ignored by the module. It only exists to maintain
//               consistency with other moduels in this library
//
//________________________________________________________________________
//________________________________________________________________________


module ClkRstDriver (output reg clock, output reg reset);
// pragma attribute ClkRstDriver partition_module_xrtl
   parameter CLK_INITIAL_VALUE = 0;
   parameter NUM_RESET_CYCLES = 5;
   parameter CLK_INITIAL_HI = 2;
   parameter CLK_INITIAL_LO = 3;
   parameter CLK_INITIAL_OFFSET = 30;
   parameter RESET_ACTIVE_LOW = 1;

   

   logic internal_free_clk;
   logic internal_reset;
   
   assign clock = internal_free_clk;
   assign reset = internal_reset;

   prog_clk_driver #(CLK_INITIAL_OFFSET, CLK_INITIAL_LO, CLK_INITIAL_HI) prog_clk_driver_i1 (internal_free_clk);
   reset_driver  #(NUM_RESET_CYCLES) reset_driver_i1 (internal_free_clk, internal_reset);

   
endmodule // ClkRstDriver



module reset_driver(input wire hclk, output reg hreset );
   parameter      NUM_RESET_CYCLES = 5;   

   int    count;
   initial  begin
     hreset = 1;
       for (count = 0; count < NUM_RESET_CYCLES; count++)  begin
         @( posedge  hclk);
       end
       hreset = 0;
     end

endmodule // prog_clk_driver
   


//________________________________________________________________________
//________________________________________________________________________
//
//          module prog_clk_driver(output reg hclk );
//
// Description 
// ----------- 
//               This module is instiated by the ClkRstDriver module. 
//               This is pgorammable clock driver where the initial
//               value is 0. The initial clock delay is also zero. This
//               implies that the clock oscillations start from time 0. 
//           
//
// Ports
// ------
//   hclk:       This is the free running ungated clock signal generated
//               by this module. 
//
//               
// Parameters
// ----------
//
//   CLK_INITIAL_LO
//               This parameter specifies thie initial lo_period for the generated
//               clock. This parameter along with CLK_INITIAL_HI specifies the 
//               clock period of the dssign. However the clock period can be programmed
//               by the using the API provided with this module
// 
//   CLK_INITIAL_HI
//               This parameter specifies thie initial hi_period for the generated
//               clock. This parameter along with CLK_INITIAL_LO specifies the 
//               clock period of the dssign. However the clock period can be programmed
//               by the using the API provided with this module
// 
//   CLK_INITIAL_OFFSET
//               This parameter is ignored by the module. It only exists to maintain
//               consistency with other moduels in this library
//
// Programmable API:
// -----------------
//   function void v_setClockPeriod (input int hi, input int lo);
//               This API function can be called from external C function
//               and can be used to set the low time and hi time of the generated
//               clock signal. The parametes of this function are:
//                  (a) input int hi - Specify the hi time
//                  (b) input int lo - Specify the lo time
//________________________________________________________________________
//________________________________________________________________________





module prog_clk_driver(output reg hclk );
// pragma attribute ProgClkDriver_INIT0_WithoutInitialDelay partition_module_xrtl      
   parameter      CLK_INITIAL_OFFSET = 0;            
   parameter      CLK_INITIAL_LO = 3;
   parameter      CLK_INITIAL_HI = 2;   

   shortint 	   unsigned X = CLK_INITIAL_HI;
   shortint 	   unsigned Y = CLK_INITIAL_LO;
   reg             internalClk = 0;

   assign hclk = internalClk;   
//tbx clkgen      	      
   initial begin
      forever begin
	 internalClk = 0;
	 #(Y);
	 internalClk = 1;
	 #(X);
      end
   end

   function void v_setClockPeriod (input int hi, input int lo);
      begin
         $display("Function v_setClockPeriod called with hi = %d, lo = %d\n", hi, lo);
	 if(hi+lo > CLK_INITIAL_HI+CLK_INITIAL_LO) begin	    
	    X <= hi;
	    Y <= lo;	 
	    $display("(%t)  Setting Clk Intervals to %d  %d\n", $time(),  hi, lo);
	 end
	 else
	    $display("(%t)  Ignoring clk interval change request for %d  %d\n", $time(),  hi, lo);
      end
   endfunction //

   
endmodule // ClockDriverSub




//------------------------------------------------------------------------
// Top-level clock driver module
//------------------------------------------------------------------------

module clock_driver(
	output clk,
	output rst ); 


   // ----------------------------------------------------------------
   // -- Component Instantiations
   // ----------------------------------------------------------------

   // ----------------------------------------------------------------
   // -- ClkRstDriver
   // ----------------------------------------------------------------
   ClkRstDriver
      #(
        .CLK_INITIAL_VALUE(0),
        .CLK_INITIAL_OFFSET(10ns),
        .CLK_INITIAL_HI(2ns),
        .CLK_INITIAL_LO(3ns),
        .RESET_ACTIVE_LOW(1),
        .NUM_RESET_CYCLES(5)
       )
      intf1 (
        .clock(clk),
        .reset(rst)
      );


endmodule

