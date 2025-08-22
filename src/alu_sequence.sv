
class alu_sequence extends uvm_sequence#(alu_sequence_item);
  
  `uvm_object_utils(alu_sequence)
  function new(string name = "alu_sequence");
    super.new(name);
  endfunction


  virtual task body();
    repeat(1)begin
    req = alu_sequence_item::type_id::create("req");
    wait_for_grant();
    req.randomize();
    send_request(req);
    wait_for_item_done();
	end
  endtask
endclass

class alu_inp_valid_high extends uvm_sequence#(alu_sequence_item);
  
  `uvm_object_utils(alu_inp_valid_high)
   
  function new(string name = "alu_inp_valid_high");
    super.new(name);
  endfunction
  
  virtual task body();
    `uvm_do_with(req,{req.cmd inside {0, 1, 2, 3};req.ce == 1;req.mode == 1;req.inp_valid == 1;})
      `uvm_info(get_type_name(), $sformatf("sequence sent opa = %0d opb = %0d inp=%0d cmd = %0d",req.opa,req.opb,req.inp_valid,req.cmd), UVM_LOW)
  endtask
endclass

class alu_arithmetic extends uvm_sequence#(alu_sequence_item);
  
  `uvm_object_utils(alu_arithmetic)
   
  function new(string name = "alu_arithmetic");
    super.new(name);
  endfunction
  
  virtual task body();
    `uvm_do_with(req,{req.inp_valid==3;req.mode == 1;req.cmd==0;})
  endtask
endclass

class alu_logical extends uvm_sequence#(alu_sequence_item);
  
  `uvm_object_utils(alu_logical)
   
  function new(string name = "alu_logical");
    super.new(name);
  endfunction
  
  virtual task body();
    repeat(10) begin
      `uvm_do_with(req,{req.inp_valid==3;req.mode == 1;req.cmd==0;})
    end
  endtask
endclass

class alu_regression extends uvm_sequence#(alu_sequence_item);
  
  alu_inp_valid_high  high;
  alu_arithmetic  arith;
  alu_logical logical;
  
  `uvm_object_utils(alu_regression)
   
  function new(string name = "alu_regression");
    super.new(name);
  endfunction
  
  virtual task body();
    `uvm_do(high)
    `uvm_do(arith)
    `uvm_do(logical)
  endtask
endclass
