

////// This module used to generate repetative pattern of IN signal N Times

module PRBS #(parameter data_width = 32,
                         Repetitive_width = 8,
						 output_width = 8 )(
		
        input  wire                         CLK,RST,		
		input  wire  [data_width-1:0]       IN,
        input  wire  [Repetitive_width-1:0] N,
		input  wire                         valid,
        output reg 	 [output_width-1:0]	    pattern,
		output reg                        Pattern_check,
		output reg                          enable
	    );
		
	reg       [3:0]                    counter_interal;
	reg       [Repetitive_width-1:0]   counter_external;	
	reg       [data_width-1:0]         shifted_data;
	
	////////////////////////////////////////// Combinational outputs ///////////////////////////////////////
	reg 	 [output_width-1:0]	                 pattern_int;
	reg                                          Pattern_check_int;
	reg                                          enable_int;
	reg      [3:0]                               counter_int;
	reg      [Repetitive_width-1:0]              counter_ext;
	reg      [data_width-1:0]                    shifted_data_int;
	
    always @(posedge CLK or negedge RST)
        begin 
            if(!RST)
			    begin 
				    pattern <= 'b0;
				   Pattern_check <= 'b0;
				    enable <= 'b0;	
					counter_interal <= 'b0;
					shifted_data <= IN ;
					counter_external <= 'b0;
				end 
			else
                begin 
				    pattern <= pattern_int;
				    Pattern_check <= Pattern_check_int;
					enable <= enable_int;
					counter_interal <= counter_int;
					shifted_data <= shifted_data_int;
					counter_external <= counter_ext;
                end 				
        end 		
    
	
	always @(*)
	    begin 
		
		    counter_int = counter_interal;
			counter_ext = counter_external;
			shifted_data_int = shifted_data;
			
		    if (counter_external != N)
		        begin 
		            if (counter_interal != 'd3)
			            begin 
								
						    shifted_data_int = shifted_data_int >> 8;
				            pattern_int = shifted_data [7:0];
	                        Pattern_check_int = 1'b1;
	                        enable_int = 1'b0;
	                        counter_int = counter_int + 1'b1;
						    counter_ext = counter_ext;

			     	    end 
		            else 
			            begin 
				            pattern_int = shifted_data[7:0];
	                        Pattern_check_int = 1'b1;
	                        enable_int = 1'b0;
	                        counter_int = 1'b0;
	                        shifted_data_int = IN;
						 	counter_ext = counter_ext +'b1;
				        end 
		        end 	 
			else
			            begin 
				    pattern_int = shifted_data [7:0];
	                Pattern_check_int = 1'b0;
	                enable_int = 1'b1;
	                counter_int = 1'b0;
	                shifted_data_int = IN;
				    if (valid)
					    counter_ext = 0;
					else 
					    counter_ext = counter_external;
				    end 
						
	    end 

endmodule 		
						 