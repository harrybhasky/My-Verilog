module ALU(
    input [3:0] A;
    input [3:0] B;
    input [3:0] sel;
    output reg [7:0] out;
    output reg carry_out;
);

always (*) begin
    CarryOut = 1'b0;         // Default carry flag
    case (ALU_Sel)
        4'b0000: out = A + B;            // Addition
        4'b0001: {CarryOut, out} = A - B; // Subtraction with CarryOut
        4'b0010: out = A & B;            // AND operation
        4'b0011: out = A | B;            // OR operation
        4'b0100: out = A ^ B;            // XOR operation
        4'b0101: out = ~A;               // NOT operation (only on A)
        4'b0110: out = A << 1;           // Logical left shift
        4'b0111: out = A >> 1;           // Logical right shift
        4'b1000: out = A * B;            // Multiplication
        4'b1001: out = A / B;            // Division (integer)
        4'b1010: out = A % B;            // Modulus
        4'b1011: out = (A < B) ? 1 : 0;  // Comparison (less than)
        4'b1100: out = (A == B) ? 1 : 0; // Equality check
        default: out = 8'b00000000;      // Default case (undefined operation)
    endcase
end

endmodule