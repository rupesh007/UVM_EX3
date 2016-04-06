module top;

import uvm_pkg::*;
import alu_pkg::*;

bit tclk,treset;


initial begin
    #20;
    forever begin
      #(10) tclk=~tclk;
   end
end
   

//hardware instatntiations
alu_driver driver;
alu_if alu_interface(tclk);
alu_test test1;


//alu8 alu_dut(.clk(tclk),
//             .reset(treset),
//             .op_code(test1.config_1.a_interface.op_code),
//             .operand_1(test1.config_1.a_interface.operand_1),
//             .operand_2(test1.config_1.a_interface.operand_2),
//             .shift_rotate(test1.config_1.a_interface.shift_rotate),
//             .result(test1.config_1.a_interface.result),
//             .carry(test1.config_1.a_interface.carry));




// binds DUT and interface
alu8 alu_dut(.clk(tclk),
             .reset(treset),
             .op_code(alu_interface.op_code),
             .operand_1(alu_interface.operand_1),
             .operand_2(alu_interface.operand_2),
             .shift_rotate(alu_interface.shift_rotate),
             .result(alu_interface.result),
             .carry(alu_interface.carry));


initial begin 
	test1=new ("test case 1 for alu"); // creates test1
	uvm_config_db # (virtual alu_if)::set(null,"*","top_alu",alu_interface);
	run_test(); // this starts the testbench
	//tclk=0;
end 

endmodule: top