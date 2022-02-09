`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Ozayer Islam
//
// Create Date:   04/02/2022
// Design Name:   spi_master
// Module Name:   spi_master_tb.v
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

module spi_master_tb;

    // Inputs
    reg [7:0] in_data;
    reg clk;
    reg wr;
    reg rd;
    reg cs;
    reg miso;

    // Outputs
    wire [7:0] out_data;

    // Bidirs
    wire mosi;
    wire sclk;

    // Instantiate the Unit Under Test (UUT)
    spi_master uut (
        .in_data(in_data), 
        .clk(clk), 
        .wr(wr), 
        .rd(rd), 
        .cs(cs), 
        .out_data(out_data), 
        .mosi(mosi), 
        .miso(miso), 
        .sclk(sclk)
    );

    initial begin
        // Initialize Inputs
        in_data = 0;
        clk = 0;
        wr = 0;
        rd = 0;
        cs = 1;
        miso = 0;

        #40;
        in_data = 8'haa;
        wr = 1;
        cs = 0;
        
        // write data 
        #25 ;
        wr = 0;
        cs = 1;

        #360 ;
        rd = 0;
        wr = 1;
        cs = 0;
        in_data = 8'h91;

        #20 ;
        wr = 0;
        cs = 1;

        #360 ;
        rd = 0;
        wr = 1;
        cs = 0;
        in_data = 8'hf0;

        #20 ;
        wr = 0;
        cs = 1;

        #360 ;
        rd = 0;
        wr = 1;
        cs = 0;
        in_data = 8'h12;

        #20 ;
        wr = 0;
        cs = 1;

    end

    // define clock
    initial begin
        clk = 0;
        forever #10 clk = ~clk;
    end
endmodule
