module BranchTest(in1, in2, BranchSignal, Branch_Hazard);
    input [31:0] in1, in2;
    input [2:0] BranchSignal;
    output reg Branch_Hazard;

    always @(*) begin
        case(BranchSignal)
            3'b100: // beq
                Branch_Hazard <= (in1==in2);
            3'b101: // bne
                Branch_Hazard <= ~(in1==in2);
            3'b001: // bltz 
                Branch_Hazard <= $signed(in1)<0;
            3'b111: // bgtz
                Branch_Hazard <= (in1[31] == 0 && in1 != 0);
            3'b110: // blez
                Branch_Hazard <= $signed(in1)<0 || (~|in1);
            default: Branch_Hazard <= 0;
        endcase
    end

endmodule