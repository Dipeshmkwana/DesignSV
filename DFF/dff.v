// Code your design here
//design D flip flop
module dff(clk, reset, d, q, qb);
    input clk, reset, d;
    output q,qb;
    
    reg q;
    
    assign qd = ~q;
    
    always @(posedge clk or posedge reset)
      begin 
        if (reset) begin 
          //Asynchronious reset when reset goes high
          q <= 1'b0;
        end else begin
          //Assign D to Q on positive clock edge
          q <= d;
        end 
      end
    
  endmodule 