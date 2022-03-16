`timescale 1ns/1ps

module alu(
           rst_n,         // negative reset            (input)
           src1,          // 32 bits source 1          (input)
           src2,          // 32 bits source 2          (input)
           ALU_control,   // 4 bits ALU control input  (input)
		 //bonus_control, // 3 bits bonus control input(input) 
           result,        // 32 bits result            (output)
           zero,          // 1 bit when the output is 0, zero must be set (output)
           cout,          // 1 bit carry out           (output)
           overflow       // 1 bit overflow            (output)
           );


input           rst_n;
input  [32-1:0] src1;
input  [32-1:0] src2;
input   [4-1:0] ALU_control;
//input   [3-1:0] bonus_control; 

output [32-1:0] result;
output          zero;
output          cout;
output          overflow;

wire   [32-1:0] carry;
wire            set;
reg    [32-1:0] result1;
reg             zero1;
reg             cout1;
reg             A_invert;
reg             B_invert;
reg    [2-1:0]  operation;

assign zero = !result;
//assign cout=cout1;
assign overflow = (ALU_control==4'b0010 && src1[31] && src2[31] && !result[31])    ||
                  (ALU_control==4'b0010 && !src1[31] && !src2[31] && result[31])   ||
                  (ALU_control==4'b0110 && src1[31] && !src2[31] && !result[31])    ||
                  (ALU_control==4'b0110 && !src1[31] && src2[31] && result[31]);

always@(*)begin
    if(ALU_control==4'b1100 ||
       ALU_control==4'b1101  )begin
        A_invert=1;B_invert=1;
    end
    else if(ALU_control==4'b0110)
        B_invert=1;
    else begin
        A_invert=0;B_invert=0;
    end

    case(ALU_control)
        4'b0000:operation=2'b00;
        4'b1100:operation=2'b00;
        4'b0001:operation=2'b01;
        4'b1101:operation=2'b01;
        4'b0010:operation=2'b10;
        4'b0110:operation=2'b10;
        4'b0111:operation=2'b11;
    
    endcase
end
alu_top a0(
    .src1(src1[0]),       //1 bit source 1 (input)
    .src2(src2[0]),       //1 bit source 2 (input)
    .less(set),     //1 bit less     (input)
    .A_invert(A_invert),   //1 bit A_invert (input)
    .B_invert(B_invert),   //1 bit B_invert (input)
    .cin(B_invert),        //1 bit carry in (input)
    .operation(operation),  //operation      (input)
    .result(result[0]),     //1 bit result   (output)
    .cout(carry[1])      //1 bit carry out(output)
);
alu_top a1(
    .src1(src1[1]),       //1 bit source 1 (input)
    .src2(src2[1]),       //1 bit source 2 (input)
    .less(0),       //1 bit less     (input)
    .A_invert(A_invert),   //1 bit A_invert (input)
    .B_invert(B_invert),   //1 bit B_invert (input)
    .cin(carry[1]),        //1 bit carry in (input)
    .operation(operation),  //operation      (input)
    .result(result[1]),     //1 bit result   (output)
    .cout(carry[2])       //1 bit carry out(output)
);
alu_top a2(
    .src1(src1[2]),       //1 bit source 1 (input)
    .src2(src2[2]),       //1 bit source 2 (input)
    .less(0),       //1 bit less     (input)
    .A_invert(A_invert),   //1 bit A_invert (input)
    .B_invert(B_invert),   //1 bit B_invert (input)
    .cin(carry[2]),        //1 bit carry in (input)
    .operation(operation),  //operation      (input)
    .result(result[2]),     //1 bit result   (output)
    .cout(carry[3])       //1 bit carry out(output)
);
alu_top a3(
    .src1(src1[3]),       //1 bit source 1 (input)
    .src2(src2[3]),       //1 bit source 2 (input)
    .less(0),       //1 bit less     (input)
    .A_invert(A_invert),   //1 bit A_invert (input)
    .B_invert(B_invert),   //1 bit B_invert (input)
    .cin(carry[3]),        //1 bit carry in (input)
    .operation(operation),  //operation      (input)
    .result(result[3]),     //1 bit result   (output)
    .cout(carry[4])       //1 bit carry out(output)
);
alu_top a4(
    .src1(src1[4]),       //1 bit source 1 (input)
    .src2(src2[4]),       //1 bit source 2 (input)
    .less(0),       //1 bit less     (input)
    .A_invert(A_invert),   //1 bit A_invert (input)
    .B_invert(B_invert),   //1 bit B_invert (input)
    .cin(carry[4]),        //1 bit carry in (input)
    .operation(operation),  //operation      (input)
    .result(result[4]),     //1 bit result   (output)
    .cout(carry[5])       //1 bit carry out(output)
);
alu_top a5(
    .src1(src1[5]),       //1 bit source 1 (input)
    .src2(src2[5]),       //1 bit source 2 (input)
    .less(0),       //1 bit less     (input)
    .A_invert(A_invert),   //1 bit A_invert (input)
    .B_invert(B_invert),   //1 bit B_invert (input)
    .cin(carry[5]),        //1 bit carry in (input)
    .operation(operation),  //operation      (input)
    .result(result[5]),     //1 bit result   (output)
    .cout(carry[6])       //1 bit carry out(output)
);
alu_top a6(
    .src1(src1[6]),       //1 bit source 1 (input)
    .src2(src2[6]),       //1 bit source 2 (input)
    .less(0),       //1 bit less     (input)
    .A_invert(A_invert),   //1 bit A_invert (input)
    .B_invert(B_invert),   //1 bit B_invert (input)
    .cin(carry[6]),        //1 bit carry in (input)
    .operation(operation),  //operation      (input)
    .result(result[6]),     //1 bit result   (output)
    .cout(carry[7])       //1 bit carry out(output)
);
alu_top a7(
    .src1(src1[7]),       //1 bit source 1 (input)
    .src2(src2[7]),       //1 bit source 2 (input)
    .less(0),       //1 bit less     (input)
    .A_invert(A_invert),   //1 bit A_invert (input)
    .B_invert(B_invert),   //1 bit B_invert (input)
    .cin(carry[7]),        //1 bit carry in (input)
    .operation(operation),  //operation      (input)
    .result(result[7]),     //1 bit result   (output)
    .cout(carry[8])       //1 bit carry out(output)
);
alu_top a8(
    .src1(src1[8]),       //1 bit source 1 (input)
    .src2(src2[8]),       //1 bit source 2 (input)
    .less(0),       //1 bit less     (input)
    .A_invert(A_invert),   //1 bit A_invert (input)
    .B_invert(B_invert),   //1 bit B_invert (input)
    .cin(carry[8]),        //1 bit carry in (input)
    .operation(operation),  //operation      (input)
    .result(result[8]),     //1 bit result   (output)
    .cout(carry[9])       //1 bit carry out(output)
);
alu_top a9(
    .src1(src1[9]),       //1 bit source 1 (input)
    .src2(src2[9]),       //1 bit source 2 (input)
    .less(0),       //1 bit less     (input)
    .A_invert(A_invert),   //1 bit A_invert (input)
    .B_invert(B_invert),   //1 bit B_invert (input)
    .cin(carry[9]),        //1 bit carry in (input)
    .operation(operation),  //operation      (input)
    .result(result[9]),     //1 bit result   (output)
    .cout(carry[10])       //1 bit carry out(output)
);
alu_top a10(
    .src1(src1[10]),       //1 bit source 1 (input)
    .src2(src2[10]),       //1 bit source 2 (input)
    .less(0),       //1 bit less     (input)
    .A_invert(A_invert),   //1 bit A_invert (input)
    .B_invert(B_invert),   //1 bit B_invert (input)
    .cin(carry[10]),        //1 bit carry in (input)
    .operation(operation),  //operation      (input)
    .result(result[10]),     //1 bit result   (output)
    .cout(carry[11])       //1 bit carry out(output)
);
alu_top a11(
    .src1(src1[11]),       //1 bit source 1 (input)
    .src2(src2[11]),       //1 bit source 2 (input)
    .less(0),       //1 bit less     (input)
    .A_invert(A_invert),   //1 bit A_invert (input)
    .B_invert(B_invert),   //1 bit B_invert (input)
    .cin(carry[11]),        //1 bit carry in (input)
    .operation(operation),  //operation      (input)
    .result(result[11]),     //1 bit result   (output)
    .cout(carry[12])       //1 bit carry out(output)
);
alu_top a12(
    .src1(src1[12]),       //1 bit source 1 (input)
    .src2(src2[12]),       //1 bit source 2 (input)
    .less(0),       //1 bit less     (input)
    .A_invert(A_invert),   //1 bit A_invert (input)
    .B_invert(B_invert),   //1 bit B_invert (input)
    .cin(carry[12]),        //1 bit carry in (input)
    .operation(operation),  //operation      (input)
    .result(result[12]),     //1 bit result   (output)
    .cout(carry[13])       //1 bit carry out(output)
);
alu_top a13(
    .src1(src1[13]),       //1 bit source 1 (input)
    .src2(src2[13]),       //1 bit source 2 (input)
    .less(0),       //1 bit less     (input)
    .A_invert(A_invert),   //1 bit A_invert (input)
    .B_invert(B_invert),   //1 bit B_invert (input)
    .cin(carry[13]),        //1 bit carry in (input)
    .operation(operation),  //operation      (input)
    .result(result[13]),     //1 bit result   (output)
    .cout(carry[14])       //1 bit carry out(output)
);
alu_top a14(
    .src1(src1[14]),       //1 bit source 1 (input)
    .src2(src2[14]),       //1 bit source 2 (input)
    .less(0),       //1 bit less     (input)
    .A_invert(A_invert),   //1 bit A_invert (input)
    .B_invert(B_invert),   //1 bit B_invert (input)
    .cin(carry[14]),        //1 bit carry in (input)
    .operation(operation),  //operation      (input)
    .result(result[14]),     //1 bit result   (output)
    .cout(carry[15])       //1 bit carry out(output)
);
alu_top a15(
    .src1(src1[15]),       //1 bit source 1 (input)
    .src2(src2[15]),       //1 bit source 2 (input)
    .less(0),       //1 bit less     (input)
    .A_invert(A_invert),   //1 bit A_invert (input)
    .B_invert(B_invert),   //1 bit B_invert (input)
    .cin(carry[15]),        //1 bit carry in (input)
    .operation(operation),  //operation      (input)
    .result(result[15]),     //1 bit result   (output)
    .cout(carry[16])       //1 bit carry out(output)
);
alu_top a16(
    .src1(src1[16]),       //1 bit source 1 (input)
    .src2(src2[16]),       //1 bit source 2 (input)
    .less(0),       //1 bit less     (input)
    .A_invert(A_invert),   //1 bit A_invert (input)
    .B_invert(B_invert),   //1 bit B_invert (input)
    .cin(carry[16]),        //1 bit carry in (input)
    .operation(operation),  //operation      (input)
    .result(result[16]),     //1 bit result   (output)
    .cout(carry[17])       //1 bit carry out(output)
);
alu_top a17(
    .src1(src1[17]),       //1 bit source 1 (input)
    .src2(src2[17]),       //1 bit source 2 (input)
    .less(0),       //1 bit less     (input)
    .A_invert(A_invert),   //1 bit A_invert (input)
    .B_invert(B_invert),   //1 bit B_invert (input)
    .cin(carry[17]),        //1 bit carry in (input)
    .operation(operation),  //operation      (input)
    .result(result[17]),     //1 bit result   (output)
    .cout(carry[18])       //1 bit carry out(output)
);
alu_top a18(
    .src1(src1[18]),       //1 bit source 1 (input)
    .src2(src2[18]),       //1 bit source 2 (input)
    .less(0),       //1 bit less     (input)
    .A_invert(A_invert),   //1 bit A_invert (input)
    .B_invert(B_invert),   //1 bit B_invert (input)
    .cin(carry[18]),        //1 bit carry in (input)
    .operation(operation),  //operation      (input)
    .result(result[18]),     //1 bit result   (output)
    .cout(carry[19])       //1 bit carry out(output)
);
alu_top a19(
    .src1(src1[19]),       //1 bit source 1 (input)
    .src2(src2[19]),       //1 bit source 2 (input)
    .less(0),       //1 bit less     (input)
    .A_invert(A_invert),   //1 bit A_invert (input)
    .B_invert(B_invert),   //1 bit B_invert (input)
    .cin(carry[19]),        //1 bit carry in (input)
    .operation(operation),  //operation      (input)
    .result(result[19]),     //1 bit result   (output)
    .cout(carry[20])       //1 bit carry out(output)
);
alu_top a20(
    .src1(src1[20]),       //1 bit source 1 (input)
    .src2(src2[20]),       //1 bit source 2 (input)
    .less(0),       //1 bit less     (input)
    .A_invert(A_invert),   //1 bit A_invert (input)
    .B_invert(B_invert),   //1 bit B_invert (input)
    .cin(carry[20]),        //1 bit carry in (input)
    .operation(operation),  //operation      (input)
    .result(result[20]),     //1 bit result   (output)
    .cout(carry[21])       //1 bit carry out(output)
);
alu_top a21(
    .src1(src1[21]),       //1 bit source 1 (input)
    .src2(src2[21]),       //1 bit source 2 (input)
    .less(0),       //1 bit less     (input)
    .A_invert(A_invert),   //1 bit A_invert (input)
    .B_invert(B_invert),   //1 bit B_invert (input)
    .cin(carry[21]),        //1 bit carry in (input)
    .operation(operation),  //operation      (input)
    .result(result[21]),     //1 bit result   (output)
    .cout(carry[22])       //1 bit carry out(output)
);
alu_top a22(
    .src1(src1[22]),       //1 bit source 1 (input)
    .src2(src2[22]),       //1 bit source 2 (input)
    .less(0),       //1 bit less     (input)
    .A_invert(A_invert),   //1 bit A_invert (input)
    .B_invert(B_invert),   //1 bit B_invert (input)
    .cin(carry[22]),        //1 bit carry in (input)
    .operation(operation),  //operation      (input)
    .result(result[22]),     //1 bit result   (output)
    .cout(carry[23])       //1 bit carry out(output)
);
alu_top a23(
    .src1(src1[23]),       //1 bit source 1 (input)
    .src2(src2[23]),       //1 bit source 2 (input)
    .less(0),       //1 bit less     (input)
    .A_invert(A_invert),   //1 bit A_invert (input)
    .B_invert(B_invert),   //1 bit B_invert (input)
    .cin(carry[23]),        //1 bit carry in (input)
    .operation(operation),  //operation      (input)
    .result(result[23]),     //1 bit result   (output)
    .cout(carry[24])       //1 bit carry out(output)
);
alu_top a24(
    .src1(src1[24]),       //1 bit source 1 (input)
    .src2(src2[24]),       //1 bit source 2 (input)
    .less(0),       //1 bit less     (input)
    .A_invert(A_invert),   //1 bit A_invert (input)
    .B_invert(B_invert),   //1 bit B_invert (input)
    .cin(carry[24]),        //1 bit carry in (input)
    .operation(operation),  //operation      (input)
    .result(result[24]),     //1 bit result   (output)
    .cout(carry[25])       //1 bit carry out(output)
);
alu_top a25(
    .src1(src1[25]),       //1 bit source 1 (input)
    .src2(src2[25]),       //1 bit source 2 (input)
    .less(0),       //1 bit less     (input)
    .A_invert(A_invert),   //1 bit A_invert (input)
    .B_invert(B_invert),   //1 bit B_invert (input)
    .cin(carry[25]),        //1 bit carry in (input)
    .operation(operation),  //operation      (input)
    .result(result[25]),     //1 bit result   (output)
    .cout(carry[26])       //1 bit carry out(output)
);
alu_top a26(
    .src1(src1[26]),       //1 bit source 1 (input)
    .src2(src2[26]),       //1 bit source 2 (input)
    .less(0),       //1 bit less     (input)
    .A_invert(A_invert),   //1 bit A_invert (input)
    .B_invert(B_invert),   //1 bit B_invert (input)
    .cin(carry[26]),        //1 bit carry in (input)
    .operation(operation),  //operation      (input)
    .result(result[26]),     //1 bit result   (output)
    .cout(carry[27])       //1 bit carry out(output)
);
alu_top a27(
    .src1(src1[27]),       //1 bit source 1 (input)
    .src2(src2[27]),       //1 bit source 2 (input)
    .less(0),       //1 bit less     (input)
    .A_invert(A_invert),   //1 bit A_invert (input)
    .B_invert(B_invert),   //1 bit B_invert (input)
    .cin(carry[27]),        //1 bit carry in (input)
    .operation(operation),  //operation      (input)
    .result(result[27]),     //1 bit result   (output)
    .cout(carry[28])       //1 bit carry out(output)
);
alu_top a28(
    .src1(src1[28]),       //1 bit source 1 (input)
    .src2(src2[28]),       //1 bit source 2 (input)
    .less(0),       //1 bit less     (input)
    .A_invert(A_invert),   //1 bit A_invert (input)
    .B_invert(B_invert),   //1 bit B_invert (input)
    .cin(carry[28]),        //1 bit carry in (input)
    .operation(operation),  //operation      (input)
    .result(result[28]),     //1 bit result   (output)
    .cout(carry[29])       //1 bit carry out(output)
);
alu_top a29(
    .src1(src1[29]),       //1 bit source 1 (input)
    .src2(src2[29]),       //1 bit source 2 (input)
    .less(0),       //1 bit less     (input)
    .A_invert(A_invert),   //1 bit A_invert (input)
    .B_invert(B_invert),   //1 bit B_invert (input)
    .cin(carry[29]),        //1 bit carry in (input)
    .operation(operation),  //operation      (input)
    .result(result[29]),     //1 bit result   (output)
    .cout(carry[30])       //1 bit carry out(output)
);
alu_top a30(
    .src1(src1[30]),       //1 bit source 1 (input)
    .src2(src2[30]),       //1 bit source 2 (input)
    .less(0),       //1 bit less     (input)
    .A_invert(A_invert),   //1 bit A_invert (input)
    .B_invert(B_invert),   //1 bit B_invert (input)
    .cin(carry[30]),        //1 bit carry in (input)
    .operation(operation),  //operation      (input)
    .result(result[30]),     //1 bit result   (output)
    .cout(carry[31])       //1 bit carry out(output)
);
alu_bottom ab1(
    .src1(src1[31]),       //1 bit source 1 (input)
    .src2(src2[31]),       //1 bit source 2 (input)
    .less(0),       //1 bit less     (input)
    .A_invert(A_invert),   //1 bit A_invert (input)
    .B_invert(B_invert),   //1 bit B_invert (input)
    .cin(carry[31]),        //1 bit carry in (input)
    .operation(operation),  //operation      (input)
    .result(result[31]),     //1 bit result   (output)
    .set(set),
    .cout(cout)       //1 bit carry out(output)
);

endmodule
