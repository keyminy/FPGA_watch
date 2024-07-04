module hex2bcd_4(
    input rst,clk,
    input start,
    input [13:0] din,
    output reg done,
    output reg [3:0] bcd_a,bcd_b,bcd_c,bcd_d // 1000, 100, 10, 1
    );
    
reg st0,st1;
reg [3:0] stcnt;
reg [3:0] bcda,bcdb,bcdc;
reg [13:0] temp;

always@(negedge rst, posedge clk)
begin
    if (rst == 0)
        done <= 0;  
    else 
        if ((stcnt >= 7) & (stcnt < 15))    
            done <= 1;
        else 
            done <= 0;
end

always@(negedge rst, posedge clk)
begin
    if (rst == 0)
        begin
            temp <= 0;  bcda <= 0;  bcdb <= 0;  bcdc <= 0;   
            bcd_a <= 0; bcd_b <= 0; bcd_c <= 0; bcd_d <= 0;    
        end
    else 
        begin
            if (st0 & ~st1)         // Rising Edge of START
                temp <= din;
            else if (stcnt == 0)    // Decide 1000's Value
            //  bcdh <= 0;
                if      (temp >= 9000)  begin   bcda <= 9;  temp <= temp - 9000;  end
                else if (temp >= 8000)  begin   bcda <= 8;  temp <= temp - 8000;  end  
                else if (temp >= 7000)  begin   bcda <= 7;  temp <= temp - 7000;  end  
                else if (temp >= 6000)  begin   bcda <= 6;  temp <= temp - 6000;  end  
                else if (temp >= 5000)  begin   bcda <= 5;  temp <= temp - 5000;  end  
                else if (temp >= 4000)  begin   bcda <= 4;  temp <= temp - 4000;  end  
                else if (temp >= 3000)  begin   bcda <= 3;  temp <= temp - 3000;  end  
                else if (temp >= 2000)  begin   bcda <= 2;  temp <= temp - 1000;  end  
                else if (temp >= 1000)  begin   bcda <= 1;  temp <= temp - 1000;  end  
                else                            bcda <= 0;           
            else if (stcnt == 1)    // Decide 100's Value
            //  bcdh <= 0;
                if      (temp >= 900)   begin   bcdb <= 9;  temp <= temp - 900;  end
                else if (temp >= 800)   begin   bcdb <= 8;  temp <= temp - 800;  end  
                else if (temp >= 700)   begin   bcdb <= 7;  temp <= temp - 700;  end  
                else if (temp >= 600)   begin   bcdb <= 6;  temp <= temp - 600;  end  
                else if (temp >= 500)   begin   bcdb <= 5;  temp <= temp - 500;  end  
                else if (temp >= 400)   begin   bcdb <= 4;  temp <= temp - 400;  end  
                else if (temp >= 300)   begin   bcdb <= 3;  temp <= temp - 300;  end  
                else if (temp >= 200)   begin   bcdb <= 2;  temp <= temp - 100;  end  
                else if (temp >= 100)   begin   bcdb <= 1;  temp <= temp - 100;  end  
                else                            bcdb <= 0;           
            else if (stcnt == 2)    // Decide 10's Value
            //  bcdh <= 0;
                if      (temp >= 90) begin   bcdc <= 9;  temp <= temp - 90;  end
                else if (temp >= 80) begin   bcdc <= 8;  temp <= temp - 80;  end  
                else if (temp >= 70) begin   bcdc <= 7;  temp <= temp - 70;  end  
                else if (temp >= 60) begin   bcdc <= 6;  temp <= temp - 60;  end  
                else if (temp >= 50) begin   bcdc <= 5;  temp <= temp - 50;  end  
                else if (temp >= 40) begin   bcdc <= 4;  temp <= temp - 40;  end  
                else if (temp >= 30) begin   bcdc <= 3;  temp <= temp - 30;  end  
                else if (temp >= 20) begin   bcdc <= 2;  temp <= temp - 10;  end  
                else if (temp >= 10) begin   bcdc <= 1;  temp <= temp - 10;  end  
                else                         bcdc <= 0;           
            else if (stcnt == 3)    // Decide 1's Value    
                begin 
                    bcd_a <= bcda;  bcd_b <= bcdb;  bcd_c <= bcdc;  bcd_d <= temp[3:0]; 
                end
        end
end

always@(negedge rst, posedge clk)
begin
    if (rst == 0)
        begin
            st0 <= 0;  st1 <= 0;  
            stcnt <= 15;       
        end
    else 
        begin
            st0 <= start;   st1 <= st0;
            if (st0 & ~st1)         // Rising Edge of START
                stcnt <= 0;
            else if (stcnt < 15)    
                stcnt <= stcnt + 1;
        end
end

endmodule
