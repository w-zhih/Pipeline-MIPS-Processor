module ALU(in1, in2, ALUOp, out, zero);
    input [31:0] in1, in2;
    input [3:0] ALUOp;
    output reg [31:0] out;
    output zero;

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
        case(ALUOp)
            ADD_OP: out<=in1+in2;
            SUB_OP: out<=in1-in2;
            AND_OP: out<=in1&in2;
            OR_OP: out<=in1|in2;
            XOR_OP: out<=in1^in2;
            NOR_OP: out<=~(in1|in2);
            SLL_OP: out<=in2<<in1;
            SRL_OP: out<=in2>>in1;
            SRA_OP: out<=$signed(in2)>>>in1;
            U_CMP_OP: out<=in1<in2;
            S_CMP_OP: out<= $signed(in1)<$signed(in2);
            default: out<=0;
        endcase
    end

    assign zero=(out==0);

endmodule