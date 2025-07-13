module FSM (
    input reset,
    input clk,
    input x,
    output reg z
);
reg state;
parameter A =0 ;
parameter B =1 ;

always @(posedge clk or reset) begin
    if(!reset) begin
    case (state)
        A: state<= x?A:B;
        B: state<= x?B:A;
    endcase
    end
    else state<=B;
end

always @(state) begin
    case (state)
        A: z=0;
        B: z=1;
    endcase
end

endmodule //FSM