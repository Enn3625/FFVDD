program hvac_test(hvac_intf intf);
environment env;
initial begin
env = new(intf);
env.gen.repeat_count = 100;
env.run();
end
endprogram

