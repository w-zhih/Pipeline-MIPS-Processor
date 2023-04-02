module ID_Forwarding(
        IF_ID_rs,
        IF_ID_rt,
        EX_MEM_Regwrite,
        EX_MEM_rd,
        MEM_WB_RegWrite,
        MEM_WB_rd,
        ID_Forwarding_rs, // 转发到ID阶段的rs
        ID_Forwarding_rt  // 转发到ID阶段的rt
    );

    input [4:0] IF_ID_rs, IF_ID_rt, EX_MEM_rd, MEM_WB_rd;
    input EX_MEM_Regwrite;
    input MEM_WB_RegWrite;
    output [1:0] ID_Forwarding_rs; // 10: MEM_WB => ID rs, 01: EX_MEM => ID rs
    output ID_Forwarding_rt; // MEM_WB => ID rt

    assign ID_Forwarding_rs = 
        (IF_ID_rs!=0 && EX_MEM_Regwrite && EX_MEM_rd==IF_ID_rs)?2'b01:
        (IF_ID_rs!=0 && MEM_WB_RegWrite && MEM_WB_rd==IF_ID_rs)?2'b10:2'b00;

    assign ID_Forwarding_rt = (IF_ID_rt!=0 && MEM_WB_RegWrite && MEM_WB_rd==IF_ID_rt);  


endmodule