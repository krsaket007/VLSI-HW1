// ADD

module ADD ( A, B, S);

	parameter n = 16;

	input  [n-1:0] A;
	input  [n-1:0] B;

	output [n-1:0] S;

	assign S = A + B;

endmodule
