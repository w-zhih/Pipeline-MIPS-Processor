`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/07/19 15:24:07
// Design Name: 
// Module Name: MEM_WB
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


module MEM_WB(
        clk,
        reset,
        MEM_write_data,
        MEM_Rd, // register write address
        MEM_RegWrite,
        MEM_MemRead, // 判断该指令在MEM阶段是否读mem
        MEM_WB_write_data,
        MEM_WB_Rd,
        MEM_WB_RegWrite,
        MEM_WB_MemRead
    );
    input clk, reset;
    input [31:0] MEM_write_data;
    input [4:0] MEM_Rd;
    input MEM_RegWrite, MEM_MemRead;

    output reg [31:0] MEM_WB_write_data; // write to register file
    output reg [4:0] MEM_WB_Rd;
    output reg MEM_WB_RegWrite, MEM_WB_MemRead;

    always @(posedge clk or posedge reset) begin
        if(reset) begin
            MEM_WB_write_data<=32'b0;
            MEM_WB_Rd<=5'b0;
            MEM_WB_RegWrite<=0;
            MEM_WB_MemRead<=0;
        end
        else begin
            MEM_WB_write_data<=MEM_write_data;
            MEM_WB_Rd<=MEM_Rd;
            MEM_WB_RegWrite<=MEM_RegWrite;
            MEM_WB_MemRead<=MEM_MemRead;
        end
    end

endmodule
