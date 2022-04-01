module ram1(data_out,data_in,addr,wr,cs);
parameter addr_size=10,word_size=8,memory_size=1024;
input [addr_size-1:0]addr;
input [word_size-1:0]data_in;
input wr,cs;
output [word_size-1:0]data_out;
reg [word_size-1:0] mem[memory_size-1:0];
assign data_out=mem[addr];
always @(wr or cs)
if(wr) mem[addr]=data_in;
endmodule

//testbench
module ram_test;
reg[9:0]address;
wire[7:0]data_out;
reg[7:0]data_in;
reg write,select;
integer k,myseed;
ram1 ram(data_out,data_in,address,write,select);
initial 
begin
  for(k=0;k<=16;k=k+1)
#100
begin 
data_in=(k+k)% 256; write=1; select=1;
#2 address=k;write=0;select=0;
$display("address:%5d,dat:%4d",address,data_in);
end
end
endmodule
