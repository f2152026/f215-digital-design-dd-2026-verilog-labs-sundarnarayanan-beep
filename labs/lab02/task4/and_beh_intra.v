// and_beh_intra.v
// AND gate, behavioral style, with an INTRA-assignment delay.
// a & b is evaluated IMMEDIATELY when the always block triggers (using the
// input values at that instant), and only the assignment to y is deferred
// by 5 time units. This correctly captures the inputs that caused the
// trigger, even if they change again before the assignment takes effect.

module and_beh_intra (
  input      a,
  input      b,
  output reg y
);

  always @(*) begin
    y = #5 (a & b);
  end

endmodule