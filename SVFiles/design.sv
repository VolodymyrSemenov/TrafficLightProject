//Name: Volodymyr Semenov
//Date Created: May 15
//Purpose: Signal State Machine
//Modules present: DFF, SignalSystem
//Date of last update: May 17


//D-Flip Flop Module to be used in the Signal System
module DFF(D, Clk, Q, QN);
  //Inputs
  input D, Clk;
  //Outputs
  output Q, QN;
  //Wires to hold Values
  reg Q, QN;
  
  //Sets initial flip flop value to 1
  initial
    begin
    Q <= 1;
    end
  
  //On Clock trigger updates Output Q
  always@(posedge Clk)
        Q <= D;
  
  //Sets output QN to the opposite of Q on every update of Q
  always@(Q)
    QN <= !Q;
endmodule


module SignalSystem(W, E, C, CLK, HL, CL);
  //Inputs
  input W, E, C, CLK;
  //Outputs
  output HL, CL;
  //Wires to Hold Inputs and Outputs of called Flip Flop Modules
  wire Q_0, QN_0, D_0;
  wire Q_1, QN_1, D_1;
  
  //Instantiates DFF twice for state storage
  DFF S0(.D(D_0), .Clk(CLK), .Q(Q_0), .QN(QN_0));
  DFF S1(.D(D_1), .Clk(CLK), .Q(Q_1), .QN(QN_1));

  //Continuous Assingment Statements for D-Flip Flop Inputs
  assign D_0 = ~E | ~W | (QN_1 & Q_0) | (Q_1 & ~C);
  assign D_1 = QN_1 | (QN_0 & E & C & W) | (Q_0 & (~E | ~C | ~W ));
  
  //Continuous Assingment Statements for both Outputs
  assign HL = Q_0 & Q_1;
  assign CL = QN_0 & Q_1;
endmodule
