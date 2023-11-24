class bfm;
virtual hvac_intf intf;
mailbox gen2bfm;
int no_transactions;
function new(virtual hvac_intf intf,mailbox gen2bfm);
this.intf = intf;
this.gen2bfm = gen2bfm;
endfunction
task reset;

wait(intf.reset);
$display("Reset Initiated");
//intf.bfm_cb.clk <= 0;
//intf.bfm_cb.reset <= 0;
intf.bfm_cb.I1 <= 0;
intf.bfm_cb.I2 <= 0;
intf.bfm_cb.I3 <= 0;
intf.bfm_cb.I4 <= 0;
wait(!intf.reset);
$display("Reset finished");
endtask



task main;
forever begin
transaction trans;
gen2bfm.get(trans);
$display("Transaction No. = %0d", no_transactions);
//intf.bfm_cb.clk <= trans.clk;
//intf.bfm_cb.reset <= trans.reset;
intf.bfm_cb.I1 <= trans.I1;
intf.bfm_cb.I1 <= trans.I2;
intf.bfm_cb.I1 <= trans.I3;
intf.bfm_cb.I1 <= trans.I4;
repeat(2)@(posedge intf.clk);
trans.O1 = intf.O1;
trans.O2 = intf.O2;
trans.O3 = intf.O3;
trans.O4 = intf.O4;
trans.display();
no_transactions++;
end
endtask
endclass

