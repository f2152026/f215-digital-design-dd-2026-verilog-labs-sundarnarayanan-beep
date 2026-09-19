// and_df.v
// AND gate, dataflow style, with a delay on the continuous assignment.
// The RHS is evaluated using CURRENT input values, then the delay is
// applied before the result is scheduled onto y. This is a delayed
// assignment, not a delayed evaluation.

module and_df (
  input  a,
  input  b,
  output y
);

  assign #5 y = a & b;

endmodule