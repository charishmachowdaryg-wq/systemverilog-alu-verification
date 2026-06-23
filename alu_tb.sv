module tb;
  logic [7:0] a,b;
  logic [1:0] op;
  logic valid;
  logic [7:0] result;
  alu dut(.a(a),.b(b),.op(op),.valid(valid),.result(result));
  covergroup cp_cp;
    cp_a:coverpoint a{
      bins zero={8'h00};
      bins max={8'hff};
      bins others={[8'h01:8'hfe]};
    }
     cp_b:coverpoint b{
      bins zero={8'h00};
      bins max={8'hff};
       bins others={[8'h01:8'hfe]};
    }
    cp_op:coverpoint op{
      bins add_op={2'b00};
      bins sub_op={2'b01};
      bins and_op={2'b10};
      bins or_op={2'b11};
    }
    cp_valid:coverpoint valid{
      bins active={1};
      bins inactive={0};
    }
    cx_op_valid:cross cp_op,cp_valid;
  endgroup
  cp_cp cp=new();
  task task1(input logic [7:0] in_a,
             input logic [7:0] in_b,
             input logic [1:0] in_op,
             input logic in_valid);
    
    a=in_a;
    b=in_b;
    op=in_op;
    valid=in_valid;
    #10;
    $display("a=%0h,b=%0h,op=%0h,valid=%0h",a,b,op,valid);
    cp.sample();
  endtask
  task scoreboard();
  logic [7:0] expected;
  if(!valid)
    expected = 8'h00;
  else begin
    case(op)
      2'b00: expected = a + b;
      2'b01: expected = a - b;
      2'b10: expected = a * b;
      2'b11: expected = a | b;
      default: expected = 8'h00;
    endcase
  end
  if(result === expected)
    $display("PASS : result=%0h expected=%0h",
              result, expected);

  else
    $display("FAIL : result=%0h expected=%0h",
              result, expected);

endtask
//   always @ (*) begin
//     if(!valid) 
//       assert(result==8'h00)
//     else 
//       $error("result should be 0 when valid is 0");  
//   end
  initial begin
    $display("----------------------");
    $display("ALU TB STARTED");
    $display("-----------------------");
    $display("TEST_1");
    task1(8'h0a,8'h03,2'b01,1'b1);
    scoreboard();
    $display("TEST_2");
    task1(8'h0b,8'h03,2'b01,1'b1);
    scoreboard();
    $display("TEST_3");
    task1(8'h04,8'h03,2'b10,1);
    scoreboard();
    $display("TEST_4");
    task1(8'h0C,8'h03,2'b11,1);
    scoreboard();
    $display("TEST_5");
    task1(8'h05,8'h03,2'b00,1'b1);
   scoreboard();
    $display("TEST_6");
    task1(8'h05,8'h03,2'b00,0);
    scoreboard();
    $display("TEST_7");
    task1(8'h05,8'h03,2'b01,0);
    scoreboard();
    $display("TEST_8");
    task1(8'h05,8'h03,2'b10,0);
    scoreboard();
    $display("TEST_9");
    task1(8'h05,8'h03,2'b11,0);
    scoreboard();
    $display("TEST_10");
    task1(8'h00,8'hFF,2'b00,1);
    scoreboard();
    $display("TEST_11");
    task1(8'hFF,8'h00,2'b01,1);
    scoreboard();
        
    $display("overall coverage=%0.2f%%",cp.get_coverage());
    $display("cp_a coverage=%0.2f%%",cp.cp_a.get_coverage());
    $display("cp_b coverage=%0.2f%%",cp.cp_b.get_coverage());
    $display("cp_op coverage=%0.2f%%",cp.cp_op.get_coverage());
    $display("cp_valid coverage=%0.2f%%",cp.cp_valid.get_coverage());
    $display("cx_op_valid coverage=%0.2f%%",cp.cx_op_valid.get_coverage());
    $display("-----------SIM COMPLETED------------");
    $finish;
  end
endmodule


