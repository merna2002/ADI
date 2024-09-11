

module MUX #(parameter output_width = 8)(
    
	input   wire                       CLK,RST,
    input   wire  [output_width-1:0]   IN1,
	input   wire  [output_width-1:0]   IN0,
	input   wire                       sel,
	output  reg   [output_width-1:0]   OUT
	
    );
    
    always @(posedge CLK or negedge RST)
	    begin 
		    if (!RST)
		        begin 
				    OUT <= 'b0;
				end 
			else
                begin 
                    if (sel)
					    begin 
						    OUT <= IN1;
						end 
					else 
                        begin 
                            OUT <= IN0;
                        end 						
                end 				
		end 



endmodule 