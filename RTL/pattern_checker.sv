
/// this module is used to check the sequence of repeated pattern 

module pattern_checker #(parameter Repetitive_width = 8,
                                   output_width =8 )(

    input  wire                              RST,CLK,
	input  wire [output_width-1:0]           pattern,
	input  wire [Repetitive_width-1:0]       N,
	input  wire                              Pattern_check,
	output reg                               pattern_correct

);
    localparam  correct_pattern = 32'hABCD0102;
    typedef enum {
      B1,
	  B2,
	  B3,
	  B4
        } state_;

    state_ current_state , next_state ;
	reg  [Repetitive_width-1:0] counter ,counter_int;
	
	always @(posedge CLK or negedge RST)
        begin 
            if(!RST)
			    begin 
				    current_state <= B1;
					counter <= 'b0;
				end 
			else
                begin 
				    current_state <= next_state;
					counter <= counter_int;
                end 				
        end
		
	always @(*)
        begin 
            case(current_state)
			    B1:
				begin 
				    if ( pattern == correct_pattern[7:0])
					    begin 
						    next_state = B2;
						end 
					else
                        begin 
                            next_state = B1;
                        end						
				end 
			  
			    B2:
				begin 
				    if ( pattern == correct_pattern[15:8])
					    begin 
						    next_state = B3;
						end 
					else
                        begin 
                            next_state = B1;
                        end						
				end 
				
				
				B3:
				begin 
				    if ( pattern == correct_pattern[23:16])
					    begin 
						    next_state = B4;
						end 
					else
                        begin 
                            next_state = B1;
                        end						
				end 
				
				
				
				B4:
				begin 
                
						    if (Pattern_check)
						        next_state = B1;
							else 
                                next_state = B4;							
					 					
				end 
			
			endcase
        end 	
		
		
    always @(*)
        begin 
         counter_int =0;
            case(current_state)
			    B1:
				begin 
				    counter_int = counter;
			        pattern_correct =0;						
				end 
			  
			    B2:
				begin 
				    counter_int = counter;
			        pattern_correct =0;						
				end 
				
				
				B3:
				begin 
				   	counter_int = counter;
			        pattern_correct =0;			
				end 
				
				
				
				B4:
				begin 
                    if ( pattern == correct_pattern[31:24])
					    begin 
						    if (counter == N-1)
							    begin 
									pattern_correct =1;
									    if (Pattern_check)
										    counter_int = 0;
										else 
              								counter_int = counter;		
								end 	
							else 
							    begin
							    counter_int = counter_int +1;
								pattern_correct =0;
							    end 
						end 
					else
                        begin 
                            counter_int = counter;
                            pattern_correct =0;
                        end					
				end 
			
			endcase
        end 		
endmodule 