`timescale 1ns / 1ps
module DDS__USER_TB;

reg                                     sys_clk                    ;
reg                                     rst_n                      ;
wire                   [  13:0]         Data                       ;
reg                                     key_in                     ;

reg                    [   2:0]         Fword_sel                  ;
wire                   [  11:0]         Data_r1                    ;
wire                   [  11:0]         Data_r2                    ;

initial begin
    sys_clk = 0;
end

always #10 sys_clk = ~sys_clk;

initial begin
    rst_n = 0;
    Fword_sel = 0;
    key_in = 0;
    #201;
    rst_n = 1'b1;

    #50000000;
    Fword_sel = 1;
    #50000000;

    Fword_sel = 2;

    #50000000;
    Fword_sel = 4;

end

// DDS_use u_DDS_use(
//     .sys_clk ( sys_clk ),
//     .rst_n   ( rst_n   ),
//     .Data    ( Data    ),
//     .key_in  ( key_in  )
// );

// DDS_use u_DDS_use(
//     .sys_clk ( sys_clk ),
//     .rst_n   ( rst_n   ),
//     .Data    ( Data    ),
//     .key_in  ( key_in  ),
//     .Fword_r_tb  ( Fword_sel  )
// );
//Fword_r_tb用于连接仿真和模块的Fword_sel寄存器
DDS_use u_DDS_use(
    .sys_clk                           (sys_clk                   ),
    .rst_n                             (rst_n                     ),
    .Data_r1                           (Data_r1                   ),
    .Data_r2                           (Data_r2                   ),
    .key_in                            (key_in                    ),
    .c_clk                             (c_clk                     ),
    .LOADDAC                           (LOADDAC                   ),
    .CS                                (CS                        ),
    .R_W                               (R_W                       ),
    .key_1                             (key_1                     ),
    .key_2                             (key_2                     ),
    .key_3                             (key_3                     ),
    .Fword_r_tb                        (Fword_sel                 ) 
);

endmodule
