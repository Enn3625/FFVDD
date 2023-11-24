module top;
	bit clk;
	bit rst;
	intf vif(clk,rst);
	test t1(vif);
	usr dut(.clk(vif.clk),
	.rst(vif.rst),
	.ctrl(vif.ctrl),
	.d(vif.d),
	.q(vif.q)

	);
always #5 clk = ~clk;
initial begin
rst=1;
#5
rst=0;
end
endmodule

