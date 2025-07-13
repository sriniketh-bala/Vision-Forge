module JKff(J,K,clk,Q);
    input J;
    input K;
    input clk;
    output Q;
    wire D;
    assign D=((J)&(~Q))|((~K)&(Q));
    dff inst1(.in(D),.clk(clk),.out(Q));
endmodule
module dff(input in, input clk, output reg out);
    initial begin
        out=0;
    end
    always @(posedge clk) begin
        out<=in; 
    end

endmodule