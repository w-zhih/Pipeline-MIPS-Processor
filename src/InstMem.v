module InstMem(reset, Address, Instruction);

input reset;
input [31:0] Address;
output [31:0] Instruction;

parameter MEM_SIZE = 512;
reg [31:0] InstData [MEM_SIZE-1:0];

assign Instruction = InstData[Address[9:2]];

integer i;
initial  begin
    InstData[9'd0]=32'h24040029;
    InstData[9'd1]=32'h24050000;
    InstData[9'd2]=32'h24060004;
    InstData[9'd3]=32'h24070400;
    InstData[9'd4]=32'h00864022;
    InstData[9'd5]=32'h24090000;
    InstData[9'd6]=32'h240a0000;
    InstData[9'd7]=32'h24020000;
    InstData[9'd8]=32'h0109582a;
    InstData[9'd9]=32'h1d60001b;
    InstData[9'd10]=32'h0146682a;
    InstData[9'd11]=32'h11a00011;
    InstData[9'd12]=32'h00ea7020;
    InstData[9'd13]=32'h01ca7020;
    InstData[9'd14]=32'h01ca7020;
    InstData[9'd15]=32'h01ca7020;
    InstData[9'd16]=32'h8dce0000;
    InstData[9'd17]=32'h00a97820;
    InstData[9'd18]=32'h01e97820;
    InstData[9'd19]=32'h01e97820;
    InstData[9'd20]=32'h01e97820;
    InstData[9'd21]=32'h01ea7820;
    InstData[9'd22]=32'h01ea7820;
    InstData[9'd23]=32'h01ea7820;
    InstData[9'd24]=32'h01ea7820;
    InstData[9'd25]=32'h8def0000;
    InstData[9'd26]=32'h15cf0002;
    InstData[9'd27]=32'h214a0001;
    InstData[9'd28]=32'h0810000a;
    InstData[9'd29]=32'h11460003;
    InstData[9'd30]=32'h240a0000;
    InstData[9'd31]=32'h21290001;
    InstData[9'd32]=32'h08100008;
    InstData[9'd33]=32'h20420001;
    InstData[9'd34]=32'h240a0000;
    InstData[9'd35]=32'h21290001;
    InstData[9'd36]=32'h08100008;
    //InstData[9'd37]=32'h08100025;
    //
    InstData[9'd37]=32'h240c0000;
    InstData[9'd38]=32'h24040000;
    InstData[9'd39]=32'h3c040001;
    InstData[9'd40]=32'h3c010000;
    InstData[9'd41]=32'h342186a0;
    InstData[9'd42]=32'h00812020;
    InstData[9'd43]=32'h00404820;
    InstData[9'd44]=32'h00094f00;
    InstData[9'd45]=32'h00094f02;
    InstData[9'd46]=32'h00405020;
    InstData[9'd47]=32'h000a5600;
    InstData[9'd48]=32'h000a5702;
    InstData[9'd49]=32'h00407020;
    InstData[9'd50]=32'h000e7500;
    InstData[9'd51]=32'h000e7702;
    InstData[9'd52]=32'h00407820;
    InstData[9'd53]=32'h000f7c00;
    InstData[9'd54]=32'h000f7f02;
    InstData[9'd55]=32'h298b0004;
    InstData[9'd56]=32'h1160ffec;
    InstData[9'd57]=32'h11800063;
    InstData[9'd58]=32'h20010001;
    InstData[9'd59]=32'h01815822;
    InstData[9'd60]=32'h11600063;
    InstData[9'd61]=32'h20010002;
    InstData[9'd62]=32'h01815822;
    InstData[9'd63]=32'h11600063;
    InstData[9'd64]=32'h20010003;
    InstData[9'd65]=32'h01815822;
    InstData[9'd66]=32'h11600063;
    InstData[9'd67]=32'h24190000;
    InstData[9'd68]=32'h000d6a00;
    InstData[9'd69]=32'h13200037;
    InstData[9'd70]=32'h20010001;
    InstData[9'd71]=32'h03215822;
    InstData[9'd72]=32'h11600036;
    InstData[9'd73]=32'h20010002;
    InstData[9'd74]=32'h03215822;
    InstData[9'd75]=32'h11600035;
    InstData[9'd76]=32'h20010003;
    InstData[9'd77]=32'h03215822;
    InstData[9'd78]=32'h11600034;
    InstData[9'd79]=32'h20010004;
    InstData[9'd80]=32'h03215822;
    InstData[9'd81]=32'h11600033;
    InstData[9'd82]=32'h20010005;
    InstData[9'd83]=32'h03215822;
    InstData[9'd84]=32'h11600032;
    InstData[9'd85]=32'h20010006;
    InstData[9'd86]=32'h03215822;
    InstData[9'd87]=32'h11600031;
    InstData[9'd88]=32'h20010007;
    InstData[9'd89]=32'h03215822;
    InstData[9'd90]=32'h11600030;
    InstData[9'd91]=32'h20010008;
    InstData[9'd92]=32'h03215822;
    InstData[9'd93]=32'h1160002f;
    InstData[9'd94]=32'h20010009;
    InstData[9'd95]=32'h03215822;
    InstData[9'd96]=32'h1160002e;
    InstData[9'd97]=32'h2001000a;
    InstData[9'd98]=32'h03215822;
    InstData[9'd99]=32'h1160002d;
    InstData[9'd100]=32'h2001000b;
    InstData[9'd101]=32'h03215822;
    InstData[9'd102]=32'h1160002c;
    InstData[9'd103]=32'h2001000c;
    InstData[9'd104]=32'h03215822;
    InstData[9'd105]=32'h1160002b;
    InstData[9'd106]=32'h2001000d;
    InstData[9'd107]=32'h03215822;
    InstData[9'd108]=32'h1160002a;
    InstData[9'd109]=32'h2001000e;
    InstData[9'd110]=32'h03215822;
    InstData[9'd111]=32'h11600029;
    InstData[9'd112]=32'h2001000f;
    InstData[9'd113]=32'h03215822;
    InstData[9'd114]=32'h11600028;
    InstData[9'd115]=32'h3c014000;
    InstData[9'd116]=32'h00200821;
    InstData[9'd117]=32'hac2d0010;
    InstData[9'd118]=32'h24180000;
    InstData[9'd119]=32'h030e582a;
    InstData[9'd120]=32'h11600002;
    InstData[9'd121]=32'h27180001;
    InstData[9'd122]=32'h08100077;
    InstData[9'd123]=32'h258c0001;
    InstData[9'd124]=32'h08100037;
    InstData[9'd125]=32'h21ad00c0;
    InstData[9'd126]=32'h08100073;
    InstData[9'd127]=32'h21ad00f9;
    InstData[9'd128]=32'h08100073;
    InstData[9'd129]=32'h21ad00a4;
    InstData[9'd130]=32'h08100073;
    InstData[9'd131]=32'h21ad00b0;
    InstData[9'd132]=32'h08100073;
    InstData[9'd133]=32'h21ad0099;
    InstData[9'd134]=32'h08100073;
    InstData[9'd135]=32'h21ad0092;
    InstData[9'd136]=32'h08100073;
    InstData[9'd137]=32'h21ad0082;
    InstData[9'd138]=32'h08100073;
    InstData[9'd139]=32'h21ad00f8;
    InstData[9'd140]=32'h08100073;
    InstData[9'd141]=32'h21ad0080;
    InstData[9'd142]=32'h08100073;
    InstData[9'd143]=32'h21ad0090;
    InstData[9'd144]=32'h08100073;
    InstData[9'd145]=32'h21ad0088;
    InstData[9'd146]=32'h08100073;
    InstData[9'd147]=32'h21ad0083;
    InstData[9'd148]=32'h08100073;
    InstData[9'd149]=32'h21ad00c6;
    InstData[9'd150]=32'h08100073;
    InstData[9'd151]=32'h21ad00a1;
    InstData[9'd152]=32'h08100073;
    InstData[9'd153]=32'h21ad0086;
    InstData[9'd154]=32'h08100073;
    InstData[9'd155]=32'h21ad018e;
    InstData[9'd156]=32'h08100073;
    InstData[9'd157]=32'h0009c820;
    InstData[9'd158]=32'h240d000e;
    InstData[9'd159]=32'h08100044;
    InstData[9'd160]=32'h000ac820;
    InstData[9'd161]=32'h240d000d;
    InstData[9'd162]=32'h08100044;
    InstData[9'd163]=32'h000ec820;
    InstData[9'd164]=32'h240d000b;
    InstData[9'd165]=32'h08100044;
    InstData[9'd166]=32'h000fc820;
    InstData[9'd167]=32'h240d0007;
    InstData[9'd168]=32'h08100044;


    for (i = 9'd169; i < MEM_SIZE; i = i + 1)
		InstData[i] <= 32'h00000000;

end


/*always @(*) begin
  if(reset) begin
    Instruction<=32'b0;
  end
  else begin
    Instruction <= InstData[Address[9:2]];
  end
end*/



endmodule