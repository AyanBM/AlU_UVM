`include "define.sv"
interface alu_if(input bit clk,rst);
  logic [`width-1:0] opa,opb;
  logic [`cmd_width-1:0]cmd;
  logic [1:0]inp_valid;
  logic ce,cin,mode;

  logic err,oflow,cout,g,l,e;
  logic [`width+1:0] res;

  clocking drv_cb@(posedge clk);
    default input #0 output #0;
    output opa,opb,cmd,inp_valid,ce,cin,mode;
  endclocking

  clocking mon_cb@(posedge clk);
    default input #0 output #0;
    input  err,oflow,cout,g,l,e,res;
  endclocking

  modport DRV (clocking drv_cb);
  modport MON(clocking mon_cb);
    
 endinterface
