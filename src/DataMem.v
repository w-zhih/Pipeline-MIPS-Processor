module DataMem(
        clk,
        reset,
        Address,
        Write_data,
        MemWrite,
        MemRead,
        Read_data,
        leds,
        an,
        BCD
    );

    input clk, reset, MemRead, MemWrite;
    input [31:0] Address, Write_data;
    output [31:0] Read_data;
    output reg [7:0] leds;
    output reg [3:0] an;
    output reg [7:0] BCD;

    parameter RAM_SIZE = 512;
    parameter RAM_SIZE_BIT = 9;

    reg [31:0] RAM_data[RAM_SIZE-1:0];

    parameter str = "linux is not unix is not unix is not unix";
    parameter str_len = 41;
    parameter pattern = "unix";
    parameter pattern_len = 4;


    wire[29:0] word_addr;
    assign word_addr = Address[31:2];

    assign Read_data = reset ? 0 : MemRead? 
        (word_addr<RAM_SIZE ? RAM_data[Address[RAM_SIZE_BIT + 1:2]]:
        Address==32'h4000000C ? {24'h0, leds} :
        Address==32'h40000010 ? {20'h0, an, BCD} : 32'h00000000) : 32'h00000000;
	
	integer i;
	always @(posedge reset or posedge clk)
		if (reset) begin
            leds <= 0;
            an <= 0;
            BCD <= 0;

			RAM_data[9'd0]=32'd108; // l
            RAM_data[9'd1]=32'd105; // i
            RAM_data[9'd2]=32'd110; // n
            RAM_data[9'd3]=32'd117; // u
            RAM_data[9'd4]=32'd120; // x
            RAM_data[9'd5]=32'd32;  // Space
            RAM_data[9'd6]=32'd105; // i 
            RAM_data[9'd7]=32'd115; // s
            RAM_data[9'd8]=32'd32;  // Space
            RAM_data[9'd9]=32'd110; // n
            RAM_data[9'd10]=32'd111;// o
            RAM_data[9'd11]=32'd116;// t
            RAM_data[9'd12]=32'd32;  // Space
            RAM_data[9'd13]=32'd117;// u
            RAM_data[9'd14]=32'd110; // n
            RAM_data[9'd15]=32'd105; // i
            RAM_data[9'd16]=32'd120; // x
            RAM_data[9'd17]=32'd32;  // Space
            RAM_data[9'd18]=32'd105; // i 
            RAM_data[9'd19]=32'd115; // s
            RAM_data[9'd20]=32'd32;  // Space
            RAM_data[9'd21]=32'd110; // n
            RAM_data[9'd22]=32'd111;// o
            RAM_data[9'd23]=32'd116;// t
            RAM_data[9'd24]=32'd32;  // Space
            RAM_data[9'd25]=32'd117;// u
            RAM_data[9'd26]=32'd110; // n
            RAM_data[9'd27]=32'd105; // i
            RAM_data[9'd28]=32'd120; // x
            RAM_data[9'd29]=32'd32;  // Space
            RAM_data[9'd30]=32'd105; // i 
            RAM_data[9'd31]=32'd115; // s
            RAM_data[9'd32]=32'd32;  // Space
            RAM_data[9'd33]=32'd110; // n
            RAM_data[9'd34]=32'd111;// o
            RAM_data[9'd35]=32'd116;// t
            RAM_data[9'd36]=32'd32;  // Space
            RAM_data[9'd37]=32'd117;// u
            RAM_data[9'd38]=32'd110; // n
            RAM_data[9'd39]=32'd105; // i
            RAM_data[9'd40]=32'd120; // x

            for(i=9'd41; i<9'd256; i=i+1) begin
                RAM_data[i]<=0;
            end

            RAM_data[9'd256]=32'd117;// u
            RAM_data[9'd257]=32'd110; // n
            RAM_data[9'd258]=32'd105; // i
            RAM_data[9'd259]=32'd120; // x

            for(i=9'd260; i<RAM_SIZE; i=i+1) begin
                RAM_data[i]<=0;
            end
        end
		else begin 
            if (MemWrite) begin
                if(word_addr < RAM_SIZE) begin
                    RAM_data[Address[RAM_SIZE_BIT + 1:2]] <= Write_data;
                end    
                else begin
                    case(Address)
                        32'h4000000C: leds<=Write_data[7:0];
                        32'h40000010: begin
                            BCD<=Write_data[7:0];
                            an<=Write_data[11:8];
                        end
                    endcase    
                end
            end
        end
endmodule