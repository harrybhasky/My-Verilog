module testbench();
    reg signed [31:0] dividend;
    reg signed [31:0] divisor;
    reg mode;
    wire signed [31:0] quotient;
    wire signed [31:0] remainder;

    divider uut (
        .dividend(dividend),
        .divisor(divisor),
        .mode(mode),
        .quotient(quotient),
        .remainder(remainder)
    );

    initial begin
        // Test case for unsigned division
        mode = 0;
        dividend = 50;
        divisor = 3;
        #10;
        $display("Unsigned Division: %d / %d = %d, remainder = %d", dividend, divisor, quotient, remainder);

        // Test case for signed division
        mode = 1;
        dividend = -50;
        divisor = 3;
        #10;
        $display("Signed Division: %d / %d = %d, remainder = %d", dividend, divisor, quotient, remainder);

        // Test case for signed division with negative divisor
        mode = 1;
        dividend = 50;
        divisor = -3;
        #10;
        $display("Signed Division: %d / %d = %d, remainder = %d", dividend, divisor, quotient, remainder);

        // Test case for division by zero
        mode = 0;
        dividend = 50;
        divisor = 0;
        #10;
        $display("Division by zero: %d / %d = %d, remainder = %d", dividend, divisor, quotient, remainder);

        $finish;
    end
endmodule
