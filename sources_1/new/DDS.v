module DDS(
    sys_clk ,
    rst_n   ,
    Fword   ,
    Pword   ,
    Data    
    );

    input                               sys_clk                    ;
    input                               rst_n                      ;
    input              [  31:0]         Fword                      ;//Ƶ�ʿ�����
    input              [  11:0]         Pword                      ;//��λ������
    output             [   11:0]         Data                       ;


reg                    [  31:0]         Fword_r                    ;//ͬ��Ƶ�ʼĴ���
reg                    [  11:0]         Pword_r                    ;//ͬ����λ�Ĵ���
reg                    [  31:0]         P_Acc                      ;//��λ�ۼӼĴ���
reg                    [  31:0]         P_Acc_out                  ;

wire                   [  11:0]         Rom_Adder                  ;//�������ݱ�

always@(posedge sys_clk or negedge rst_n)begin
    if(!rst_n)begin
        Fword_r <= 0;
    end
    else
    Fword_r <= Fword;
end

always@(posedge sys_clk or negedge rst_n)begin
    if(!rst_n)begin
        Pword_r <= 0;
    end
    else
    Pword_r <= Pword;
end


always@(posedge sys_clk or negedge rst_n)begin
    if(!rst_n)begin
        P_Acc <= 0;
    end
    else
    P_Acc <= Fword_r + P_Acc;
end

always@(posedge sys_clk or negedge rst_n)begin
    if(!rst_n)begin
        P_Acc_out <= 0;
    end
    else
    P_Acc_out <= {Pword,20'b0} + P_Acc;
end

assign Rom_Adder = P_Acc_out[31:20];

blk_mem_gen_0 rom_sin (
    .clka                              (sys_clk                   ),// input wire clka
    .addra                             (Rom_Adder                 ),// input wire [11 : 0] addra
    .douta                             (Data                      ) // output wire [11 : 0] douta
);

endmodule
