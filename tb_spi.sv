`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/14/2022 10:46:59 AM
// Design Name: 
// Module Name: tb_spi
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


module tb_spi(    
    );
    logic clk = 0, wr, rd;
    spi_interface spi_intf;
    logic [7:0] in_data;
    logic [7:0] out_data;
    
    spi_master uut (
        .in_data(in_data), 
        .clk(clk), 
        .wr(wr), 
        .rd(rd), 
        .cs(spi_intf.master.cs_), 
        .out_data(out_data), 
        .mosi(spi_intf.master.mosi), 
        .miso(spi_intf.master.miso), 
        .sclk(spi_intf.master.sclk)
    );
    
    spi_slave slave (
        .in_data(in_data), 
        .clk(clk), 
        .wr(wr), 
        .rd(rd), 
        .cs(spi_intf.slave.cs_), 
        .out_data(out_data), 
        .mosi(spi_intf.slave.mosi), 
        .miso(spi_intf.slave.miso), 
        .sclk(spi_intf.slave.sclk)
    );
    
    always #10 clk = ~clk;
    
    initial begin
    
    end 
    
endmodule
