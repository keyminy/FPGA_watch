
module watch_hex2seg(
    input [3:0] din,
    output [7:0] seg_d
    );

   assign seg_d = (din == 4'h0) ? (8'h3f):
                  (din == 4'h1) ? (8'h06) :
                  (din == 4'h2) ? (8'h5b) :
                  (din == 4'h3) ? (8'h4f) :
                  (din == 4'h4) ? (8'h66) :
                  (din == 4'h5) ? (8'h6d) :
                  (din == 4'h6) ? (8'h7d) :
                  (din == 4'h7) ? (8'h27) :
                  (din == 4'h8) ? (8'h7f) :
                  (din == 4'h9) ? (8'h6f) :
                  (din == 4'ha) ? (8'h5f) :
                  (din == 4'hb) ? (8'h7c) :
                  (din == 4'hc) ? (8'h58) :
                  (din == 4'hd) ? (8'h5e) :
                  (din == 4'he) ? (8'h7b) :
                  (8'h71);
endmodule
