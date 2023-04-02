module ID_EX(
    input clk,
    input reset,
    input Flush,

    input [31:0] ID_PC_Plus4,
    input [31:0] ID_ReadData1,
    input [31:0] ID_ReadData2,
    input [31:0] ID_Imm_Ext,
    input [4:0] ID_Rs,
    input [4:0] ID_Rt,
    input [4:0] ID_Rd,
    input [4:0] ID_Shamt,

    input ID_ALUSrc1,
    input ID_ALUSrc2,
    input [3:0] ID_ALUOp,
    input [1:0] ID_RegDst,
    input ID_MemWrite,
    input ID_MemRead,
    input [1:0] ID_MemtoReg,
    input ID_RegWrite,
    input [2:0] ID_Branch, // 分支指令
    output reg [31:0] ID_EX_PC_Plus4,
    output reg [31:0] ID_EX_ReadData1,
    output reg [31:0] ID_EX_ReadData2,
    output reg [31:0] ID_EX_Imm_Ext,
    output reg [4:0] ID_EX_rs,
    output reg [4:0] ID_EX_rt,
    output reg [4:0] ID_EX_rd,
    output reg [4:0] ID_EX_shamt,
    output reg ID_EX_ALUSrc1,
    output reg ID_EX_ALUSrc2,
    output reg ID_EX_MemWrite,
    output reg ID_EX_MemRead,
    output reg ID_EX_RegWrite,
    output reg [3:0] ID_EX_ALUOp,
    output reg [1:0] ID_EX_RegDst,
    output reg [1:0] ID_EX_MemtoReg,
    output reg [2:0] ID_EX_BranchSignal
    );



    always @(posedge clk or posedge reset) begin
        if(reset) begin
            ID_EX_PC_Plus4<=0;
            ID_EX_ReadData1<=0;
            ID_EX_ReadData2<=0;
            ID_EX_Imm_Ext<=0;
            ID_EX_rs<=0;
            ID_EX_rt<=0;
            ID_EX_rd<=0;
            ID_EX_shamt<=0;
            ID_EX_ALUSrc1<=0;
            ID_EX_ALUSrc2<=0;
            ID_EX_MemWrite<=0;
            ID_EX_MemRead<=0;
            ID_EX_RegWrite<=0;
            ID_EX_ALUOp<=0;
            ID_EX_RegDst<=0;
            ID_EX_MemtoReg<=0;
            ID_EX_BranchSignal<=0;
        end
        else begin
            if(Flush) begin
                ID_EX_PC_Plus4<=0;
                ID_EX_ReadData1<=0;
                ID_EX_ReadData2<=0;
                ID_EX_Imm_Ext<=0;
                ID_EX_rs<=0;
                ID_EX_rt<=0;
                ID_EX_rd<=0;
                ID_EX_shamt<=0;
                ID_EX_ALUSrc1<=0;
                ID_EX_ALUSrc2<=0;
                ID_EX_MemWrite<=0;
                ID_EX_MemRead<=0;
                ID_EX_RegWrite<=0;
                ID_EX_ALUOp<=0;
                ID_EX_RegDst<=0;
                ID_EX_MemtoReg<=0;
                ID_EX_BranchSignal<=0;
            end
            else begin
                ID_EX_PC_Plus4<=ID_PC_Plus4;
                ID_EX_ReadData1<=ID_ReadData1;
                ID_EX_ReadData2<=ID_ReadData2;
                ID_EX_Imm_Ext<=ID_Imm_Ext;
                ID_EX_rs<=ID_Rs;
                ID_EX_rt<=ID_Rt;
                ID_EX_rd<=ID_Rd;
                ID_EX_shamt<=ID_Shamt;
                ID_EX_ALUSrc1<=ID_ALUSrc1;
                ID_EX_ALUSrc2<=ID_ALUSrc2;
                ID_EX_MemWrite<=ID_MemWrite;
                ID_EX_MemRead<=ID_MemRead;
                ID_EX_RegWrite<=ID_RegWrite;
                ID_EX_ALUOp<=ID_ALUOp;
                ID_EX_RegDst<=ID_RegDst;
                ID_EX_MemtoReg<=ID_MemtoReg;
                ID_EX_BranchSignal<=ID_Branch;
            end
        end
    end



endmodule