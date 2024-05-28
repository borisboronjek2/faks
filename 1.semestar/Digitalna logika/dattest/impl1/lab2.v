/* Verilog model created from schematic lab2.sch -- Nov 05, 2020 10:23 */

module lab2( btn_center, btn_down, btn_left, btn_right, btn_up, clk_25m, led, rs232_tx );
 input btn_center;
 input btn_down;
 input btn_left;
 input btn_right;
 input btn_up;
 input clk_25m;
output [7:0] led;
output rs232_tx;
wire N_11;
wire N_12;
wire N_13;
wire N_10;
wire N_4;
wire N_6;
wire N_8;
wire N_9;
wire N_1;



OR3 I44 ( .A(btn_up), .B(btn_center), .C(btn_right), .Z(N_8) );
INV I45 ( .A(btn_center), .Z(N_4) );
AND2 I46 ( .A(N_4), .B(btn_left), .Z(N_10) );
AND2 I47 ( .A(btn_down), .B(btn_right), .Z(N_6) );
OR2 I48 ( .A(btn_center), .B(N_6), .Z(N_12) );
OR2 I49 ( .A(btn_center), .B(btn_right), .Z(N_11) );
OR4 I51 ( .A(N_6), .B(N_10), .C(btn_up), .D(btn_center), .Z(N_13) );
OR4 I50 ( .A(btn_left), .B(btn_center), .C(btn_up), .D(btn_right), .Z(N_9) );
OB I19 ( .I(N_12), .O(led[3]) );
OB I18 ( .I(N_13), .O(led[1]) );
OB I20 ( .I(N_11), .O(led[2]) );
OB I21 ( .I(N_11), .O(led[0]) );
OB I22 ( .I(btn_up), .O(led[4]) );
OB I23 ( .I(N_9), .O(led[6]) );
OB I24 ( .I(N_8), .O(led[5]) );
OB I25 ( .I(N_1), .O(led[7]) );
serial_tx I1 ( .byte_in({ N_1,N_9,N_8,btn_up,N_12,N_11,N_13,N_11 }),
            .clk(clk_25m), .ser_out(rs232_tx) );

endmodule // lab2
