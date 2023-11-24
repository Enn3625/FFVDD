class environment;
generator gen;
bfm h_bfm;
virtual hvac_intf intf;
mailbox gen2bfm;
event ended;
function new(virtual hvac_intf intf);
this.intf = intf;
gen2bfm = new();
gen = new(gen2bfm, ended);
h_bfm = new(intf, gen2bfm);
endfunction
task pre_test;
h_bfm.reset();
endtask



task test;
fork
gen.main();
h_bfm.main();
//cov.main();
join_any
endtask
task post_test;
wait(ended.triggered);
wait(gen.repeat_count == h_bfm.no_transactions);
endtask
task run;
pre_test();
test();
post_test();
$finish;
endtask
endclass

