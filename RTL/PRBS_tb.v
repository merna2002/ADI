

//////////// This used to validate the functionality of PRBS 

`timescale 1us/1ns

module PRBS_tb #(parameter data_width = 32,
                         Repetitive_width = 8,
						 output_width = 8 )();
	   
		reg                             CLK_tb;
		reg                             RST_tb;		
		reg     [data_width-1:0]        IN_tb;
        reg     [Repetitive_width-1:0]  N_tb;
        wire 	                        pattern_correct_tb;
		reg                             Valid_tb;
	//	reg                             pattern_check_tb;
	
	
	 ////////////////////  Parameters /////////////////
	   parameter clock_period = 10;
	  
	  
	 
	 /////////////////// initial block ////////////////
	    initial 
	    begin 

		initialaization();
	    rst();
		//	pattern_check_tb = 'd1; 
	    #(clock_period*20);	
		   // pattern_check_tb = 'd0;
		/* #(clock_period*5);	
            input_change('hABCD0402); 	
			pattern_check_tb = 'd1; */
			Valid_tb= 1'b1;
			input_change('hABCD0402);
			#(clock_period*5);
			Valid_tb= 1'b0;
			
	    #(clock_period*20);
		$stop; 
	 
	    end
		
	 
	////////////////////// tasks ////////////////////// 
	    task initialaization;
	        begin 
	            CLK_tb = 'b1;
	            RST_tb = 'b1;		
		        IN_tb  = 'hABCD0102;
                N_tb   = 'd2;
				//pattern_check_tb = 'd0;
		    end 
	    endtask
	     
		task rst;
	        begin 
	            RST_tb = 1'b1 ;
	          	#(clock_period)
		        RST_tb = 1'b0 ;
		        #(clock_period)
		        RST_tb = 1'b1 ;
		    end
	    endtask
	  
	    task input_change;
		    input   [data_width-1:0]        IN;
	            begin 
	                IN_tb = IN;
				//	pattern_check_tb = 1'b1;
		        end
	    endtask 
	   
	 
	 //////////////////// Design instantiation //////////////////
	  PRBS_TOP U0 (
	    .CLK(CLK_tb),
		.RST(RST_tb),		
		.IN(IN_tb),
        .N(N_tb),
        .pattern_correct(pattern_correct_tb),
		.Valid(Valid_tb)
		//.Pattern_check(pattern_check_tb)
	  );
	  
	  
	  ////////////////// clock generator ////////////////
	  always #(clock_period/2) CLK_tb = ~ CLK_tb;
		
 endmodule 

