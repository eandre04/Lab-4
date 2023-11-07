module datapath_tb;
	
	reg [15:0] datapath_in;
	reg [2:0] writenum, readnum;
	reg [1:0] ALUop, shift;
	reg vsel, clk, write, loada, loadb, asel, bsel, loadc, loads, err;
	wire [15:0] datapath_out;
	wire Z_out;

	datapath DUT(clk, readnum, vsel, loada, loadb, shift, asel, bsel, ALUop, loadc, loads, writenum, write, datapath_in, Z_out, datapath_out);


	initial 
		begin
		clk = 1'b0;
		#4;
		forever	
			begin
				clk = 1'b1;
				#5;
				clk = 1'b0;
				#5;
			end
		end

	initial
		begin
		err = 1'b0;
		
//load value into R1
		datapath_in = 16'b0101010101010101;
		write = 1'b1;
		vsel = 1'b1;
		writenum = 3'b001;
		#10;
		if(DUT.REGFILE.R1 !== 16'b0101010101010101) err = 1'b1;


//load value into R3 and read R1 to A
		datapath_in = 16'b1010101010101010;
		write = 1'b1;
		vsel = 1'b1;
		writenum = 3'b011;

		readnum = 3'b001;
		loada = 1'b1;
		#10;
		if(DUT.REGFILE.R3 !== 16'b1010101010101010) err = 1'b1;
		if(DUT.Qa !== 16'b0101010101010101) err = 1'b1;


//Read R3 to B
		loada = 1'b0;
		write = 1'b0;
		readnum = 3'b011;
		loadb = 1'b1;
		#10;
		if(DUT.in !== 16'b1010101010101010) err = 1'b1;
		if(DUT.Qa !== 16'b0101010101010101) err = 1'b1;


//Add A and B put in datapath_out
		loadb = 1'b0;
		ALUop = 2'b00;
		shift = 2'b00;
		asel = 1'b0;
		bsel = 1'b0;
		loadc = 1'b1;
		loads = 1'b1;
		#10;
		if(datapath_out !== 16'b1111111111111111) err = 1'b1;
		if(Z_out !== 1'b0) err = 1'b1;
		if(DUT.in !== 16'b1010101010101010) err = 1'b1;
//#40s

//Subtract A and (B shifted right 1) put in datapath_out
		ALUop = 2'b01;
		shift = 2'b10;
		asel = 1'b0;
		bsel = 1'b0;
		loadc = 1'b1;
		loads = 1'b1;
		#10;
		if(datapath_out !== 16'b0000000000000000) err = 1'b1;
		if(Z_out !== 1'b1) err = 1'b1;


//Anded A and B put in datapath_out
		ALUop = 2'b10;
		shift = 2'b00;
		asel = 1'b0;
		bsel = 1'b0;
		loadc = 1'b1;
		#10;
		if(datapath_out !== 16'b0000000000000000) err = 1'b1;


//NOT B put in datapath_out
		ALUop = 2'b11;
		shift = 2'b00;
		asel = 1'b0;
		bsel = 1'b0;
		loadc = 1'b1;
		loads = 1'b1;
		#10;
		if(datapath_out !== 16'b0101010101010101) err = 1'b1;
		if(Z_out !== 1'b0) err = 1'b1;


//Write to R5 (from data_path_out
		write = 1'b1;
		vsel = 1'b0;
		writenum = 3'b101;
		readnum = 3'b101;
		#10;
		if(DUT.REGFILE.R5 !== 16'b0101010101010101) err = 1'b1;
		if(DUT.data_out !== 16'b0101010101010101) err = 1'b1;

//#80s

//setting multiplexers for b and a to alternates
		asel = 1'b1;
		bsel = 1'b1;
		#10;
		if(DUT.Ain !== 16'b0000000000000000) err = 1'b1;
		if(DUT.Bin !== 16'b0000000000001010) err = 1'b1;

		$stop;
		end
endmodule

		