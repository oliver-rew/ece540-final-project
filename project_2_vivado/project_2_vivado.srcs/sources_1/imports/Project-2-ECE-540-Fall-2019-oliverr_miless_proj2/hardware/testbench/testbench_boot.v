// testbench_boot.v
// 3 March 2015
//
// Drive the mipsfpga_sys module for simulation testing. Stop simulation: 
//    1. After data cache has been enabled
//    2. At the beginning of user code execution
//

`timescale 100ps/1ps

`include "mfp_ahb_const.vh"

module testbench_boot;

    reg                    SI_Reset_N, SI_ClkIn;
    wire [31           :0] HADDR, HRDATA, HWDATA;
    wire                   HWRITE;
	wire [ 2           :0] HSIZE;
    reg                    EJ_TRST_N_probe, EJ_TDI; 
    wire                   EJ_TDO;
    reg                    SI_ColdReset_N;
    reg                    EJ_TMS, EJ_TCK, EJ_DINT;
    reg  [`MFP_N_SW-1  :0] IO_Switch;
    reg  [          4  :0] IO_PB;
    wire [`MFP_N_LED-1 :0] IO_LED;
    reg                    UART_RX;
    reg                    program_started;
                    
    mfp_sys sys (.SI_Reset_N(SI_Reset_N),
                 .SI_ClkIn(SI_ClkIn),
                 .HADDR(HADDR), 
                 .HRDATA(HRDATA), 
                 .HWDATA(HWDATA), 
                 .HWRITE(HWRITE), 
                 .HSIZE(HSIZE),
                 .EJ_TRST_N_probe(EJ_TRST_N_probe), 
                 .EJ_TDI(EJ_TDI), 
                 .EJ_TDO(EJ_TDO), 
                 .EJ_TMS(EJ_TMS), 
                 .EJ_TCK(EJ_TCK), 
                 .SI_ColdReset_N(SI_ColdReset_N), 
                 .EJ_DINT(EJ_DINT),
                 .IO_Switch(IO_Switch), 
                 .IO_PB(IO_PB), 
                 .IO_LED(IO_LED), 
                 .UART_RX(UART_RX)
    );

    initial
    begin
        SI_ClkIn = 0;
        EJ_TRST_N_probe = 1; EJ_TDI = 0; EJ_TMS = 0; EJ_TCK = 0; EJ_DINT = 0;
        UART_RX = 1;
        program_started = 0;
        SI_ColdReset_N = 1;
        IO_Switch = 18'h2b;
        IO_PB = 5'h0;
        forever
            #50 SI_ClkIn = ~ SI_ClkIn;
    end

    initial
    begin
        SI_Reset_N  <= 0;
        repeat (10)  @(posedge SI_ClkIn);
        SI_Reset_N  <= 1;
    end

    initial
    begin
        $dumpvars;
        $timeformat (-9, 1, "ns", 10);
    end

    always @(negedge SI_ClkIn)
      if (HADDR == 32'h1fc000cc) begin
        $display("Data cache initialized. About to make kseg0 cacheable.");
        $stop;
      end
      else if (HADDR > 32'h00000250 & HADDR < 32'h1fc00000 & ~program_started) begin
        program_started = 1;
        $display("Beginning of program code.");
        $stop;
      end
endmodule



