//saja asfour
//120737
//sec 2

//a
//this module is for state digram
module Figure1(input x,clk,rst,output reg z);
	parameter s0=2'b00 ,s1=2'b01,s2=2'b10,s3=2'b11;	 
	reg [1:0] state;
	always @(posedge clk or negedge rst)
		begin 
			if(rst==0)
				begin 
					state=s0;
					z=0;
				end	
			else
				begin
					case(state)
						s0: if(x) state=s1; else state=s3;
						s1: if(x) state=s2; else state=s0;
						s2: if(~x) state=s1;
						s3: if(x) state=s1; else state=s2;	
					endcase
				end
		if(state ==s0 || state==s2)
			z=0;
		else if(state==s1 || state==s3)
			z=1;
		end
endmodule

//D flip-flop with asynchronous reset
module DFF(input D ,clk,rst,output reg Q);
	always @(posedge clk or negedge rst)
		if(~rst)
			Q=1'b0;
		else
			Q=D;
endmodule

//b
module Figure2(input x,clk,rst,output z);  
	wire A,B;
	wire DA,DB;
	xor(DA,x,~B);
	or(DB,A,x);
	DFF a(DA,clk,rst,A);
	DFF b(DB,clk,rst,B);
	xor(z,A,B);
endmodule

//c
module Figure3(input x,clk,rst,output z);  
	wire A,B;
	wire DA,DB;
	xor(DA,x,~B); 
	xor(DB,A,x);
	DFF a(DA,clk,rst,A);
	DFF b(DB,clk,rst,B);
	xor(z,A,B);
endmodule


//d
module Test1;
  reg x, clk, rst;
  wire  Z1, Z2;

  Figure1 f1(x, clk, rst, Z1);
  Figure2 f2(x, clk, rst,Z2);

  initial begin
	  
    rst = 0; clk = 0;
    #5 rst = 1;
	
	repeat (16)
	#5 clk = ~clk;
	  
  end
  
  initial begin
	  x = 0; 
	  #15 x = 1;
	  
	  repeat (8)
	  #10 x = ~x;
	  
	if (Z1 == Z2)
      $display("PASS");
    else
      $display("FAIL");
	
  end
																		 
endmodule 

//e
module Test2;
  reg x, clk, rst;
  wire  Z1, Z3;

  Figure1 f1(x, clk, rst, Z1);
  Figure3 f3(x, clk, rst,Z3);

  initial begin
	  
    rst = 0; clk = 0;
    #5 rst = 1;
	
	repeat (16)
	#5 clk = ~clk;
	  
  end
  
  initial begin
	  x = 0; 
	  #15 x = 1;
	  
	  repeat (8)
	  #10 x = ~x;
	  
	if (Z1 == Z3)
      $display("PASS");
    else
      $display("FAIL");
	
  end
																		 
endmodule