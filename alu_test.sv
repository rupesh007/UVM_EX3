import uvm_pkg::*;
import alu_pkg::*;
`include"uvm_macros.svh"

class alu_test extends uvm_test;
  `uvm_component_utils(alu_test);
	 alu_config config_1; // configuration object
	 alu_env env_1;
	 //transaction_count = 10; // sets the number of transaction to 10
	 //alu_sequence seq;
	 
	 function new(string name = "alu_test",uvm_component parent=null);
		super.new(name,parent);
	 endfunction
		
	function void build_phase(uvm_phase phase);
	 
	     config_1 = alu_config::type_id::create("config_1",this); 
	 if(uvm_config_db # (virtual alu_if)::get(this,"*","top_alu",config_1.a_interface))
	   
		  config_1.number_of_transaction=10;
		  env_1 = alu_env::type_id::create ("env_1", this);
		  uvm_config_db # (alu_config)::set(this,"*","alu_config",config_1);
		//uvm_config_db # (virtual alu_if)::set(this,"*","alu_test",config_1.a_interface);//sets virtual interface in config database
		
	endfunction
	 
	 task run_phase (uvm_phase phase);
	   env_1.seq = alu_sequence::type_id::create("seq"); //creates seq with factory
	   phase.raise_objection(this);
	   env_1.seq.start(env_1.m_sequencer);  
	   phase.drop_objection(this);
    endtask
	 
endclass
	 
	 
