module cc(in,clk,Q);
    input in;
    input clk;
    output Q;
    wire D;
    assign D=in^Q;
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