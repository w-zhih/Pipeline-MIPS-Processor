`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Zhiheng Wang
// 
// Create Date: 2022/07/17 11:09:39
// Design Name: 
// Module Name: CPU
// Project Name: PipelineCPU
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module CPU(reset, clk, leds, an, BCD);
    input reset;
    input clk;
    output [7:0] leds;
    output [3:0] an;
    output [7:0] BCD;

    wire PCWrite, IF_Flush, ID_Flush, ID_Stall;
    // ID_EX vars
    wire [31:0] ID_EX_PC_Plus4, ID_EX_ReadData1, ID_EX_ReadData2, ID_EX_Imm_Ext;
    wire [4:0] ID_EX_rs, ID_EX_rt, ID_EX_rd, ID_EX_shamt;
    wire ID_EX_ALUSrc1, ID_EX_ALUSrc2, ID_EX_MemWrite, ID_EX_MemRead, ID_EX_RegWrite;
    wire [3:0] ID_EX_ALUOp;
    wire [1:0] ID_EX_RegDst, ID_EX_MemtoReg;
    wire [2:0] ID_EX_BranchSignal;

    // EX_MEM vars
    wire [31: 0] EX_MEM_PC_Plus4, EX_MEM_ALUOut, EX_MEM_rt_data;
    wire [4: 0] EX_MEM_rd;
    wire [1: 0] EX_MEM_MemtoReg;
    wire EX_MEM_MemWrite, EX_MEM_MemRead, EX_MEM_RegWrite;

    // MEM_WB vars
    wire [31:0] MEM_WB_write_data; // write to register file
    wire [4:0] MEM_WB_Rd;
    wire MEM_WB_RegWrite, MEM_WB_MemRead;
       
    /* IF Stage */
    wire Branch_Hazard, Jump_Hazard;
    wire [31:0] branch_target, jump_target, jr_target;

    // PC
    wire [31:0] PC, PC_Plus4, PC_next;
    wire [1:0] PCSrc; 
    assign PC_Plus4=PC+4;
    assign PC_next=(Branch_Hazard) ? branch_target :
            (PCSrc==2'b00) ? PC_Plus4 :
            (PCSrc==2'b01) ? jump_target :
            (PCSrc==2'b10) ? jr_target : 32'b0;

    PC MyPC(
        .clk(clk),
        .reset(reset),
        .PCWrite(PCWrite),
        .PC_i(PC_next),
        .PC_o(PC)
    );

    // InstMem
    wire [31:0] instruction, ID_Inst, ID_PC_Plus4;
    InstMem MyInstMem(.reset(reset), .Address(PC), .Instruction(instruction));

    // IF/ID Reg
    IF_ID IF_ID_Reg(
        .reset(reset),
        .clk(clk),
        .flush(IF_Flush),
        .stall(ID_Stall),
        .IF_Inst(instruction),
        .IF_PC_Plus4(PC_Plus4),
        .ID_Inst(ID_Inst),
        .ID_PC_Plus4(ID_PC_Plus4)
    );

    /* ID Stage */

    // Control Unit
    wire RegWrite;
    wire [1:0] RegDst;
    wire MemRead;
    wire MemWrite;
    wire [1:0] MemtoReg;
    wire ALUSrc1, ALUSrc2;
    wire ExtOp, LuiOp;
    wire JumpSignal;
    wire [2:0] BranchSignal;
    wire [3:0] ALUOp;

    Control ControlUnit(
        .OpCode(ID_Inst[31:26]),
        .Funct(ID_Inst[5:0]),
        .PCSrc(PCSrc),
        .RegWrite(RegWrite),
        .RegDst(RegDst),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .MemtoReg(MemtoReg),
        .ALUSrc1(ALUSrc1),
        .ALUSrc2(ALUSrc2),
        .ExtOp(ExtOp),
        .LuiOp(LuiOp),
        .JumpSignal(JumpSignal),
        .BranchSignal(BranchSignal),
        .ALUOp(ALUOp)
    );

    assign Jump_Hazard = JumpSignal;

    // ImmExtend
    wire [31:0] ImmOut;
    ImmExtend ImmExtendUnit(
        .Imm(ID_Inst[15:0]),
        .ExtOp(ExtOp),
        .LuiOp(LuiOp),
        .ImmOut(ImmOut)
    );

    // RegisterFile
    wire [31:0] ReadData1, ReadData2; // Read from RegisterFile
    RegisterFile Regs(
        .reset(reset),
        .clk(clk),
        .RegWrite(MEM_WB_RegWrite),
        .Read_register1(ID_Inst[25:21]),
        .Read_register2(ID_Inst[20:16]),
        .Write_register(MEM_WB_Rd),
        .Write_data(MEM_WB_write_data),
        .Read_data1(ReadData1),
        .Read_data2(ReadData2)
    );

    // jump target
    assign jump_target = {ID_PC_Plus4[31:28],ID_Inst[25:0],2'b00};

    // HazardUnit
    Hazard HazardUnit(
        .reset(reset),
        .Jump_Hazard(Jump_Hazard),
        .Branch_Hazard(Branch_Hazard),
        .ID_EX_MemRead(ID_EX_MemRead),
        .ID_EX_Rt(ID_EX_rt),
        .IF_ID_Rs(ID_Inst[25:21]),
        .IF_ID_Rt(ID_Inst[20:16]),
        .PCWrite(PCWrite),
        .stall(ID_Stall),
        .IF_Flush(IF_Flush),
        .ID_Flush(ID_Flush)
    );

    // ID Forwarding
    wire [1:0] ID_Forwarding_rs;
    wire ID_Forwarding_rt;
    ID_Forwarding ID_Forwarding_Ctrl(
        .IF_ID_rs(ID_Inst[25:21]),
        .IF_ID_rt(ID_Inst[20:16]),
        .EX_MEM_Regwrite(EX_MEM_RegWrite),
        .EX_MEM_rd(EX_MEM_rd),
        .MEM_WB_RegWrite(MEM_WB_RegWrite),
        .MEM_WB_rd(MEM_WB_Rd),
        .ID_Forwarding_rs(ID_Forwarding_rs),
        .ID_Forwarding_rt(ID_Forwarding_rt)
    );

    wire [31:0] rs_data_forward_id, rt_data_forward_id;
    assign rs_data_forward_id = (ID_Forwarding_rs==2'b10) ? MEM_WB_write_data :
            (ID_Forwarding_rs==2'b01) ? EX_MEM_ALUOut : ReadData1;
    assign rt_data_forward_id = (ID_Forwarding_rt) ? MEM_WB_write_data : ReadData2;

    assign jr_target = rs_data_forward_id;

    // ID/EX Reg
    ID_EX ID_EX_Reg(
        .clk(clk),
        .reset(reset),
        .Flush(ID_Flush),
        .ID_PC_Plus4(ID_PC_Plus4),
        .ID_ReadData1(rs_data_forward_id),
        .ID_ReadData2(rt_data_forward_id),
        .ID_Imm_Ext(ImmOut),
        .ID_Rs(ID_Inst[25:21]),
        .ID_Rt(ID_Inst[20:16]),
        .ID_Rd(ID_Inst[15:11]),
        .ID_Shamt(ID_Inst[10:6]),
        .ID_ALUSrc1(ALUSrc1),
        .ID_ALUSrc2(ALUSrc2),
        .ID_ALUOp(ALUOp),
        .ID_RegDst(RegDst),
        .ID_MemWrite(MemWrite),
        .ID_MemRead(MemRead),
        .ID_MemtoReg(MemtoReg),
        .ID_RegWrite(RegWrite),
        .ID_Branch(BranchSignal),
        .ID_EX_PC_Plus4(ID_EX_PC_Plus4),
        .ID_EX_ReadData1(ID_EX_ReadData1),
        .ID_EX_ReadData2(ID_EX_ReadData2),
        .ID_EX_Imm_Ext(ID_EX_Imm_Ext),
        .ID_EX_rs(ID_EX_rs),
        .ID_EX_rt(ID_EX_rt),
        .ID_EX_rd(ID_EX_rd),
        .ID_EX_shamt(ID_EX_shamt),
        .ID_EX_ALUSrc1(ID_EX_ALUSrc1),
        .ID_EX_ALUSrc2(ID_EX_ALUSrc2),
        .ID_EX_MemWrite(ID_EX_MemWrite),
        .ID_EX_MemRead(ID_EX_MemRead),
        .ID_EX_RegWrite(ID_EX_RegWrite),
        .ID_EX_ALUOp(ID_EX_ALUOp),
        .ID_EX_RegDst(ID_EX_RegDst),
        .ID_EX_MemtoReg(ID_EX_MemtoReg),
        .ID_EX_BranchSignal(ID_EX_BranchSignal)
    );

    /* EX Stage */

    // EX Forward
    wire [1:0] EX_Forwarding_rs, EX_Forwarding_rt;
    EX_Forwarding EX_Forward_Ctrl(
        .ID_EX_rs(ID_EX_rs),
        .ID_EX_rt(ID_EX_rt),
        .EX_MEM_Regwrite(EX_MEM_RegWrite),
        .EX_MEM_rd(EX_MEM_rd),
        .MEM_WB_RegWrite(MEM_WB_RegWrite),
        .MEM_WB_rd(MEM_WB_Rd),
        .EX_Forwarding_rs(EX_Forwarding_rs),
        .EX_Forwarding_rt(EX_Forwarding_rt)
    );

    wire [31:0] rs_data_forward_ex, rt_data_forward_ex;
    assign rs_data_forward_ex = (EX_Forwarding_rs==2'b10) ? MEM_WB_write_data :
                (EX_Forwarding_rs==2'b01) ? EX_MEM_ALUOut : ID_EX_ReadData1;

    assign rt_data_forward_ex = (EX_Forwarding_rt==2'b10) ? MEM_WB_write_data :
                (EX_Forwarding_rt==2'b01) ? EX_MEM_ALUOut : ID_EX_ReadData2;

    wire [31:0] ALU_op1, ALU_op2;
    assign ALU_op1 = (ID_EX_ALUSrc1)?{27'b0,ID_EX_shamt}:rs_data_forward_ex;
    assign ALU_op2 = (ID_EX_ALUSrc2)?ID_EX_Imm_Ext:rt_data_forward_ex;

    // ALU
    wire [31:0] ALUOut;
    wire zero;
    ALU alu(
        .in1(ALU_op1),
        .in2(ALU_op2),
        .ALUOp(ID_EX_ALUOp),
        .out(ALUOut),
        .zero(zero)
    );

    // Branch Test
    assign branch_target = ID_EX_PC_Plus4 + {ID_EX_Imm_Ext[29:0],2'b00};

    BranchTest MyBranchTest(
        .in1(rs_data_forward_ex),
        .in2(rt_data_forward_ex),
        .BranchSignal(ID_EX_BranchSignal),
        .Branch_Hazard(Branch_Hazard)
    );

    // RegDst
    wire [4:0] Write_Addr;
    assign Write_Addr = (ID_EX_RegDst==2'b00)?5'd31:
            (ID_EX_RegDst==2'b01)?ID_EX_rd:ID_EX_rt;

    // EX/MEM
    EX_MEM EX_MEM_Reg(
        .clk(clk),
        .reset(reset),
        .EX_PC_Plus4(ID_EX_PC_Plus4),
        .EX_ALUOut(ALUOut),
        .EX_rt_data(rt_data_forward_ex),
        .EX_Rd(Write_Addr), // register write address
        .EX_MemWrite(ID_EX_MemWrite),
        .EX_MemRead(ID_EX_MemRead),
        .EX_MemtoReg(ID_EX_MemtoReg),
        .EX_RegWrite(ID_EX_RegWrite),
        .EX_MEM_PC_Plus4(EX_MEM_PC_Plus4), 
        .EX_MEM_ALUOut(EX_MEM_ALUOut), 
        .EX_MEM_rt_data(EX_MEM_rt_data),
        .EX_MEM_rd(EX_MEM_rd),
        .EX_MEM_MemtoReg(EX_MEM_MemtoReg),
        .EX_MEM_MemWrite(EX_MEM_MemWrite), 
        .EX_MEM_MemRead(EX_MEM_MemRead), 
        .EX_MEM_RegWrite(EX_MEM_RegWrite)
    );

    /* MEM Stage */
    wire mem_forward; // MEM_WB => MEM write_data
    MEM_Forwarding MEM_Forward_Ctrl(
        .EX_MEM_rt(EX_MEM_rd),
        .EX_MEM_MemWrite(EX_MEM_MemWrite),
        .MEM_WB_MemRead(MEM_WB_MemRead),
        .MEM_WB_rt(MEM_WB_Rd),
        .MEM_Forward(mem_forward)  
    );
    wire [31:0] mem_wr_data;
    assign mem_wr_data = (mem_forward) ? MEM_WB_write_data: EX_MEM_rt_data;

    wire [31:0] mem_read_data;
    DataMem MyDataMem(
        .clk(clk),
        .reset(reset),
        .Address(EX_MEM_ALUOut),
        .Write_data(mem_wr_data),
        .MemWrite(EX_MEM_MemWrite),
        .MemRead(EX_MEM_MemRead),
        .Read_data(mem_read_data),
        .leds(leds),
        .an(an),
        .BCD(BCD)
    );

    wire [31:0] wb_wr_data;
    assign wb_wr_data = (EX_MEM_MemtoReg==2'b00)?EX_MEM_ALUOut:
                (EX_MEM_MemtoReg==2'b01)?mem_read_data:EX_MEM_PC_Plus4;


    MEM_WB MEM_WB_Reg(
        .clk(clk),
        .reset(reset),
        .MEM_write_data(wb_wr_data),
        .MEM_Rd(EX_MEM_rd),
        .MEM_RegWrite(EX_MEM_RegWrite),
        .MEM_MemRead(EX_MEM_MemRead),
        .MEM_WB_write_data(MEM_WB_write_data),
        .MEM_WB_Rd(MEM_WB_Rd),
        .MEM_WB_RegWrite(MEM_WB_RegWrite),
        .MEM_WB_MemRead(MEM_WB_MemRead)
    );

    /* WB Stage */

    // write to register => do at regs


endmodule
