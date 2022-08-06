//Name: Volodymyr Semenov
//Date Created: May 15
//Purpose: Signal State Machine Testing
//Modules present: SignalSystem_tb
//Date of last update: May 17

//SignalSystem Testbench Module
module SignalSystem_tb;
  //Reg to hold inputs
  reg W_tb, E_tb, C_tb, CLK_tb;
  //Wires for outputs
  wire HL_tb, CL_tb;
  //Call on SignalSystem Module
  SignalSystem SystemTest(.W(W_tb),.E(E_tb),.C(C_tb),.CLK(CLK_tb),.HL(HL_tb),.CL(CL_tb));
   
  //Sets initial Values
   initial
     begin
       W_tb = 1;
       E_tb = 1;
       C_tb = 0;
       CLK_tb = 0;
     end
  
  //Cycles through different States with 3 inputs
  //All Inputs present to improve readability
  always
    begin
      //Should Stay in State HGD
      #2 W_tb = 1; E_tb = 1; C_tb = 0;
      #2 W_tb = 0; E_tb = 1; C_tb = 1;
      #2 W_tb = 1; E_tb = 0; C_tb = 1;
      
      //Should transition to State CGT
      #2 W_tb = 1; E_tb = 1; C_tb = 1;
      
      //Should transition to State HGD
      #2 W_tb = 1; E_tb = 0; C_tb = 1;
      
      //Should transition to State CGT
      #2 W_tb = 1; E_tb = 1; C_tb = 1;
      
      //Should transition to and stay in State CG
      #2 W_tb = 1; E_tb = 1; C_tb = 1;
      #2 W_tb = 1; E_tb = 1; C_tb = 1;
      
      //Should transition to State HGT
      #2 W_tb = 1; E_tb = 1; C_tb = 0;
      
      //Should transition to State HGD
      #2 W_tb = 0; E_tb = 0; C_tb = 0;     
    end
  
  //Cycles Clock
  always
    begin
      #1 CLK_tb = 1;
      #1 CLK_tb = 0;
    end
  
  //Setup Waveform
  initial
    begin
      //Creates File
      $dumpfile("DFFTest.vcd");
      //Dumps Variables
      $dumpvars;
    end
  
  initial
    begin
      //Seperates from warnings
      $display("----------------- Results -----------------");
      //Shows Inputs
      $display("CLK\tW\tE\tC\tHL\tCL");
      //Watches inputs and prints a new line every time inputs changes
      $monitor("%d\t%d\t%d\t%d\t%d\t%d",CLK_tb,W_tb, E_tb,C_tb,HL_tb, CL_tb);
    end
  
  //Ends the testbench after 2 input cycles
  initial
    #44 $finish;
  
  endmodule
