`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.02.2022 10:09:48
// Design Name: 
// Module Name: tb_spi_slave
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module spi_slave_tb;

    // Inputs
    reg [7:0] in_data;
    reg clk;
    reg wr;
    reg rd;
    reg cs;
    reg mosi;

    // Outputs
    wire [7:0] out_data;

    // Bidirs
    wire miso;
    wire sclk;

    // Instantiate the Unit Under Test (UUT)
    spi_slave slave (
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
        mosi = 0;

        #40;
        in_data = 8'hbb;
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
        in_data = 8'hff;

        #20 ;
        wr = 0;
        cs = 1;

        #360 ;
        rd = 0;
        wr = 1;
        cs = 0;
        in_data = 8'h22;

        #20 ;
        wr = 0;
        cs = 1;

        #360 ;
        rd = 0;
        wr = 1;
        cs = 0;
        in_data = 8'h33;

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

