
/**
 * @brief Config item base class
 *
 * The Config item base class is the base class for all the transaction items
 *  *
 * <ul>
 * <li> int id;http://www.edaplayground.com/home#testbench0  </li>
 * <li> static global count; </li>
 *  </ul>
 * <br>
 *
 *
 * @class config_item_base
 *
 */



class config_item_base;

//Fixme: Lab1 -Begin
    // Declare two integer variables 
    // (a) m_pkt_id, and (b) static variable m_global_pkt_count;
    //
    int m_pkt_id = 0;
    static int m_global_pkt_count;  
  
//DSM
//Fixme: Lab1 -End

/**
   * @brief Constructor
   * Method to construct this class item
   *
   */


  function new();

//Fixme: Lab1    - Begin
    // Increment variable m_global_pkt_count
    m_global_pkt_count++;

    // Assign value of m_global_pkt_count to variable m_pkt_id 
    m_pkt_id = m_global_pkt_count;
    
//DSM
//Fixme: Lab1 - End

  endfunction: new


 /**
   * @brief Get id
   * Get the pkt id 
   *
   * @return int
   */

  extern function int get_id();


 /**
   * @brief print
   * Prints the class details )
   * 
   * @param  none
   * @return void
   */
//Fixme: Lab1 - Begin

  // Declare the print() function as a virtual function
  // It takes no parameters
  extern function void print();
      
//DSM
//Fixme: Lab1 - End


endclass : config_item_base


//--------------------------------------------------------
// function get_id()
//--------------------------------------------------------

//Fixme: Lab1 - Begin

// Define the get_id () function here
function int config_item_base::get_id();
   return m_pkt_id;
endfunction

//DSM
//Fixme: Lab1 - End

//--------------------------------------------------------
// function print()
//--------------------------------------------------------

//Fixme: Lab1 - Begin

// Define the print() function here
function void config_item_base::print();
  $display("m_global_pkt_count = %0d", m_global_pkt_count);
  $display("m_pkt_id = %0d", m_pkt_id);
endfunction: print
    
//DSM
//Fixme: Lab1 - End










