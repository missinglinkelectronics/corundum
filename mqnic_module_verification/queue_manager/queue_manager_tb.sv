module queue_manager_tb #
  (
    // Base address width
    parameter ADDR_WIDTH = 64,
    // Request tag field width
    parameter REQ_TAG_WIDTH = 8,
    // Number of outstanding operations
    parameter OP_TABLE_SIZE = 16,
    // Operation tag field width
    parameter OP_TAG_WIDTH = 8,
    // Queue index width (log2 of number of queues)
    parameter QUEUE_INDEX_WIDTH = 8,
    // Completion queue index width
    parameter CPL_INDEX_WIDTH = 8,
    // Queue element pointer width (log2 of number of elements)
    parameter QUEUE_PTR_WIDTH = 16,
    // Log queue size field width
    parameter LOG_QUEUE_SIZE_WIDTH = $clog2(QUEUE_PTR_WIDTH),
    // Queue element size
    parameter DESC_SIZE = 16,
    // Log desc block size field width
    parameter LOG_BLOCK_SIZE_WIDTH = 2,
    // Pipeline stages
    parameter PIPELINE = 2, // TODO: patch for PIPELINE = 3
    // Width of AXI lite data bus in bits
    parameter AXIL_DATA_WIDTH = 32,
    // Width of AXI lite address bus in bits
    parameter AXIL_ADDR_WIDTH = 16,
    // Width of AXI lite wstrb (width of data bus in words)
    parameter AXIL_STRB_WIDTH = (AXIL_DATA_WIDTH/8)

   )
  (
   input wire			      clk,

   /*
    * Dequeue request input
    */
   input wire [QUEUE_INDEX_WIDTH-1:0] s_axis_dequeue_req_queue,
   input wire [REQ_TAG_WIDTH-1:0]     s_axis_dequeue_req_tag,
   input wire			      s_axis_dequeue_req_valid,

   input wire			      m_axis_dequeue_resp_ready,

   /*
    * Dequeue commit input
    */
   input wire [OP_TAG_WIDTH-1:0]      s_axis_dequeue_commit_op_tag,
   input wire			      s_axis_dequeue_commit_valid,

   input wire [AXIL_ADDR_WIDTH-1:0]   s_axil_awaddr,
   input wire [2:0]		      s_axil_awprot,
   input wire			      s_axil_awvalid,

   input wire [AXIL_DATA_WIDTH-1:0]   s_axil_wdata,
   input wire [AXIL_STRB_WIDTH-1:0]   s_axil_wstrb,
   input wire			      s_axil_wvalid,

   input wire			      s_axil_bready,
   input wire [AXIL_ADDR_WIDTH-1:0]   s_axil_araddr,
   input wire [2:0]		      s_axil_arprot,
   input wire			      s_axil_arvalid,

   input wire			      s_axil_rready,

   /*
    * Configuration
    */
   input wire			      enable



   );

   reg				      initial_cycle;

   wire				      rst = ~ initial_cycle;





   wire				      s_axis_dequeue_req_ready;
   wire [QUEUE_INDEX_WIDTH-1:0]       m_axis_dequeue_resp_queue;
   wire [QUEUE_PTR_WIDTH-1:0]	      m_axis_dequeue_resp_ptr;
   wire [ADDR_WIDTH-1:0]	      m_axis_dequeue_resp_addr;
   wire [LOG_BLOCK_SIZE_WIDTH-1:0]    m_axis_dequeue_resp_block_size;
   wire [CPL_INDEX_WIDTH-1:0]	      m_axis_dequeue_resp_cpl;
   wire [REQ_TAG_WIDTH-1:0]	      m_axis_dequeue_resp_tag;
   wire [OP_TAG_WIDTH-1:0]	      m_axis_dequeue_resp_op_tag;
   wire				      m_axis_dequeue_resp_empty;
   wire				      m_axis_dequeue_resp_error;
   wire				      m_axis_dequeue_resp_valid;
   wire				      s_axis_dequeue_commit_ready;
   wire [QUEUE_INDEX_WIDTH-1:0]       m_axis_doorbell_queue;
   wire				      m_axis_doorbell_valid;
   wire				      s_axil_awready;
   wire				      s_axil_wready;
   wire [1:0]			      s_axil_bresp;
   wire				      s_axil_bvalid;
   wire				      s_axil_arready;
   wire [AXIL_DATA_WIDTH-1:0]	      s_axil_rdata;
   wire [1:0]			      s_axil_rresp;
   wire				      s_axil_rvalid;



   wire				      s_axis_dequeue_req_ready2;
   wire [QUEUE_INDEX_WIDTH-1:0]       m_axis_dequeue_resp_queue2;
   wire [QUEUE_PTR_WIDTH-1:0]	      m_axis_dequeue_resp_ptr2;
   wire [ADDR_WIDTH-1:0]	      m_axis_dequeue_resp_addr2;
   wire [LOG_BLOCK_SIZE_WIDTH-1:0]    m_axis_dequeue_resp_block_size2;
   wire [CPL_INDEX_WIDTH-1:0]	      m_axis_dequeue_resp_cpl2;
   wire [REQ_TAG_WIDTH-1:0]	      m_axis_dequeue_resp_tag2;
   wire [OP_TAG_WIDTH-1:0]	      m_axis_dequeue_resp_op_tag2;
   wire				      m_axis_dequeue_resp_empty2;
   wire				      m_axis_dequeue_resp_error2;
   wire				      m_axis_dequeue_resp_valid2;
   wire				      s_axis_dequeue_commit_ready2;
   wire [QUEUE_INDEX_WIDTH-1:0]       m_axis_doorbell_queue2;
   wire				      m_axis_doorbell_valid2;
   wire				      s_axil_awready2;
   wire				      s_axil_wready2;
   wire [1:0]			      s_axil_bresp2;
   wire				      s_axil_bvalid2;
   wire				      s_axil_arready2;
   wire [AXIL_DATA_WIDTH-1:0]	      s_axil_rdata2;
   wire [1:0]			      s_axil_rresp2;
   wire				      s_axil_rvalid2;






   initial
     initial_cycle <= 1'b0;

   always @(posedge clk) begin
      initial_cycle <= 1'b1;

      if (initial_cycle == 1'b1) begin
	 cover(m_axis_doorbell_valid2);
      end

   end


queue_manager queue_manager_inst
  (
   .clk(clk),
   .rst(rst),
   .s_axis_dequeue_req_queue(s_axis_dequeue_req_queue),
   .s_axis_dequeue_req_tag(s_axis_dequeue_req_tag),
   .s_axis_dequeue_req_valid(s_axis_dequeue_req_valid),
   .s_axis_dequeue_req_ready(s_axis_dequeue_req_ready),
   .m_axis_dequeue_resp_queue(m_axis_dequeue_resp_queue),
   .m_axis_dequeue_resp_ptr(m_axis_dequeue_resp_ptr),
   .m_axis_dequeue_resp_addr(m_axis_dequeue_resp_addr),
   .m_axis_dequeue_resp_block_size(m_axis_dequeue_resp_block_size),
   .m_axis_dequeue_resp_cpl(m_axis_dequeue_resp_cpl),
   .m_axis_dequeue_resp_tag(m_axis_dequeue_resp_tag),
   .m_axis_dequeue_resp_op_tag(m_axis_dequeue_resp_op_tag),
   .m_axis_dequeue_resp_empty(m_axis_dequeue_resp_empty),
   .m_axis_dequeue_resp_error(m_axis_dequeue_resp_error),
   .m_axis_dequeue_resp_valid(m_axis_dequeue_resp_valid),
   .m_axis_dequeue_resp_ready(m_axis_dequeue_resp_ready),
   .s_axis_dequeue_commit_op_tag(s_axis_dequeue_commit_op_tag),
   .s_axis_dequeue_commit_valid(s_axis_dequeue_commit_valid),
   .s_axis_dequeue_commit_ready(s_axis_dequeue_commit_ready),
   .m_axis_doorbell_queue(m_axis_doorbell_queue),
   .m_axis_doorbell_valid(m_axis_doorbell_valid),
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
   .s_axil_araddr(s_axil_araddr),
   .s_axil_arprot(s_axil_arprot),
   .s_axil_arvalid(s_axil_arvalid),
   .s_axil_arready(s_axil_arready),
   .s_axil_rdata(s_axil_rdata),
   .s_axil_rresp(s_axil_rresp),
   .s_axil_rvalid(s_axil_rvalid),
   .s_axil_rready(s_axil_rready),
   .enable(enable)
);


queue_manager_patched queue_manager_patched_inst
(
   .clk(clk),
   .rst(rst),
   .s_axis_dequeue_req_queue(s_axis_dequeue_req_queue),
   .s_axis_dequeue_req_tag(s_axis_dequeue_req_tag),
   .s_axis_dequeue_req_valid(s_axis_dequeue_req_valid),
   .s_axis_dequeue_req_ready(s_axis_dequeue_req_ready2),
   .m_axis_dequeue_resp_queue(m_axis_dequeue_resp_queue2),
   .m_axis_dequeue_resp_ptr(m_axis_dequeue_resp_ptr2),
   .m_axis_dequeue_resp_addr(m_axis_dequeue_resp_addr2),
   .m_axis_dequeue_resp_block_size(m_axis_dequeue_resp_block_size2),
   .m_axis_dequeue_resp_cpl(m_axis_dequeue_resp_cpl2),
   .m_axis_dequeue_resp_tag(m_axis_dequeue_resp_tag2),
   .m_axis_dequeue_resp_op_tag(m_axis_dequeue_resp_op_tag2),
   .m_axis_dequeue_resp_empty(m_axis_dequeue_resp_empty2),
   .m_axis_dequeue_resp_error(m_axis_dequeue_resp_error2),
   .m_axis_dequeue_resp_valid(m_axis_dequeue_resp_valid2),
   .m_axis_dequeue_resp_ready(m_axis_dequeue_resp_ready),
   .s_axis_dequeue_commit_op_tag(s_axis_dequeue_commit_op_tag),
   .s_axis_dequeue_commit_valid(s_axis_dequeue_commit_valid),
   .s_axis_dequeue_commit_ready(s_axis_dequeue_commit_ready2),
   .m_axis_doorbell_queue(m_axis_doorbell_queue2),
   .m_axis_doorbell_valid(m_axis_doorbell_valid2),
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
   .s_axil_araddr(s_axil_araddr),
   .s_axil_arprot(s_axil_arprot),
   .s_axil_arvalid(s_axil_arvalid),
   .s_axil_arready(s_axil_arready2),
   .s_axil_rdata(s_axil_rdata2),
   .s_axil_rresp(s_axil_rresp2),
   .s_axil_rvalid(s_axil_rvalid2),
   .s_axil_rready(s_axil_rready),
   .enable(enable)
);



always @(posedge clk)
begin
   assert(s_axis_dequeue_req_ready       ==   s_axis_dequeue_req_ready2);
   assert(m_axis_dequeue_resp_queue      ==   m_axis_dequeue_resp_queue2);
   assert(m_axis_dequeue_resp_ptr        ==   m_axis_dequeue_resp_ptr2);
   assert(m_axis_dequeue_resp_addr       ==   m_axis_dequeue_resp_addr2);
   assert(m_axis_dequeue_resp_block_size ==   m_axis_dequeue_resp_block_size2);
   assert(m_axis_dequeue_resp_cpl        ==   m_axis_dequeue_resp_cpl2);
   assert(m_axis_dequeue_resp_tag        ==   m_axis_dequeue_resp_tag2);
   assert(m_axis_dequeue_resp_op_tag     ==   m_axis_dequeue_resp_op_tag2);
   assert(m_axis_dequeue_resp_empty      ==   m_axis_dequeue_resp_empty2);
   assert(m_axis_dequeue_resp_error      ==   m_axis_dequeue_resp_error2);
   assert(m_axis_dequeue_resp_valid      ==   m_axis_dequeue_resp_valid2);
   assert(s_axis_dequeue_commit_ready    ==   s_axis_dequeue_commit_ready2);
   assert(m_axis_doorbell_queue          ==   m_axis_doorbell_queue2);
   assert(m_axis_doorbell_valid          ==   m_axis_doorbell_valid2);
   assert(s_axil_awready                 ==   s_axil_awready2);
   assert(s_axil_wready                  ==   s_axil_wready2);
   assert(s_axil_bresp                   ==   s_axil_bresp2);
   assert(s_axil_bvalid                  ==   s_axil_bvalid2);
   assert(s_axil_arready                 ==   s_axil_arready2);
   assert(s_axil_rdata                   ==   s_axil_rdata2);
   assert(s_axil_rresp                   ==   s_axil_rresp2);
   assert(s_axil_rvalid                  ==   s_axil_rvalid2);
end


endmodule
