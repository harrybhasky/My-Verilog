module Multiplexed_7seg (
    input clk,                  // Clock signal
    input reset,                // Reset signal
    input [15:0] bcd_digits,    // BCD inputs for 4 digits (4 BCDs, 16 bits)
    output reg [3:0] digit_sel, // Enable signals for each digit (active low)
    output [6:0] seg            // 7-segment output (a to g)
);

    reg [1:0] digit_select;      // To select which digit to display
    reg [3:0] bcd;               // Current BCD value to display
    reg [19:0] refresh_counter;  // For timing control
    
    // Instantiate BCD to 7-segment decoder
    BCD_to_7seg bcd_decoder (
        .bcd(bcd),
        .seg(seg)
    );
    
    // Timing control for digit switching (refresh rate control)
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            refresh_counter <= 0;
            digit_select <= 0;
        end else begin
            refresh_counter <= refresh_counter + 1;
            if (refresh_counter == 100000) begin  // Adjust for desired refresh rate
                refresh_counter <= 0;
                digit_select <= digit_select + 1; // Move to the next digit
            end
        end
    end
    
    // Multiplex between digits
    always @(*) begin
        case (digit_select)
            2'b00: begin
                digit_sel = 4'b1110;  // Enable the first digit (active low)
                bcd = bcd_digits[3:0]; // Send first BCD to decoder
            end
            2'b01: begin
                digit_sel = 4'b1101;  // Enable the second digit
                bcd = bcd_digits[7:4]; // Send second BCD to decoder
            end
            2'b10: begin
                digit_sel = 4'b1011;  // Enable the third digit
                bcd = bcd_digits[11:8]; // Send third BCD to decoder
            end
            2'b11: begin
                digit_sel = 4'b0111;  // Enable the fourth digit
                bcd = bcd_digits[15:12]; // Send fourth BCD to decoder
            end
        endcase
    end
endmodule
