
/**
 * @brief cfg Item Class.
 *
 * The cfg item Class  is a transaction class that
 * creates pkts for controlling the pcounter. It has 
 * two additional members:
 *  *
 * <ul>
 * <li> m_addr : address of the register being programmed
 * <li> m_data : data value for the register
 *  </ul>
 * <br>
 *
 *
 * @class cfg_item 
 *
 */

`include "config_item_base.sv"

class config_item extends config_item_base;



//Fixme: Lab1 -Begin
  // declare variables m_addr and m_data here
  int m_addr;
  int m_data;

//DSM
//Fixme: Lab1 -End

/**
   * @brief Constructor
   * Method to construct the config_item class
   *
   */

  function new();

//Fixme: Lab1 -Begin
  // Implement class constructor function
  // Call constructor of parent class
  super.new();
  // Display string "Creating a new configuration packet"
  $display("Creating a new configuration packet");
  // Initialize class properties m_addr and m_data to 0
  this.m_addr = 0;
  this.m_data = 0;

//DSM
//Fixme: Lab1 -End

  endfunction: new

 /**
   * @brief set_data
   * Set the data value in the pkt
   *
   * @param int i1 - set the data value
   * @return void
   */

  extern function void set_data(int i1);

 /**
   * @brief Set addr
   * Set the addr in the pkt
   *
   * @param int i1 - set the addr
   * @return void
   */


  extern function void set_addr(int i1);

 /**
   * @brief Get addr
   * Get the addr  value  in the pkt
   *
   * @return int
   */


  extern function int get_addr();

 /**
   * @brief Get data
   * Get the data  in the pkt
   *
   * @return int
   */


  extern function int get_data();


 /**
   * @brief Report 
   * Prints the class details (hi/low value)
   *
   * @return void
   */

  extern virtual function void print(); 

endclass : config_item


//--------------------------------------------------------
// function set_addr()
//--------------------------------------------------------

//Fixme: Lab1 -Begin
    function void config_item::set_addr(int i1);
    	m_addr = i1;
    endfunction

//DSM
//Fixme: Lab1 -End

//--------------------------------------------------------
// function set_data()
//--------------------------------------------------------

//Fixme: Lab1 -Begin
    function void config_item::set_data(int i1);
    	m_data = i1;
    endfunction
    
//DSM
//Fixme: Lab1 -End

//--------------------------------------------------------
// function get_addr()
//--------------------------------------------------------

//Fixme: Lab1 -Begin
    function int config_item::get_addr();
    	return m_addr;
    endfunction

//DSM
//Fixme: Lab1 -End

//--------------------------------------------------------
// function get_data()
//--------------------------------------------------------

//Fixme: Lab1 -Begin
    function int config_item::get_data();
    	return m_data;
    endfunction
    
//DSM
//Fixme: Lab1 -End


//--------------------------------------------------------
// function print();
//--------------------------------------------------------


function void config_item::print();
    $display("Printing the pkt contents");
    $display("---Pkt Id --- %3d", get_id());
    $display("---Addr   --- %3d", get_addr());
    $display("---Value  --- %3d", get_data());
endfunction





