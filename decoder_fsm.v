module KeyboardScanner(
  input clk,
  input rst,
  input [3:0] Row, // Input from keypad rows
  output reg [3:0] ColOut, // Active column for scanning
  output reg [3:0] KeyData, // Output for the detected key
  output reg KeyReady // Signal indicating a valid key press
);

  parameter IDLE = 3'b000;
  parameter SCAN_1 = 3'b001;
  parameter SCAN_2 = 3'b010;
  parameter SCAN_3 = 3'b011;
  parameter SCAN_4 = 3'b100;
  parameter DEBOUNCE = 3'b101;
  parameter OUTPUT = 3'b110;

  reg [2:0] State, NextState;
  reg [2:0] DebounceCounter;
  reg [3:0] Key; // Stores detected key code

  always @(posedge clk, negedge rst) begin
    if (rst == 0) begin
      State <= IDLE;
      ColOut <= 4'b1111; // Deactivate all columns
      DebounceCounter <= 0;
      KeyData <= 4'bxxxx;
      KeyReady <= 0;
    end 
    else begin
      State <= NextState;
      case (State)
        IDLE: begin
                ColOut <= 4'b0111; // Activate first column
                NextState <= SCAN_1;
              end
        SCAN_1: begin
                        //R1
                        if (Row == 4'b0111) begin
                            Key <= Row; // Store potential key code
                            NextState <= DEBOUNCE;//1
                        end
                        //R2
                        else if(Row == 4'b1011) begin
                            Key <= Row; // Store potential key code
                            NextState <= DEBOUNCE; 		//4
                        end
                        //R3
                        else if(Row == 4'b1101) begin
                            Key <= Row; // Store potential key code
                            NextState <= DEBOUNCE ;		//7
                        end
                        //R4
                        else if(Row == 4'b1110) begin
                            Key <= Row; // Store potential key code
                            NextState <= DEBOUNCE	;	//0
                        end
                        else begin
                            ColOut <= 4'b1011; // Shift to next column
                            NextState <= SCAN_2;
                        end
               end
        SCAN_2: begin
                  //R1
                        if (Row == 4'b0111) begin
                            Key <= Row; // Store potential key code
                            NextState <= DEBOUNCE;//1
                        end
                        //R2
                        else if(Row == 4'b1011) begin
                            Key <= Row; // Store potential key code
                            NextState <= DEBOUNCE; 		//4
                        end
                        //R3
                        else if(Row == 4'b1101) begin
                            Key <= Row; // Store potential key code
                            NextState <= DEBOUNCE ;		//7
                        end
                        //R4
                        else if(Row == 4'b1110) begin
                            Key <= Row; // Store potential key code
                            NextState <= DEBOUNCE	;	//0
                        end
                        else begin
                            ColOut <= 4'b1101; // Shift to next column
                            NextState <= SCAN_3;
                         end
                end
                
        SCAN_3: begin
                          //R1
                        if (Row == 4'b0111) begin
                            Key <= Row; // Store potential key code
                            NextState <= DEBOUNCE;//1
                        end
                        //R2
                        else if(Row == 4'b1011) begin
                            Key <= Row; // Store potential key code
                            NextState <= DEBOUNCE; 		//4
                        end
                        //R3
                        else if(Row == 4'b1101) begin
                            Key <= Row; // Store potential key code
                            NextState <= DEBOUNCE ;		//7
                        end
                        //R4
                        else if(Row == 4'b1110) begin
                            Key <= Row; // Store potential key code
                            NextState <= DEBOUNCE	;	//0
                        end
                        else begin
                            ColOut <= 4'b1101; // Shift to next column
                            NextState <= SCAN_4;
                          end
                end
                
        SCAN_4: begin
                         //R1
                        if (Row == 4'b0111) begin
                            Key <= Row; // Store potential key code
                            NextState <= DEBOUNCE;//1
                        end
                        //R2
                        else if(Row == 4'b1011) begin
                            Key <= Row; // Store potential key code
                            NextState <= DEBOUNCE; 		//4
                        end
                        //R3
                        else if(Row == 4'b1101) begin
                            Key <= Row; // Store potential key code
                            NextState <= DEBOUNCE ;		//7
                        end
                        //R4
                        else if(Row == 4'b1110) begin
                            Key <= Row; // Store potential key code
                            NextState <= DEBOUNCE	;	//0
                        end
                        else begin
                            ColOut <= 4'b1111; // Deactivate all columns (end of scan)
                            NextState <= IDLE;
                          end
                  end
                  
        DEBOUNCE: begin
                      DebounceCounter <= DebounceCounter + 1;
                      if (DebounceCounter == 3'd7) begin // Debounce complete
                        KeyData <= Key; // Store confirmed key code
                        KeyReady <= 1;
                        NextState <= OUTPUT;
                      end 
                      else begin
                        NextState <= DEBOUNCE;
                      end
                   end
        OUTPUT: begin
                      if (Row == Key) begin // Key released
                        KeyReady <= 0;
                        NextState <= IDLE;
                        DebounceCounter <= 0;
                      end else begin
                        NextState <= OUTPUT;
                      end
                 end
      endcase
    end
  end

endmodule

