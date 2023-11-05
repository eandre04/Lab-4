module shifter_tb;
	reg [15:0] in;
	reg [1:0] shift;
	wire [15:0] sout;
	reg err, clk;
	
	shifter tb(in, shift, sout);

	initial begin
		err = 1'b0;

		in = 16'b1111000011001111;
		shift = 2'b00;
		#10;
		if(sout !== 16'b1111000011001111) err = 1'b1;
		
		
		in = 16'b1111000011001111;
		shift = 2'b01;
		#10;
		if(sout !== 16'b1110000110011110) err = 1'b1;


		in = 16'b1111000011001111;
		shift = 2'b10;
		#10;
		if(sout !== 16'b0111100001100111) err = 1'b1;
		

		in = 16'b1111000011001111;
		shift = 2'b11;
		#10;
		if(sout !== 16'b1111100001100111) err = 1'b1;


		in = 16'b1111000011001111;
		shift = 2'b00;
		#10;
		if(sout !== 16'bxxxxxxxxxxxxxxxx) err = 1'b1;
		#10;
	end
endmodule 