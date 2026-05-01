// `define PART1
`define PART2

module SerialTransmitter (
    input        clk,
    input        send,
    input  [7:0] PDin,
    output       SCout,
    output       SDout
);

reg [9:0] shift_reg;
reg [3:0] count;
reg       busy;

wire parity_bit = ^PDin;

assign SDout = shift_reg[9];
assign SCout = clk;


// ======================================================== //
`ifdef PART1
    reg send_delayed;
    wire send_pulse;

    always @(posedge clk) begin
        send_delayed <= send; 
    end

    assign send_pulse = send & ~send_delayed;
// ======================================================== //
`elsif PART2
    reg send_caught;
    wire send_clr;

    always @(posedge send or posedge send_clr) begin
        if (send_clr)
            send_caught <= 1'b0;
        else
            send_caught <= 1'b1;
    end

    reg send_sync;
    always @(posedge clk) begin
        send_sync <= send_caught;
    end

    assign send_clr = send_sync;
    wire send_pulse = send_sync && !busy;

`endif
// ======================================================== //
    always @(posedge clk) begin
        if (!busy) begin
            if (send_pulse) begin
                shift_reg <= {1'b1, PDin, parity_bit};
                count <= 4'd0;
                busy  <= 1'b1;
            end
            else
                shift_reg <= 10'd0;
        end
        else begin
            shift_reg <= {shift_reg[8:0], 1'b0};
            if (count == 4'd8) begin
                count <= 4'd0;
                busy  <= 1'b0;
            end
            else begin
                count <= count + 4'd1;
            end
        end
    end

endmodule	