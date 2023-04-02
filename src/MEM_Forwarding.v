module MEM_Forwarding(
        EX_MEM_rt,
        EX_MEM_MemWrite,
        MEM_WB_MemRead,
        MEM_WB_rt,
        MEM_Forward
    );

    input [4:0] EX_MEM_rt, MEM_WB_rt;
    input EX_MEM_MemWrite, MEM_WB_MemRead;
    output MEM_Forward;
    
    assign MEM_Forward = (EX_MEM_rt!=0 && EX_MEM_MemWrite && MEM_WB_MemRead && MEM_WB_rt==EX_MEM_rt);

endmodule