
module regfile_tb;

	reg [15:0] data_in;
	reg [2:0] writenum, readnum;
	reg write, clk, err;
	wire [15:0] data_out;

	regfile tb(data_in, writenum, write, readnum, clk, data_out);

	initial begin
		clk = 1'b0;
		#4;
		forever begin
		clk = 1'b1;
		#5;
		clk = 1'b0;
		#5;
		end
	end
	
	initial begin

		err = 1'b0;

		write = 1'b1;
		writenum = 3'b000;
		data_in = 16'b0101010101010101;
		#10;
		if(tb.R0 !== 16'b0101010101010101) err = 1'b1;

		writenum = 3'b000;
		data_in = 16'b0000000000000000;
		#10;
		if(tb.R0 !== 16'b0000000000000000) err = 1'b1;

		write = 1'b0;
		writenum = 3'b000;
		data_in = 16'b0101010101010101;
		#10;
		if(tb.R0 !== 16'b0000000000000000) err = 1'b1;

//#30

		write = 1'b1;
		writenum = 3'b001;
		data_in = 16'b1111111111111111;
		#10;
		if(tb.R1 !== 16'b1111111111111111) err = 1'b1;

		writenum = 3'b001;
		data_in = 16'b0000000000000000;
		#10;
		if(tb.R1 !== 16'b0000000000000000) err = 1'b1;

		write = 1'b0;
		writenum = 3'b001;
		data_in = 16'b111111111111111;
		#10;
		if(tb.R1 !== 16'b0000000000000000) err = 1'b1;

		
		readnum = 3'b000;
		#1;
		if(data_out !== 16'b0000000000000000) err = 1'b1;
		
		readnum = 3'b001;
		#1;
		if(data_out !== 16'b0000000000000000) err = 1'b1;
	


		

	end
endmodule
