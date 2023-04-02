module EX_MEM(
         clk,
         reset,
         EX_PC_Plus4,
         EX_ALUOut,
         EX_rt_data,
         EX_Rd,
         EX_MemWrite,
         EX_MemRead,
         EX_MemtoReg,
         EX_RegWrite,
         EX_MEM_PC_Plus4,
         EX_MEM_ALUOut,
         EX_MEM_rt_data,
         EX_MEM_rd,
         EX_MEM_MemtoReg,
         EX_MEM_MemWrite,
         EX_MEM_MemRead,
         EX_MEM_RegWrite
       );
input clk, reset;

input [31:0] EX_PC_Plus4, EX_ALUOut, EX_rt_data;
input [4: 0] EX_Rd;
input [1: 0] EX_MemtoReg;
input EX_MemWrite, EX_MemRead, EX_RegWrite;

output reg [31: 0] EX_MEM_PC_Plus4, EX_MEM_ALUOut, EX_MEM_rt_data;
output reg [4: 0] EX_MEM_rd;
output reg [1: 0] EX_MEM_MemtoReg;
output reg EX_MEM_MemWrite, EX_MEM_MemRead, EX_MEM_RegWrite;

always @(posedge clk or posedge reset)
  begin
    if (reset)
      begin
        EX_MEM_PC_Plus4 <= 32'h0;
        EX_MEM_ALUOut <= 32'h0;
        EX_MEM_rt_data <= 32'h0;
        EX_MEM_rd <= 5'h0;
        EX_MEM_MemtoReg <= 2'h0;
        EX_MEM_MemWrite <= 1'b0;
        EX_MEM_MemRead <= 1'b0;
        EX_MEM_RegWrite <= 1'b0;
      end
    else
      begin
        EX_MEM_PC_Plus4 <= EX_PC_Plus4;
        EX_MEM_ALUOut <= EX_ALUOut;
        EX_MEM_rt_data <= EX_rt_data;
        EX_MEM_rd <= EX_Rd;
        EX_MEM_MemtoReg <= EX_MemtoReg;
        EX_MEM_MemWrite <= EX_MemWrite;
        EX_MEM_MemRead <= EX_MemRead;
        EX_MEM_RegWrite <= EX_RegWrite;
      end
  end

endmodule