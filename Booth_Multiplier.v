module booth_multiplier (
    input signed [15:0] multiplicand,
    input signed [15:0] multiplier,
    output reg signed [31:0] product
);
    reg signed [31:0] A;
    reg signed [31:0] Q;
    reg Q_1;
    integer i;

    always @(*) begin
        A = 0;
        Q = {multiplier, 1'b0};
        Q_1 = 0;
        product = 0;

        for (i = 0; i < 16; i = i + 1) begin
            case ({Q[0], Q_1})
                2'b01: A = A + multiplicand;
                2'b10: A = A - multiplicand;
                default: ;
            endcase

            {A, Q} = {A[31], A, Q[31:1]};
            Q_1 = Q[0];
        end

        product = {A[31:16], Q[15:0]};
    end
endmodule
