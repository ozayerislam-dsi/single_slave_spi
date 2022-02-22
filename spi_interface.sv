interface spi_interface;
    logic spi_clk;
    logic cs_;
    logic miso;
    logic mosi;
    
    modport master (
        output spi_clk, cs_, mosi,
        input miso
    );
    
    modport slave (
        input spi_clk, cs_, mosi,
        output miso
    );
        
endinterface