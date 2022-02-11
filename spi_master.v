`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Ozayer Islam
//
// Create Date:   04/02/2022
// Design Name:   spi_master
// Module Name:   spi_master.v
// Project Name:  SPI
// Target Device:  
// Tool versions:  
// Description: 
//
// 
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////
module spi_master(
    input wire[7:0] in_data,
    input wire clk,
    input wire wr,
    input wire rd,
    input wire cs, // active low
    output reg[7:0] out_data,
    output mosi,
    input miso,
    output sclk
    );
    
    // --------define internal register and buffer--------
    // output buffer stage
    reg sclk_buf = 0; // SCLK buffer 
    reg mosi_buf = 0; // MOSI Buffer
 
    reg busy = 0; // when set to 0, READ/WRITE state, otherwise Shift/Buffer state 
    reg[7:0] in_buf = 0; // shift register, Buffer that saves the input data For MOSI
    reg[7:0] out_buf = 0; // shift register, Buffer that saves the output data For MISO
    reg[4:0] cnt = 0; // Variable to keep count of sclk 
    // --------------------------------------------------

    // the port of module links internal buffer
    assign sclk = sclk_buf; // sclk for master and slave
    assign mosi = mosi_buf; // mosi bits
    

    // sclk positive edge write data to mosi
    always @(posedge clk) begin
        if (!busy) begin // idle state load data into send buffer
            if(!cs && wr) begin // When cs is low and wr is high
                  in_buf <= in_data; // Take Input data to Internal Buffer
                  busy <= 1; // Set Busy Signal High
                  cnt <= 0;
            end
            else if(!cs && rd) begin
                busy <= 1;
                cnt <= 0;
            end
        end
        else begin // when 8-bits data is written into buffer , send it bit by bit in MOSI
                if (cnt % 2 != 0) begin // when sclk_buf is positive , shift data into mosi buffer
                    mosi_buf <= in_buf[7];
                    in_buf <= in_buf << 1;
                end 
                else begin
                    mosi_buf <= mosi_buf; // Do nothing
                end

                if (cnt > 0 && cnt < 17) begin
                    sclk_buf <= ~sclk_buf; // Toggle the sclk 16 times to send 8 bits
                end

                // 8-bits had sent over , spi regain idle
                if (cnt >= 17) begin 
                    cnt <= 0;
                    busy <= 0;
                end
                else begin
                    cnt <= cnt; // Do Nothing
                    busy <= busy; // Do Nothing
                end

                cnt <= cnt + 1; // Keep Counting
        end 
    end
    
    //sclk negetive edge read data into out-shift register from miso , implement read operation
    always @(negedge sclk_buf) begin
        out_buf[0] <= miso;
        out_buf <= out_buf << 1;
    end 

    // read data (combinatorial logic that level sensitive , detect all input)
    always @(cs or wr or rd or out_buf or busy) begin
        out_data = 8'bx;
        if (!cs && rd) begin
            out_data = out_buf;
        end
    end
   
endmodule
