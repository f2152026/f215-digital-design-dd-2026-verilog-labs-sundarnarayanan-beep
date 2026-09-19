// and_beh_before.v
// AND gate, behavioral style, with the delay BEFORE the assignment.
// The always block wakes on any input change, then waits 5 time units,
// THEN samples a and b and assigns. If a or b changes again during that
// wait, the values sampled at the end are whatever they happen to be at
// that later time -- stale/wrong relative to what triggered this pass.

module and_beh_before (
  input      a,
  input      b,
  output reg y
);

  always @(*) begin
    #5;
    y = a & b;
  end

endmodule