module dma_ram_demux_rd_tb
  (
   input wire					   clk,

   /*
    * RAM interface (from DMA interface)
    */

   input wire [SEG_COUNT*M_RAM_SEL_WIDTH-1:0]	   ctrl_rd_cmd_sel,
   input wire [SEG_COUNT*SEG_ADDR_WIDTH-1:0]	   ctrl_rd_cmd_addr,
   input wire [SEG_COUNT-1:0]			   ctrl_rd_cmd_valid,
   input wire [SEG_COUNT-1:0]			   ctrl_rd_resp_ready,
   input wire [PORTS*SEG_COUNT-1:0]		   ram_rd_cmd_ready,
   input wire [PORTS*SEG_COUNT*SEG_DATA_WIDTH-1:0] ram_rd_resp_data,
   input wire [PORTS*SEG_COUNT-1:0]		   ram_rd_resp_valid



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

   wire						   rst = ~ initial_cycle;




   //original module instance
   wire [SEG_COUNT-1:0]				   ctrl_rd_cmd_ready;
   wire [SEG_COUNT*SEG_DATA_WIDTH-1:0]		   ctrl_rd_resp_data;
   wire [SEG_COUNT-1:0]				   ctrl_rd_resp_valid;
   wire [PORTS*SEG_COUNT*S_RAM_SEL_WIDTH-1:0]	   ram_rd_cmd_sel;
   wire [PORTS*SEG_COUNT*SEG_ADDR_WIDTH-1:0]	   ram_rd_cmd_addr;
   wire [PORTS*SEG_COUNT-1:0]			   ram_rd_cmd_valid;
   wire [PORTS*SEG_COUNT-1:0]			   ram_rd_resp_ready;



   //patched module instance
   wire [SEG_COUNT-1:0]				   ctrl_rd_cmd_ready2;
   wire [SEG_COUNT*SEG_DATA_WIDTH-1:0]		   ctrl_rd_resp_data2;
   wire [SEG_COUNT-1:0]				   ctrl_rd_resp_valid2;
   wire [PORTS*SEG_COUNT*S_RAM_SEL_WIDTH-1:0]	   ram_rd_cmd_sel2;
   wire [PORTS*SEG_COUNT*SEG_ADDR_WIDTH-1:0]	   ram_rd_cmd_addr2;
   wire [PORTS*SEG_COUNT-1:0]			   ram_rd_cmd_valid2;
   wire [PORTS*SEG_COUNT-1:0]			   ram_rd_resp_ready2;

   reg						   initial_cycle;

   initial
     initial_cycle <= 1'b0;

   always @(posedge clk) begin
      initial_cycle <= 1'b1;

      if (initial_cycle == 1'b1) begin
	 cover(ctrl_wr_done);
      end

   end


   dma_ram_demux_rd dma_ram_demux_rd_inst
     (
      .clk(clk),
      .rst(rst),
      .ctrl_rd_cmd_sel(ctrl_rd_cmd_sel),
      .ctrl_rd_cmd_addr(ctrl_rd_cmd_addr),
      .ctrl_rd_cmd_valid(ctrl_rd_cmd_valid),
      .ctrl_rd_cmd_ready(ctrl_rd_cmd_ready),
      .ctrl_rd_resp_data(ctrl_rd_resp_data),
      .ctrl_rd_resp_valid(ctrl_rd_resp_valid),
      .ctrl_rd_resp_ready(ctrl_rd_resp_ready),
      .ram_rd_cmd_sel(ram_rd_cmd_sel),
      .ram_rd_cmd_addr(ram_rd_cmd_addr),
      .ram_rd_cmd_valid(ram_rd_cmd_valid),
      .ram_rd_cmd_ready(ram_rd_cmd_ready),
      .ram_rd_resp_data(ram_rd_resp_data),
      .ram_rd_resp_valid(ram_rd_resp_valid),
      .ram_rd_resp_ready(ram_rd_resp_ready)
      );


   dma_ram_demux_rd_patched dma_ram_demux_rd_patched_inst
     (
      .clk(clk),
      .rst(rst),
      .ctrl_rd_cmd_sel(ctrl_rd_cmd_sel),
      .ctrl_rd_cmd_addr(ctrl_rd_cmd_addr),
      .ctrl_rd_cmd_valid(ctrl_rd_cmd_valid),
      .ctrl_rd_cmd_ready(ctrl_rd_cmd_ready2),
      .ctrl_rd_resp_data(ctrl_rd_resp_data2),
      .ctrl_rd_resp_valid(ctrl_rd_resp_valid2),
      .ctrl_rd_resp_ready(ctrl_rd_resp_ready),
      .ram_rd_cmd_sel(ram_rd_cmd_sel2),
      .ram_rd_cmd_addr(ram_rd_cmd_addr2),
      .ram_rd_cmd_valid(ram_rd_cmd_valid2),
      .ram_rd_cmd_ready(ram_rd_cmd_ready),
      .ram_rd_resp_data(ram_rd_resp_data),
      .ram_rd_resp_valid(ram_rd_resp_valid),
      .ram_rd_resp_ready(ram_rd_resp_ready2)
      );



   always @(posedge clk)
     begin
	assert(ctrl_rd_cmd_ready   == ctrl_rd_cmd_ready2);
	assert(ctrl_rd_resp_data   == ctrl_rd_resp_data2);
	assert(ctrl_rd_resp_valid  == ctrl_rd_resp_valid2);
	assert(ram_rd_cmd_sel      == ram_rd_cmd_sel2);
	assert(ram_rd_cmd_addr     == ram_rd_cmd_addr2);
	assert(ram_rd_cmd_valid    == ram_rd_cmd_valid2);
	assert(ram_rd_resp_ready   == ram_rd_resp_ready2);
     end

endmodule
