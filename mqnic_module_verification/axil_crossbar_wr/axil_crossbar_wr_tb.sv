module axil_crossbar_wr_tb #
(
    // Number of AXI inputs (slave interfaces)
    parameter S_COUNT = 4,
    // Number of AXI outputs (master interfaces)
    parameter M_COUNT = 4,
    // Width of data bus in bits
    parameter DATA_WIDTH = 32,
    // Width of address bus in bits
    parameter ADDR_WIDTH = 32,
    // Width of wstrb (width of data bus in words)
    parameter STRB_WIDTH = (DATA_WIDTH/8),
    // Number of concurrent operations for each slave interface
    // S_COUNT concatenated fields of 32 bits
    parameter S_ACCEPT = {S_COUNT{32'd16}},
    // Number of regions per master interface
    parameter M_REGIONS = 1,
    // Master interface base addresses
    // M_COUNT concatenated fields of M_REGIONS concatenated fields of ADDR_WIDTH bits
    // set to zero for default addressing based on M_ADDR_WIDTH
    parameter M_BASE_ADDR = 0,
    // Master interface address widths
    // M_COUNT concatenated fields of M_REGIONS concatenated fields of 32 bits
    parameter M_ADDR_WIDTH = {M_COUNT{{M_REGIONS{32'd24}}}},
    // Write connections between interfaces
    // M_COUNT concatenated fields of S_COUNT bits
    parameter M_CONNECT = {M_COUNT{{S_COUNT{1'b1}}}},
    // Number of concurrent operations for each master interface
    // M_COUNT concatenated fields of 32 bits
    parameter M_ISSUE = {M_COUNT{32'd16}},
    // Secure master (fail operations based on awprot/arprot)
    // M_COUNT bits
    parameter M_SECURE = {M_COUNT{1'b0}},
    // Slave interface AW channel register type (input)
    // 0 to bypass, 1 for simple buffer, 2 for skid buffer
    parameter S_AW_REG_TYPE = {S_COUNT{2'd0}},
    // Slave interface W channel register type (input)
    // 0 to bypass, 1 for simple buffer, 2 for skid buffer
    parameter S_W_REG_TYPE = {S_COUNT{2'd0}},
    // Slave interface B channel register type (output)
    // 0 to bypass, 1 for simple buffer, 2 for skid buffer
    parameter S_B_REG_TYPE = {S_COUNT{2'd1}},
    // Master interface AW channel register type (output)
    // 0 to bypass, 1 for simple buffer, 2 for skid buffer
    parameter M_AW_REG_TYPE = {M_COUNT{2'd1}},
    // Master interface W channel register type (output)
    // 0 to bypass, 1 for simple buffer, 2 for skid buffer
    parameter M_W_REG_TYPE = {M_COUNT{2'd2}},
    // Master interface B channel register type (input)
    // 0 to bypass, 1 for simple buffer, 2 for skid buffer
    parameter M_B_REG_TYPE = {M_COUNT{2'd0}}
)




  (
   input wire			       clk,

   /*
    * AXI lite slave interfaces
    */
   input wire [S_COUNT*ADDR_WIDTH-1:0] s_axil_awaddr,
   input wire [S_COUNT*3-1:0]	       s_axil_awprot,
   input wire [S_COUNT-1:0]	       s_axil_awvalid,
   input wire [S_COUNT*DATA_WIDTH-1:0] s_axil_wdata,
   input wire [S_COUNT*STRB_WIDTH-1:0] s_axil_wstrb,
   input wire [S_COUNT-1:0]	       s_axil_wvalid,

   input wire [S_COUNT-1:0]	       s_axil_bready,
   input wire [M_COUNT-1:0]	       m_axil_awready,

   input wire [M_COUNT-1:0]	       m_axil_wready,
   input wire [M_COUNT*2-1:0]	       m_axil_bresp,
   input wire [M_COUNT-1:0]	       m_axil_bvalid

   );


   wire [S_COUNT-1:0]		       s_axil_awready;
   wire [S_COUNT-1:0]		       s_axil_wready;
   wire [S_COUNT*2-1:0]		       s_axil_bresp;
   wire [S_COUNT-1:0]		       s_axil_bvalid;
   wire [M_COUNT*ADDR_WIDTH-1:0]       m_axil_awaddr;
   wire [M_COUNT*3-1:0]		       m_axil_awprot;
   wire [M_COUNT-1:0]		       m_axil_awvalid;
   wire [M_COUNT*DATA_WIDTH-1:0]       m_axil_wdata;
   wire [M_COUNT*STRB_WIDTH-1:0]       m_axil_wstrb;
   wire [M_COUNT-1:0]		       m_axil_wvalid;
   wire [M_COUNT-1:0]		       m_axil_bready;


   wire [S_COUNT-1:0]		       s_axil_awready2;
   wire [S_COUNT-1:0]		       s_axil_wready2;
   wire [S_COUNT*2-1:0]		       s_axil_bresp2;
   wire [S_COUNT-1:0]		       s_axil_bvalid2;
   wire [M_COUNT*ADDR_WIDTH-1:0]       m_axil_awaddr2;
   wire [M_COUNT*3-1:0]		       m_axil_awprot2;
   wire [M_COUNT-1:0]		       m_axil_awvalid2;
   wire [M_COUNT*DATA_WIDTH-1:0]       m_axil_wdata2;
   wire [M_COUNT*STRB_WIDTH-1:0]       m_axil_wstrb2;
   wire [M_COUNT-1:0]		       m_axil_wvalid2;
   wire [M_COUNT-1:0]		       m_axil_bready2;

   wire				       rst = ~ initial_cycle;
   reg				       initial_cycle;


   initial
     initial_cycle <= 1'b0;

   always @(posedge clk) begin
      initial_cycle <= 1'b1;

      if (initial_cycle == 1'b1) begin
	 cover(m_axil_awready);
      end

   end


   axil_crossbar_wr axil_crossbar_wr_inst
     (
      .clk(clk),
      .rst(rst),
      .s_axil_awaddr(s_axil_awaddr),
      .s_axil_awprot(s_axil_awprot),
      .s_axil_awvalid(s_axil_awvalid),
      .s_axil_awready(s_axil_awready),
      .s_axil_wdata(s_axil_wdata),
      .s_axil_wstrb(s_axil_wstrb),
      .s_axil_wvalid(s_axil_wvalid),
      .s_axil_wready(s_axil_wready),
      .s_axil_bresp(s_axil_bresp),
      .s_axil_bvalid(s_axil_bvalid),
      .s_axil_bready(s_axil_bready),
      .m_axil_awaddr(m_axil_awaddr),
      .m_axil_awprot(m_axil_awprot),
      .m_axil_awvalid(m_axil_awvalid),
      .m_axil_awready(m_axil_awready),
      .m_axil_wdata(m_axil_wdata),
      .m_axil_wstrb(m_axil_wstrb),
      .m_axil_wvalid(m_axil_wvalid),
      .m_axil_wready(m_axil_wready),
      .m_axil_bresp(m_axil_bresp),
      .m_axil_bvalid(m_axil_bvalid),
      .m_axil_bready(m_axil_bready),
      );


   axil_crossbar_wr_patched axil_crossbar_wr_patched_inst
     (
      .clk(clk),
      .rst(rst),
      .s_axil_awaddr(s_axil_awaddr),
      .s_axil_awprot(s_axil_awprot),
      .s_axil_awvalid(s_axil_awvalid),
      .s_axil_awready(s_axil_awready2),
      .s_axil_wdata(s_axil_wdata),
      .s_axil_wstrb(s_axil_wstrb),
      .s_axil_wvalid(s_axil_wvalid),
      .s_axil_wready(s_axil_wready2),
      .s_axil_bresp(s_axil_bresp2),
      .s_axil_bvalid(s_axil_bvalid2),
      .s_axil_bready(s_axil_bready),
      .m_axil_awaddr(m_axil_awaddr2),
      .m_axil_awprot(m_axil_awprot2),
      .m_axil_awvalid(m_axil_awvalid2),
      .m_axil_awready(m_axil_awready),
      .m_axil_wdata(m_axil_wdata2),
      .m_axil_wstrb(m_axil_wstrb2),
      .m_axil_wvalid(m_axil_wvalid2),
      .m_axil_wready(m_axil_wready),
      .m_axil_bresp(m_axil_bresp),
      .m_axil_bvalid(m_axil_bvalid),
      .m_axil_bready(m_axil_bready2),
      );



   always @(posedge clk)
     begin
	assert(s_axil_awready ==  s_axil_awready2);
	assert(s_axil_wready  ==  s_axil_wready2);
	assert(s_axil_bresp   ==  s_axil_bresp2);
	assert(s_axil_bvalid  ==  s_axil_bvalid2);
	assert(m_axil_awaddr  ==  m_axil_awaddr2);
	assert(m_axil_awprot  ==  m_axil_awprot2);
	assert(m_axil_awvalid ==  m_axil_awvalid2);
	assert(m_axil_wdata   ==  m_axil_wdata2);
	assert(m_axil_wstrb   ==  m_axil_wstrb2);
	assert(m_axil_wvalid  ==  m_axil_wvalid2);
	assert(m_axil_bready  ==  m_axil_bready2);
     end


endmodule // axil_crossbar_wr_tb
