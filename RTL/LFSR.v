
////// This module used to generate random Output of width of 8 bits

module LFSR #(parameter Seed_length = 16,
                        output_length = 8)(
	
    input   wire                        CLK,RST,	
	input   wire  [Seed_length-1:0]     Seed,
    input   wire                        enable,	
	output  wire   [output_length-1:0]   Rand_out     
						
	);
	
	        reg   [15:0]                shifters;
	
	always @(posedge CLK or negedge RST)
		begin 
            if(!RST)
			    begin 
				    shifters <= Seed;
					//Rand_out <= shifters[7:0];
				end 
		    else 
                begin 
				    if (enable)
					    begin 
					//	    Rand_out <= shifters[7:0];
						    shifters[0]<= shifters [1];
						    shifters[1]<= shifters [2];
							shifters[2]<= shifters [3];
							shifters[3]<= shifters [4];
							shifters[4]<= shifters [5];
							shifters[5]<= shifters [6];
							shifters[6]<= shifters [7];
							shifters[7]<= shifters [8];
							shifters[8]<= shifters [9];
							shifters[9]<= shifters [10];
							shifters[10]<= shifters [11];
							shifters[11]<= shifters [12];
							shifters[12]<= shifters [13];
							shifters[13]<= shifters [14];
							shifters[14]<= shifters [15];
							shifters[15]<= shifters [14] ^ shifters [13];
						end 
                end 				
        end

    assign Rand_out = shifters[7:0];
		
endmodule
						
						