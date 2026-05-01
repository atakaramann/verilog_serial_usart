module SerialReceiver (
    input        SCin,
    input        SDin,
    output reg [7:0] PDout,
    output reg       PDready,
    output reg       ParErr
);

reg [3:0] bit_count;
reg       busy;

always @(posedge SCin) begin
    PDready <= 1'b0;

    if (!busy) begin
        if (SDin == 1'b1) begin
            busy      <= 1'b1;
            bit_count <= 4'd0;
            ParErr    <= 1'b0;
        end
    end
    
    else begin
		if (bit_count < 4'd8) begin
			PDout <= {PDout[6:0], SDin};
			bit_count <= bit_count + 4'd1;
		end
    
		else if (bit_count == 4'd8) begin
			if (SDin != ^PDout) begin
				ParErr <= 1'b1;
			end
			else begin
				ParErr <= 1'b0;
			end
		busy <= 1'b0;
		bit_count <= 4'd0;
		PDready   <= 1'b1;
		end
	end
end

endmodule	