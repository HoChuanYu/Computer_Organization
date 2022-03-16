`timescale 1ns/1ps

module alu_top(
               src1,       //1 bit source 1 (input)
               src2,       //1 bit source 2 (input)
               less,       //1 bit less     (input)
               A_invert,   //1 bit A_invert (input)
               B_invert,   //1 bit B_invert (input)
               cin,        //1 bit carry in (input)
               operation,  //operation      (input)
               result,     //1 bit result   (output)
               cout       //1 bit carry out(output)
               );

input         src1;
input         src2;
input         less;
input         A_invert;
input         B_invert;
input         cin;
input [2-1:0] operation;

output        result;
output        cout;

reg           result1;
reg           cout1;
wire          carry;
wire          sum;
assign result = result1;
assign cout = cout1;

add add(
    .A(src1),
    .B(B_invert?!src2:src2),
    .CIN(cin),
    .COUT(carry),
    .SUM(sum)
);

always@( * )
begin   
    case(operation)
        2'b00:begin//and, nor
            result1=(A_invert?!src1:src1)&(B_invert?!src2:src2);
            cout1=0;
        end
        2'b01:begin//or,nand
            result1=(A_invert?!src1:src1)|(B_invert?!src2:src2);
            cout1=0;
        end
        2'b10:begin//add sub
            result1=sum;
            cout1=carry;
        end
        2'b11:begin
            result1=less;
            cout1=carry;  
        end
    
    endcase


end

endmodule
