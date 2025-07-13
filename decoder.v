module decode (a,b,c,e);
    input a,e;
    output b;
    output c;
    always@(*) begin
        if(e==1) begin
             assign b=a;
             assign c=~a;
        end
        if(e==0) begin
            assign b=0;
            assign c=0;
        end
      
    end
    
endmodule