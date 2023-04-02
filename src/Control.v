`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/07/19 15:39:09
// Design Name: 
// Module Name: Control
// Project Name: 
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


module Control(OpCode, Funct, PCSrc, RegWrite,
        RegDst, MemRead, MemWrite, MemtoReg, 
        ALUSrc1, ALUSrc2, ExtOp, LuiOp, JumpSignal, BranchSignal, ALUOp);
    input [5:0] OpCode;
    input [5:0] Funct;
    output [1:0] PCSrc;
    output RegWrite;
    output [1:0] RegDst;
    output MemRead;
    output MemWrite;
    output [1:0] MemtoReg;
    output ALUSrc1;
    output ALUSrc2;
    output ExtOp; // 是否（符号）扩展立即数
    output LuiOp; // 是否左移16位
    output JumpSignal; // 标记跳转指令
    output [2:0] BranchSignal; // 标记分支指令
    output reg [3:0] ALUOp;

    // lui => imm << 16
    assign LuiOp=(OpCode==6'b001111);

    // ExtOp: 0 => 0_extand, 1 => sign_extand
    // andi ori xori => 0_extend
    assign ExtOp=(OpCode!=6'h0 && OpCode!=6'b001100 && OpCode!=6'b001101 && OpCode!=6'b001110);

    assign MemRead=(OpCode==6'h23);
    assign MemWrite=(OpCode==6'h2b);

    // RegDst: control RegisterFile write address
    // 00: jal,jalr => $ra($31)
    // 01: R_type => rd
    // 10: else => rt/Instruction[20:16]
    assign RegDst=(OpCode==6'h03 || (OpCode==6'h00 && Funct==6'h09))?2'b00:
            (OpCode==6'h00)?2'b01:2'b10;

    // BranchSignal
    // 000 => not branch
    // 001 => bltz
    // 100 => beq
    // 101 => bne
    // 110 => blez
    // 111 => bgtz
    assign BranchSignal=(OpCode==6'h1||OpCode==6'h4||OpCode==6'h5||OpCode==6'h6||OpCode==6'h7)?OpCode[2:0]:3'h0;

    // RegWrite
    // branch,j,jr,sw => 0
    assign RegWrite=~((|BranchSignal)||OpCode==6'h2b||OpCode==6'h02||(OpCode==6'h00 && Funct==6'h08));

    // MemtoReg: control RegisterFile write data
    // 00 => ALU result
    // lw:01 => Memory ReadData
    // jal,jalr:10 => PC+4
    assign MemtoReg=(OpCode==6'h03 || (OpCode==6'h00 && Funct==6'h09))?2'b10:
        (OpCode==6'h23)?2'b01:2'b00;

    // JumpSignal
    // j,jal,jr,jalr => 1
    assign JumpSignal=(OpCode==2'h2)||(OpCode==2'h3)||(OpCode==2'h0&&(Funct==6'h8||Funct==6'h9));

    // PCSrc
    // 00 => PC+4
    // j: 01 => {(PC+4)[31:28],addr,00}
    // jr: 10 => [rs]
    // branch: PC => branch_target (controlled by Branch_Hazard)
    assign PCSrc=(OpCode==6'h02 || OpCode==6'h03)?2'b01:
        (OpCode==6'h00 && (Funct==6'h08 || Funct==6'h09))?2'b10:2'b00;

    // ALUSrc1
    // 0 => ReadData1(include forwarding result) rs
    // sll, srl, sra: 1 => Shamt
    assign ALUSrc1=(OpCode==0 && (Funct==6'h0 || Funct==6'h02 || Funct==6'h03));

    // ALUSrc2
    // 0 => ReadData2
    // not R && not Branch: 1 => imm
    assign ALUSrc2=(OpCode!=6'h00 && !(|BranchSignal));

    // ALUOp
    // only assign for not branch && not jump
    parameter ADD_OP=4'h0; // add
    parameter SUB_OP=4'h1; // sub
    parameter AND_OP=4'h2; // and
    parameter OR_OP=4'h3;  // or
    parameter XOR_OP=4'h4; // xor
    parameter NOR_OP=4'h5; // nor
    parameter SLL_OP=4'h6; // sll
    parameter SRL_OP=4'h7; // srl
    parameter SRA_OP=4'h8; // sra
    parameter U_CMP_OP=4'h9; // unsigned compare
    parameter S_CMP_OP=4'ha; // signed compare

    always @(*) begin
        case(OpCode)
            6'h00: begin
                case(Funct)
                    6'h20,6'h21: ALUOp<=ADD_OP;
                    6'h22,6'h23: ALUOp<=SUB_OP;
                    6'h24: ALUOp<=AND_OP;
                    6'h25: ALUOp<=OR_OP;
                    6'h26: ALUOp<=XOR_OP;
                    6'h27: ALUOp<=NOR_OP;
                    6'h2a: ALUOp<=S_CMP_OP; // slt
                    6'h2b: ALUOp<=U_CMP_OP; // sltu
                    6'h00: ALUOp<=SLL_OP;
                    6'h02: ALUOp<=SRL_OP;
                    6'h03: ALUOp<=SRA_OP;
                    default: ALUOp<=ADD_OP;
                endcase
            end
            6'h0f,6'h08,6'h09,6'h23,6'h2b: ALUOp<=ADD_OP; // lui addi addiu lw sw
            6'h0c: ALUOp<=AND_OP; // andi
            6'h0a: ALUOp<=S_CMP_OP; // slti
            6'h0b: ALUOp<=U_CMP_OP; // sltiu
            6'h0d: ALUOp<=OR_OP; // ori
            6'h0e: ALUOp<=XOR_OP; // xori
            default: ALUOp<=ADD_OP;
        endcase

    end

endmodule
