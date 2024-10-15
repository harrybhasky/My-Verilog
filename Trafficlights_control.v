module traffic_light_controller (
    input clk,
    input rst,
    output reg [2:0] ns_light,
    output reg [2:0] ew_light
);

    reg [3:0] state;
    reg [15:0] timer;

    localparam NS_GREEN  = 4'b0001;
    localparam NS_YELLOW = 4'b0010;
    localparam EW_GREEN  = 4'b0100;
    localparam EW_YELLOW = 4'b1000;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            ns_light <= 3'b100;
            ew_light <= 3'b100;
            state <= NS_GREEN;
            timer <= 0;
        end else begin
            timer <= timer + 1;

            case (state)
                NS_GREEN: begin
                    ns_light <= 3'b001;
                    ew_light <= 3'b100;
                    if (timer == 16'd50000) begin
                        timer <= 0;
                        state <= NS_YELLOW;
                    end
                end

                NS_YELLOW: begin
              
