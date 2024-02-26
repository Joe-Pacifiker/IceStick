module audio (
 
 input ref_clk,
 output SPEAKER_R,
 output SPEAKER_L,
 output clk
 
 );

 parameter G5 			= 	783;
 parameter G6s 			= 	1479;
 parameter F5                   =       700; // Should be 700...
 parameter C5s			=	523;
 parameter clkdividerG5 	= 	25000000/G5;
 parameter clkdividerG6s 	= 	25000000/G6s;
 parameter clkdividerF5	        =	25000000/F5;
 parameter clkdividerC5s	=	25000000/C5s;
 parameter beatDelay 		= 	9000000;

 parameter halfRest 		= 	2*beatDelay;
 parameter eighthRest 		= 	beatDelay;
 parameter quarterNote 		= 	2*beatDelay;
 parameter eighthNote 		= 	beatDelay;

 parameter init 		= 	5'd0;
 //Measure 1
 parameter halfRest1 		= 	5'd1;
 parameter eighthRest1 		= 	5'd2;
 parameter quarterNote1 	= 	5'd3;
 parameter eighthNote1 		= 	5'd4;
 //Measure 2
 parameter eighthNote2		=	5'd5; //E5#_F5
 parameter eighthNote3		=	5'd6; //G5
 parameter eighthNote4		=	5'd7; //C5#
 parameter eighthNote5		=	5'd8; //G5
 parameter eighthNote6		=	5'd9; //G6
 //Measure 3
 parameter fin			= 	5'd10;

 reg [26:0] delayCounter 	= 	0;
 reg [16:0] counter 		= 	0;
 reg [4:0] state 		= 	init;

 always @(posedge clk) 
 begin
  
  case(state)
   init: begin
    state <= halfRest1;
   end
   
   halfRest1: begin
    if(delayCounter < halfRest)
    begin
     delayCounter <= delayCounter + 27'd1;
    end
    else
    begin
     delayCounter <= 27'd0;
     state <= eighthRest1;
    end
   end

   eighthRest1: begin
    if(delayCounter < eighthRest)
    begin
     delayCounter <= delayCounter + 27'd1;
    end
    else
    begin
     delayCounter <= 27'd0;
     state <= quarterNote1;
    end
   end

   quarterNote1: begin //Play quarternote (G5 not G4 since octave higher)
    if(counter==0)                             
    begin
     counter <= clkdividerG5-1;
    end
    else 
    begin
     counter <= counter-1;
    end                      
                                            
    delayCounter <= delayCounter + 27'd1;
    if(counter==0 && delayCounter<quarterNote)
    begin
     speaker <= ~speaker;
    end                                     
                                            
    if(delayCounter > quarterNote)
    begin
     delayCounter <= 27'd0;
     state <= eighthNote1;
    end                                     
   end

   eighthNote1: begin
    if(counter==0)                              
    begin
     counter <= clkdividerG6s-1;
    end
    else 
    begin
     counter <= counter-1;
    end                      
                                            
    delayCounter <= delayCounter + 27'd1;
    if(counter==0 && delayCounter<eighthNote)
    begin
     speaker <= ~speaker;
    end                                     
                                            
    if(delayCounter > eighthNote)
    begin
     delayCounter <= 27'd0;
     state <= eighthNote2;
    end                                          
   end   

   eighthNote2:
   begin
    if(counter==0)                           
    begin
     counter <= clkdividerF5-1;
    end
    else 
    begin
     counter <= counter-1;
    end                      
                                            
    delayCounter <= delayCounter + 27'd1;
    if(counter==0 && delayCounter<eighthNote)
    begin
     speaker <= ~speaker;
    end                                     
                                            
    if(delayCounter > eighthNote)
    begin
     delayCounter <= 27'd0;
     state <= eighthNote3;
    end                                      
   end         

   eighthNote3:   
   begin
    if(counter==0)                                      
    begin                                               
     counter <= clkdividerG5-1;                        
    end                                                 
    else                                                
    begin                                               
     counter <= counter-1;                              
    end                                                 
                                                        
    delayCounter <= delayCounter + 27'd1;               
    if(counter==0 && delayCounter<eighthNote)           
    begin                                               
     speaker <= ~speaker;                               
    end                                                 
                                                        
    if(delayCounter > eighthNote)                       
    begin
     delayCounter <= 27'd0;                                               
     state <= eighthNote4;                                      
    end                                                 
   end         

   eighthNote4:
   begin
    if(counter==0)                           
    begin
     counter <= clkdividerC5s-1;
    end
    else 
    begin
     counter <= counter-1;
    end                      
                                            
    delayCounter <= delayCounter + 27'd1;
    if(counter==0 && delayCounter<eighthNote)
    begin
     speaker <= ~speaker;
    end                                     
                                         

    if(delayCounter > eighthNote)
    begin
     delayCounter <= 27'd0;
     state <= eighthNote5;
    end                                      
   end

   eighthNote5:
   begin
    if(counter==0)                               
    begin
     counter <= clkdividerG5-1;
    end
    else 
    begin
     counter <= counter-1;
    end                      
                                            
    delayCounter <= delayCounter + 27'd1;
    if(counter==0 && delayCounter<eighthNote)
    begin
     speaker <= ~speaker;
    end                                     
                                            
    if(delayCounter > eighthNote)
    begin
     delayCounter <= 27'd0;
     state <= eighthNote6;
    end                                      
   end

   eighthNote6:
   begin
    if(counter==0)                           
    begin
     counter <= clkdividerG6s-1;
    end
    else 
    begin
     counter <= counter-1;
    end                      
                                            
    delayCounter <= delayCounter + 27'd1;
    if(counter==0 && delayCounter<eighthNote)
    begin
     speaker <= ~speaker;
    end                                     
                                            
    if(delayCounter > eighthNote)
    begin
     delayCounter <= 27'd0;
     state <= fin;
    end                                      
   end

   fin: begin
    speaker <= 0;
    state <= fin;
   end

  endcase
  

/*
  if(counter==0)
  begin
   counter <= clkdivider-1; 
  end
  else 
  begin
   counter <= counter-1;
  end                      
*/

 end

/*
 reg speaker = 0;
 always @(posedge clk)
 begin
  delayCounter <= delayCounter + 22'd1;
  if(counter==0 && delayCounter<beatDelay)
  begin
   speaker <= ~speaker;
  end                                     
  else
  begin
   speaker <= speaker;
  end
 end
*/
/*
 SB_PLL40_CORE #(
  .FEEDBACK_PATH("SIMPLE"),
  .PLLOUT_SELECT("GENCLK"),
  .DIVR(4'b0000),
  .DIVF(7'b1000010),
  .DIVQ(3'b011),
  .FILTER_RANGE(3'b001)
 ) pll (
  .REFERENCECLK(ref_clk),
  .PLLOUTCORE(clk),
  .LOCK(),
  .RESETB(1'b1),
  .BYPASS(1'b0)
 );                         
*/

 SB_PLL40_CORE #(
  .FEEDBACK_PATH("SIMPLE"),
  .PLLOUT_SELECT("GENCLK"),
  .DIVR(4'b0001),
  .DIVF(7'b1000010),
  .DIVQ(3'b100),
  .FILTER_RANGE(3'b001)
 ) pll (
  .REFERENCECLK(ref_clk),
  .PLLOUTCORE(clk),
  .LOCK(),
  .RESETB(1'b1),
  .BYPASS(1'b0)
 );                        

 assign SPEAKER_R = speaker;
 assign SPEAKER_L = speaker;

endmodule
