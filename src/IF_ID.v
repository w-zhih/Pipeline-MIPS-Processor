module IF_ID(reset, clk, flush, stall, IF_Inst, IF_PC_Plus4, ID_Inst, ID_PC_Plus4);

    input reset, clk, flush, stall; // stall: 由load-use hazard引发的阻塞ID (IF的阻塞由PCWrite实现)
    input [31:0] IF_Inst;
    input [31:0] IF_PC_Plus4;
    output reg [31:0] ID_Inst;
    output reg [31:0] ID_PC_Plus4;

    always @(posedge clk or posedge reset)
    begin
        if(reset) begin
            ID_Inst<=0;
            ID_PC_Plus4<=0;
        end
        else begin
            if(flush) begin
                ID_Inst<=0;
                ID_PC_Plus4<=0;
            end
            else if(!stall) begin
                ID_Inst<=IF_Inst;
                ID_PC_Plus4<=IF_PC_Plus4;
            end
        end
        
    end
endmodule