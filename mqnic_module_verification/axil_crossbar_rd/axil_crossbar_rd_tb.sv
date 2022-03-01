module axil_crossbar_rd_tb #
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

    input  wire [S_COUNT*ADDR_WIDTH-1:0]    s_axil_araddr,
    input  wire [S_COUNT*3-1:0]             s_axil_arprot,
    input  wire [S_COUNT-1:0]               s_axil_arvalid,
    input  wire [S_COUNT-1:0]               s_axil_rready,
    input  wire [M_COUNT-1:0]               m_axil_arready,
    input  wire [M_COUNT*DATA_WIDTH-1:0]    m_axil_rdata,
    input  wire [M_COUNT*2-1:0]             m_axil_rresp,
    input  wire [M_COUNT-1:0]               m_axil_rvalid,
   );

   wire [S_COUNT-1:0]			    s_axil_arready;
   wire [S_COUNT*DATA_WIDTH-1:0]	    s_axil_rdata;
   wire [S_COUNT*2-1:0]			    s_axil_rresp;
   wire [S_COUNT-1:0]			    s_axil_rvalid;
   wire [M_COUNT*ADDR_WIDTH-1:0]	    m_axil_araddr;
   wire [M_COUNT*3-1:0]			    m_axil_arprot;
   wire [M_COUNT-1:0]			    m_axil_arvalid;
   wire [M_COUNT-1:0]			    m_axil_rready;



   wire [S_COUNT-1:0]			    s_axil_arready2;
   wire [S_COUNT*DATA_WIDTH-1:0]	    s_axil_rdata2;
   wire [S_COUNT*2-1:0]			    s_axil_rresp2;
   wire [S_COUNT-1:0]			    s_axil_rvalid2;
   wire [M_COUNT*ADDR_WIDTH-1:0]	    m_axil_araddr2;
   wire [M_COUNT*3-1:0]			    m_axil_arprot2;
   wire [M_COUNT-1:0]			    m_axil_arvalid2;
   wire [M_COUNT-1:0]			    m_axil_rready2;



   wire				       rst = ~ initial_cycle;
   reg				       initial_cycle;


   initial
     initial_cycle <= 1'b0;

   always @(posedge clk) begin
      initial_cycle <= 1'b1;

      if (initial_cycle == 1'b1) begin
	 //cover(ctrl_wr_done);
      end

   end


   axil_crossbar_rd axil_crossbar_rd_inst
     (
      .clk(clk),
      .rst(rst),
      .s_axil_araddr(s_axil_araddr),
      .s_axil_arprot(s_axil_arprot),
      .s_axil_arvalid(s_axil_arvalid),
      .s_axil_arready(s_axil_arready),
      .s_axil_rdata(s_axil_rdata),
      .s_axil_rresp(s_axil_rresp),
      .s_axil_rvalid(s_axil_rvalid),
      .s_axil_rready(s_axil_rready),
      .m_axil_araddr(m_axil_araddr),
      .m_axil_arprot(m_axil_arprot),
      .m_axil_arvalid(m_axil_arvalid),
      .m_axil_arready(m_axil_arready),
      .m_axil_rdata(m_axil_rdata),
      .m_axil_rresp(m_axil_rresp),
      .m_axil_rvalid(m_axil_rvalid),
      .m_axil_rready(m_axil_rready)
      );


   axil_crossbar_rd_patched axil_crossbar_rd_patched_inst
     (
      .clk(clk),
      .rst(rst),
      .s_axil_araddr(s_axil_araddr),
      .s_axil_arprot(s_axil_arprot),
      .s_axil_arvalid(s_axil_arvalid),
      .s_axil_arready(s_axil_arready2),
      .s_axil_rdata(s_axil_rdata2),
      .s_axil_rresp(s_axil_rresp2),
      .s_axil_rvalid(s_axil_rvalid2),
      .s_axil_rready(s_axil_rready),
      .m_axil_araddr(m_axil_araddr2),
      .m_axil_arprot(m_axil_arprot2),
      .m_axil_arvalid(m_axil_arvalid2),
      .m_axil_arready(m_axil_arready),
      .m_axil_rdata(m_axil_rdata),
      .m_axil_rresp(m_axil_rresp),
      .m_axil_rvalid(m_axil_rvalid),
      .m_axil_rready(m_axil_rready2)
      );



   always @(posedge clk)
     begin
	assert(s_axil_arready == s_axil_arready2);
	assert(s_axil_rdata   == s_axil_rdata2);
	assert(s_axil_rresp   == s_axil_rresp2);
	assert(s_axil_rvalid  == s_axil_rvalid2);
	assert(m_axil_araddr  == m_axil_araddr2);
	assert(m_axil_arprot  == m_axil_arprot2);
	assert(m_axil_arvalid == m_axil_arvalid2);
	assert(m_axil_rready  == m_axil_rready2);
     end


endmodule // axil_crossbar_rd_tb
