class transaction;
//rand bit clk;
//rand bit reset;
rand bit I1;
rand bit I2;
rand bit I3;
rand bit I4;
rand bit  O1;
rand bit  O2;
rand bit  O3;
rand bit  O4;
function void display();
$display(" ");
$display("\t \t I1 = %0b, \t I2 = %0b,\t I3 = %0b, \t I4 = %0b, \t O1 = %0b, \t O2 = %0b, \t O3 = %0b, \t O4 = %0b",I1,I2,I3,I4,O1,O2,O3,O4);
$display(" ");
endfunction
endclass

