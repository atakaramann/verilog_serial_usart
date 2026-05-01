module SerialTop (
    input        Clk,
    input        Send,
    input  [7:0] PDin,
    output       SoClk,
    output       SDout,
    output [7:0] PDout,
    output       PDready,
    output       ParErr
);

wire serial_clk;
wire serial_data;

SerialTransmitter transmitter (
    .clk   (Clk),
    .send  (Send),
    .PDin  (PDin),
    .SCout (serial_clk),
    .SDout (serial_data)
);

SerialReceiver receiver (
    .SCin    (serial_clk),
    .SDin    (serial_data),
    .PDout   (PDout),
    .PDready (PDready),
    .ParErr  (ParErr) 
);

assign SoClk = serial_clk;
assign SDout = serial_data;

endmodule	