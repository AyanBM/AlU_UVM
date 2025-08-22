
class alu_base extends uvm_test;

  `uvm_component_utils(alu_base)

 alu_environment alu_env;

  function new(string name = "alu_base",uvm_component parent=null);
    super.new(name,parent);
  endfunction : new

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    alu_env = alu_environment::type_id::create("alu_environment", this);
    
  endfunction : build_phase

virtual function void end_of_elaboration();
 print();
endfunction


endclass 

class inp_high_test extends alu_base;

  `uvm_component_utils(inp_high_test)

  function new(string name = "inp_high_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual task run_phase(uvm_phase phase);
    alu_inp_valid_high seq;
    phase.raise_objection(this);
    repeat(30)begin
    seq = alu_inp_valid_high::type_id::create("seq");
    seq.start(alu_env.alu_agent_1.alu_sequencer_1);
    end
    phase.drop_objection(this);
  endtask

endclass

class arith_test extends alu_base;

  `uvm_component_utils(arith_test)

  function new(string name = "arith_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual task run_phase(uvm_phase phase);
    alu_arithmetic seq;
    phase.raise_objection(this);

    seq = alu_arithmetic::type_id::create("seq");
    seq.start(alu_env.alu_agent_1.alu_sequencer_1);

    phase.drop_objection(this);
  endtask

endclass


class logical_test extends alu_base;

  `uvm_component_utils(logical_test)

  function new(string name = "logical_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual task run_phase(uvm_phase phase);
    alu_logical seq;
    phase.raise_objection(this);

    seq = alu_logical::type_id::create("seq");
    seq.start(alu_env.alu_agent_1.alu_sequencer_1);

    phase.drop_objection(this);
  endtask

endclass

class alu_regression_test extends alu_base;

  `uvm_component_utils(alu_regression_test)

  function new(string name = "alu_regression_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual task run_phase(uvm_phase phase);
    alu_regression seq;
    phase.raise_objection(this);
    repeat(10)begin
    seq =  alu_regression::type_id::create("seq");
    seq.start(alu_env.alu_agent_1.alu_sequencer_1);
    end
    phase.drop_objection(this);
  endtask

endclass
