

//////////// This used to validate the functionality of PRBS 


module PRBS_TOP #(parameter data_width = 32,
                         Repetitive_width = 8,
						 output_width = 8 )(
	
        input  wire                            CLK,RST,		
		input  wire  [data_width-1:0]          IN,
        input  wire  [Repetitive_width-1:0]    N,	
	    input  wire                            Valid,
		output wire 	                       pattern_correct
						 
	);
	   
	            wire                          enable;
				wire [output_width-1:0]       pattern;
                wire [output_width-1:0]       Rand_out;
				wire                          Pattern_check;
				wire 	 [output_width-1:0]    OUT;
				
        PRBS U0 (
         .CLK(CLK),
		 .RST(RST),		
		 .IN(IN),
         .N(N),
         .pattern(pattern),
		 .Pattern_check(Pattern_check),
		 .enable(enable),
		 .valid(Valid)
	    );
		
		LFSR U1 (
         .CLK(CLK),
		 .RST(RST),	
	     .Seed(IN[31:16]),
         .enable(enable),	
         .Rand_out(Rand_out)     		
	    );
		
		
		MUX U2 (
    
	     .CLK(CLK),
		 .RST(RST),
         .IN1(pattern),
	     .IN0(Rand_out),
	     .sel(Pattern_check),
	     .OUT(OUT)
	
        );
	
	    pattern_checker U3 (

         .CLK(CLK),
		 .RST(RST),
	     .pattern(OUT),
	     .N(N),
	     .pattern_correct(pattern_correct),
		 .Pattern_check(Pattern_check)

);
	    
		
endmodule 