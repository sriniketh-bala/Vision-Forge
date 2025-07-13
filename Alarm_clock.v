module Alarm_clock (
    input reset;
    input clk;
    input [1:0] H_in1;
    input [3:0] H_in0;
    input [2:0] M_in1;
    input [3:0] M_in0;
    input LD_time;
    input LD_alarm;
    input AL_ON;
    input STOP_al;
    output Alarm;
    output [1:0] H_out1;
    output [3:0] H_out0;
    output [2:0] M_out1;
    output [3:0] M_out0;
    output [2:0] S_out1;
    output [3:0] S_out0;
);
    reg [16:0] temp_s;
    reg [1:0] temp_hr ;
    reg [5:0] temp_min ;
    reg [4:0] al_hr;
    reg [5:0] al_min;
    reg [16:0] al_s;
    initial begin
      temp_s=0;
      temp_min=0;
      temp_hr=0;
    end
    always @(posedge clk or posedge reset) begin
        if(reset==1) begin
          temp_s<=0;
          temp_hr<=(H_in1*10 + H_in0);
          temp_min<=(M_in1*10 + M_in0) ;
          al_hr<=0;
          al_min<=0;
          Alarm<=0 ;
        end
        else begin
          temp_s=temp_s+1 ;
          temp_s= (temp_s)%60 ;
          temp_min= (temp_s==0)?(temp_min+1):(temp_min) ;
          temp_min= (temp_min)%60 ;
          temp_hr=((temp_min==0)&(temp_s==0))?(temp_hr+1):(temp_hr);
          temp_hr =(temp_hr)%24 ;
        end
    end
    always @(posedge LD_time or posedge LD_alarm) begin
        if (LD_time==1) begin
            temp_s<=0;
            temp_hr<=(H_in1*10 + H_in0);
            temp_min<=(M_in1*10 + M_in0) ;
        end
        else if (LD_alarm==1) begin
            al_hr<=(H_in1*10 + H_in0) ;
            al_min<=(M_in1*10 + M_in0) ;
        end
    end
    assign H_out1= temp_hr/10;
    assign H_out0= temp_hr%10;
    assign M_out1= temp_min/10;
    assign M_out0= temp_min%10;
    assign S_out1= temp_s/10;
    assign S_out0 = temp_s%10;
    always @(posedge clk) begin
        if(((temp_hr)==(al_hr))&((temp_min)==(al_min))&(AL_ON)&(temp_s==0)) begin
          Alarm<=1;
        end
        else if (STOP_al==1) begin
          Alarm<=0;
        end
    end

endmodule //Alarm_clock