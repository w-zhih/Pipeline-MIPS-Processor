module EX_Forwarding(
        ID_EX_rs,
        ID_EX_rt,
        EX_MEM_Regwrite,
        EX_MEM_rd,
        MEM_WB_RegWrite,
        MEM_WB_rd,
        EX_Forwarding_rs, // 转发到EX阶段的rs
        EX_Forwarding_rt  // 转发到EX阶段的rt
    );

    input [4:0] ID_EX_rs, ID_EX_rt, EX_MEM_rd, MEM_WB_rd;
    input EX_MEM_Regwrite, MEM_WB_RegWrite;
    // 00: not forwarding
    // 01: EX/MEM => EX
    // 10: MEM/WB => EX
    output [1:0] EX_Forwarding_rs, EX_Forwarding_rt;

    assign EX_Forwarding_rs = 
        (ID_EX_rs!=0 && EX_MEM_Regwrite && EX_MEM_rd==ID_EX_rs)?2'b01:
        (ID_EX_rs!=0 && MEM_WB_RegWrite && MEM_WB_rd==ID_EX_rs)?2'b10:2'b00;

    assign EX_Forwarding_rt = 
        (ID_EX_rt!=0 && EX_MEM_Regwrite && EX_MEM_rd==ID_EX_rt)?2'b01:
        (ID_EX_rt!=0 && MEM_WB_RegWrite && MEM_WB_rd==ID_EX_rt)?2'b10:2'b00;

endmodule