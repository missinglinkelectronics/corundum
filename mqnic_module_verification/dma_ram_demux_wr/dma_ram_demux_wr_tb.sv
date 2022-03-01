module dma_ram_demux_wr_tb
  (
   input wire		 clk,

   /*
    * RAM interface (from DMA interface)
    */
   input wire [2*2-1:0]  ctrl_wr_cmd_sel,
   input wire [2*8-1:0]  ctrl_wr_cmd_be,
   input wire [2*8-1:0]  ctrl_wr_cmd_addr,
   input wire [2*64-1:0] ctrl_wr_cmd_data,
   input wire [2-1:0]	 ctrl_wr_cmd_valid,

   );



   localparam PORTS = 2;
   // RAM segment count
   localparam SEG_COUNT = 2;
   // RAM segment data width
   localparam SEG_DATA_WIDTH = 64;
   // RAM segment address width
   localparam SEG_ADDR_WIDTH = 8;
   // RAM segment byte enable width
   localparam SEG_BE_WIDTH = SEG_DATA_WIDTH/8;
   // Input RAM segment select width
   localparam S_RAM_SEL_WIDTH = 2;
   // Output RAM segment select width
   // Additional bits required for response routing
   localparam M_RAM_SEL_WIDTH = S_RAM_SEL_WIDTH+$clog2(PORTS);

   wire			 rst = ~ initial_cycle;




   //original module instance
   wire [SEG_COUNT-1:0]  ctrl_wr_cmd_ready;
   wire [SEG_COUNT-1:0]  ctrl_wr_done;

   wire [PORTS*SEG_COUNT*S_RAM_SEL_WIDTH-1:0] ram_wr_cmd_sel;
   wire [PORTS*SEG_COUNT*SEG_BE_WIDTH-1:0]    ram_wr_cmd_be;
   wire [PORTS*SEG_COUNT*SEG_ADDR_WIDTH-1:0]  ram_wr_cmd_addr;
   wire [PORTS*SEG_COUNT*SEG_DATA_WIDTH-1:0]  ram_wr_cmd_data;
   wire [PORTS*SEG_COUNT-1:0]		      ram_wr_cmd_valid;


   //patched module instance
   wire [SEG_COUNT-1:0]			      ctrl_wr_cmd_ready2;
   wire [SEG_COUNT-1:0]			      ctrl_wr_done2;

   wire [PORTS*SEG_COUNT*S_RAM_SEL_WIDTH-1:0] ram_wr_cmd_sel2;
   wire [PORTS*SEG_COUNT*SEG_BE_WIDTH-1:0]    ram_wr_cmd_be2;
   wire [PORTS*SEG_COUNT*SEG_ADDR_WIDTH-1:0]  ram_wr_cmd_addr2;
   wire [PORTS*SEG_COUNT*SEG_DATA_WIDTH-1:0]  ram_wr_cmd_data2;
   wire [PORTS*SEG_COUNT-1:0]		      ram_wr_cmd_valid2;

   reg					      initial_cycle;

   initial
     initial_cycle <= 1'b0;

   always @(posedge clk) begin
      initial_cycle <= 1'b1;

      if (initial_cycle == 1'b1) begin
	 cover(ctrl_wr_done);
      end

   end


   dma_ram_demux_wr dma_ram_demux_wr_inst
     (
      .clk(clk),
      .rst(rst),
      .ctrl_wr_cmd_sel(ctrl_wr_cmd_sel),
      .ctrl_wr_cmd_be(ctrl_wr_cmd_be),
      .ctrl_wr_cmd_addr(ctrl_wr_cmd_addr),
      .ctrl_wr_cmd_data(ctrl_wr_cmd_data),
      .ctrl_wr_cmd_valid(ctrl_wr_cmd_valid),
      .ctrl_wr_cmd_ready(ctrl_wr_cmd_ready),
      .ctrl_wr_done(ctrl_wr_done),
      .ram_wr_cmd_sel(ram_wr_cmd_sel),
      .ram_wr_cmd_be(ram_wr_cmd_be),
      .ram_wr_cmd_addr(ram_wr_cmd_addr),
      .ram_wr_cmd_data(ram_wr_cmd_data),
      .ram_wr_cmd_valid(ram_wr_cmd_valid),
      .ram_wr_cmd_ready(ram_wr_cmd_ready),
      .ram_wr_done(ram_wr_done)
      );


   dma_ram_demux_wr_patched dma_ram_demux_wr_patched_inst
     (
      .clk(clk),
      .rst(rst),
      .ctrl_wr_cmd_sel(ctrl_wr_cmd_sel),
      .ctrl_wr_cmd_be(ctrl_wr_cmd_be),
      .ctrl_wr_cmd_addr(ctrl_wr_cmd_addr),
      .ctrl_wr_cmd_data(ctrl_wr_cmd_data),
      .ctrl_wr_cmd_valid(ctrl_wr_cmd_valid),
      .ctrl_wr_cmd_ready(ctrl_wr_cmd_ready2),
      .ctrl_wr_done(ctrl_wr_done2),
      .ram_wr_cmd_sel(ram_wr_cmd_sel2),
      .ram_wr_cmd_be(ram_wr_cmd_be2),
      .ram_wr_cmd_addr(ram_wr_cmd_addr2),
      .ram_wr_cmd_data(ram_wr_cmd_data2),
      .ram_wr_cmd_valid(ram_wr_cmd_valid2),
      .ram_wr_cmd_ready(ram_wr_cmd_ready),
      .ram_wr_done(ram_wr_done)
      );



   always @(posedge clk)
     begin
	assert(ctrl_wr_cmd_ready == ctrl_wr_cmd_ready2);
	assert(ctrl_wr_done      == ctrl_wr_done2);
	assert(ram_wr_cmd_sel    == ram_wr_cmd_sel2);
	assert(ram_wr_cmd_be     == ram_wr_cmd_be2);
	assert(ram_wr_cmd_addr   == ram_wr_cmd_addr2);
	assert(ram_wr_cmd_data   == ram_wr_cmd_data2);
	assert(ram_wr_cmd_valid  == ram_wr_cmd_valid2);
     end

endmodule
