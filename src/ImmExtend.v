module ImmExtend(Imm, ExtOp, LuiOp, ImmOut);
    input [15:0] Imm;
    input ExtOp, LuiOp;
    output [31:0] ImmOut;

    assign ImmOut = LuiOp ? {Imm,16'h0}:
                    ExtOp ? {{16{Imm[15]}},Imm}:{16'h0,Imm};

endmodule