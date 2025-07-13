module Full_Addr (input a,input b, input cin, output s,output cout );
    assign s= (a&(~b)&(~cin))|((~a)&b&(~cin))|(a&b&cin)|((~a)&(~b)&cin);
    assign cout= a*b + ((~a)*b+ a*(~b))*cin;
endmodule
module four_bit_FA (input [3:0]A ,input [3:0]B ,output [4:0]sum);
    wire x;
    Full_Addr FA1(.a(A[0]),.b(B[0]),.cin(1'b0),.s(sum[0]),.cout(x));
    wire y;
    Full_Addr FA2(.a(A[1]),.b(B[1]),.cin(x),.s(sum[1]),.cout(y));
    wire z;
    Full_Addr FA3(.a(A[2]),.b(B[2]),.cin(y),.s(sum[2]),.cout(z));
    wire w;
    Full_Addr FA4(.a(A[3]),.b(B[3]),.cin(z),.s(sum[3]),.cout(sum[4]));
endmodule