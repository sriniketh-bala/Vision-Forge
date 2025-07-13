module bin_counter (
    input reset,
    input enable,
    input clk,
    output reg [3:0]C,
    output reg E
);

always @(posedge clk or reset) begin
  if (reset) begin
    C<=4'b0000;
    E<=0;
  end
  else begin
    if(enable) begin
        case (C)
        4'b1000: begin
          E<=1;
          C<=C+1'b1;
        end
        4'b1001: begin
          E<=0;
          C<=4'b0000;
        end 
        default: C<=C+1'b1;
        endcase
    end
  end 
end

endmodule //bin_counter


module Dec_counter (
    input reset,
    input clk,
    output reg [15:0] Out
);
wire en1,en2,en3,en4;
wire [3:0] out1,out2,out3,out4;
bin_counter B1(.reset(reset), .enable(1'b1), .clk(clk), .C(out1), .E(en1));
bin_counter B2(.reset(reset), .enable(en1), .clk(clk), .C(out2), .E(en2));
bin_counter B3(.reset(reset), .enable(en1 & en2), .clk(clk), .C(out3), .E(en3));
bin_counter B4(.reset(reset),.enable(en1 & en2 & en3), .clk(clk), .C(out4), .E(en4));
always @( posedge clk or reset) begin
    if(reset) begin
      Out= 16'b0;
    end    
    else begin
      Out[3:0]<=out1;
      Out[7:4]<=out2;
      Out[11:8]<=out3;
      Out[15:12]<=out4;
    end
end


endmodule //Dec_counter