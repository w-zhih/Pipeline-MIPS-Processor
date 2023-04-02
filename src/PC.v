`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Zhiheng Wang
// 
// Create Date: 2022/07/18 14:10:25
// Design Name: 
// Module Name: PC
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


module PC(reset, clk, PCWrite, PC_i, PC_o);
    input reset;
    input clk;
    input PCWrite; // 0: 暂停PC
    input [31:0] PC_i;
    output reg [31:0] PC_o;
    
    
    always@(posedge reset or posedge clk)
    begin
        if(reset) begin
            PC_o <= 0;
        end else if (PCWrite) begin
            PC_o <= PC_i;
        end else begin
            PC_o <= PC_o;
        end
    end
    
endmodule
