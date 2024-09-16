module Debounce_4_Bit #(parameter DEBOUNCE_LIMIT = 250000)
  (input  i_Clk,
   input  [3:0] i_Switch,
   output [3:0] o_Switch
  );
    
  integer i;
  reg [$clog2(DEBOUNCE_LIMIT)-1:0] r_Count [3:0]; // Array of counters for each bit
  reg [3:0] r_State; // Debounced state register

  always @(posedge i_Clk) begin
    for (i = 0; i < 4; i = i + 1) begin
      // Change detection for each bit
      if (i_Switch[i] != r_State[i] && r_Count[i] < DEBOUNCE_LIMIT) begin
        r_Count[i] <= r_Count[i] + 1;
      end 
      else if (r_Count[i] == DEBOUNCE_LIMIT) begin
        // Stable state reached, update debounced output
        r_State[i] <= i_Switch[i];
        r_Count[i] <= 0;
      end 
      else begin
        // No change or waiting for stable state, reset counter
        r_Count[i] <= 0;
      end
    end
  end

  // Assign debounced state to output
  assign o_Switch = r_State;

endmodule

