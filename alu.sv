module alu(input logic [7:0] a,b,
           input logic [1:0] op,
           input logic valid,
           output logic [7:0] result);
  always @(*) begin
    if (valid) begin
      case (op) 
        2'b00:result=a+b;
        2'b01:result=a-b;
        2'b10:result=a*b;
        2'b11:result=a|b;
      
      endcase
    end
      else begin
        result=8'h00;
      end
    
    end
endmodule
