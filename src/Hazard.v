module Hazard(
    reset,
    Jump_Hazard, // JumpSignal
    Branch_Hazard,
    ID_EX_MemRead, 
    ID_EX_Rt,
    IF_ID_Rs,
    IF_ID_Rt,
    PCWrite,
    stall,
    IF_Flush,
    ID_Flush
    );

    input reset, Jump_Hazard, Branch_Hazard;
    input ID_EX_MemRead; // ID/EX阶段的指令要读取memory
    input [4:0] ID_EX_Rt; // ID阶段指令要写入的寄存address
    input [4:0] IF_ID_Rs, IF_ID_Rt; // IF阶段指令要读取的寄存address
    output IF_Flush, ID_Flush;
    output PCWrite;
    output stall; // 由load-use hazard引发的阻塞ID

    // Load Use Hazard
    wire Load_Use_Hazard;
    assign Load_Use_Hazard = (ID_EX_MemRead && (ID_EX_Rt==IF_ID_Rs || ID_EX_Rt==IF_ID_Rt));

    assign stall = Load_Use_Hazard;
    assign PCWrite = reset ? 0 : ~Load_Use_Hazard;

    assign IF_Flush = reset ? 0 : (Jump_Hazard || Branch_Hazard);
    assign ID_Flush = reset ? 0 : Branch_Hazard || Load_Use_Hazard;


endmodule