// tb.v
// Self-checking testbench for alu: checks add/sub correctness, and
// specifically re-uses the same a/b while toggling op to catch stale
// sensitivity-list behavior.

module tb;

  reg  [3:0] t_a, t_b;
  reg        t_op;
  wire [3:0] t_result;

  integer errors;
  reg [3:0] expected;

  alu U0 (
    .a      (t_a),
    .b      (t_b),
    .op     (t_op),
    .result (t_result)
  );

  task check;
    begin
      #1; // let combinational logic settle
      if (t_op == 0)
        expected = t_a + t_b;
      else
        expected = t_a - t_b;

      if (t_result !== expected) begin
        $display("MISMATCH at time %0t: a=%d b=%d op=%b -> result=%d (expected %d)",
                  $time, t_a, t_b, t_op, t_result, expected);
        errors = errors + 1;
      end
    end
  endtask

  initial begin
    errors = 0;

    // Basic add/sub check
    t_a = 4'd5; t_b = 4'd3; t_op = 0; check;
    t_a = 4'd5; t_b = 4'd3; t_op = 1; check;

    // Hold a/b fixed, toggle op only -- exposes sensitivity-list bug
    t_a = 4'd9; t_b = 4'd2;
    t_op = 0; check;
    t_op = 1; check;
    t_op = 0; check;

    // Sweep several combinations
    t_a = 4'd10; t_b = 4'd10; t_op = 1; check;
    t_a = 4'd1;  t_b = 4'd15; t_op = 1; check;
    t_a = 4'd7;  t_b = 4'd7;  t_op = 0; check;

    if (errors == 0)
      $display("PASS: all checks matched.");
    else
      $display("FAIL: %0d mismatches.", errors);

    $finish;
  end

endmodule